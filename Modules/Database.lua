local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local LibSerialize = LibStub("LibSerialize")
local LibDeflate = LibStub("LibDeflate")

-- Define default db values
local dbDefaults = {
    profile = {
        dbVersion = 1,
        settings = {
            noteStyle = {
                primary = {
                    font = "Fonts\\FRIZQT__.TTF",
                    fontSize = 14,
                    color = {
                        r = 1,
                        g = 1,
                        b = 1,
                    },
                    outline = false,
                    align = "CENTER",
                },
                role = {
                    font = "Fonts\\FRIZQT__.TTF",
                    fontSize = 14,
                    color = {
                        r = 1,
                        g = 1,
                        b = 1,
                    },
                    outline = false,
                    align = "CENTER",
                },
                roleUsesPrimaryStyle = true,
            }
        },
        notes = {
            positions = {
                primary = nil,
                secondary = nil,
            }
        },
        docs = {},
        internal = {
            movers = false,
            seasons = {
                TWWS1 = "The War Within - Season 1",
            },
            selectedSeason = "TWWS1",
            testText = "This is some test to text with.\nChange it to see how your notes might look.",
            showTestText = false,
        },
    },
}

function DungeonDocs:GetDBDefaults()
    return dbDefaults
end

function DungeonDocs:DB_Init()
    local db = self.db.profile
    db.internal.showTestText = false
end

function DungeonDocs:DB_InitDungeon(dungeonData)
    local db = self.db

    -- TODO: will likely need to add more fine-grained init than this
    if db.profile.docs[dungeonData.name] == nil then
        db.profile.docs[dungeonData.name] = dungeonData
    end
end

-- A table to hold subscriber functions
local dbChangeSubscribers = {}

function DungeonDocs:SubscribeToDBChange(callback)
    table.insert(dbChangeSubscribers, callback)
end

function DungeonDocs:NotifyDBChange()
    for _, callback in ipairs(dbChangeSubscribers) do
        local status, err = pcall(callback)
        if not status then
            error(err)
        end
    end
end

function DungeonDocs:DB_Update(updater)
    updater()
    DungeonDocs:NotifyDBChange()
end

function DungeonDocs:DB_ListProfiles()
    local db = self.db
    return db:GetProfiles()
end

function DungeonDocs:DB_SelectProfile(profileName)
    local db = self.db
    if db:GetCurrentProfile() ~= profileName then -- Only switch if different
        db:SetProfile(profileName)
    end
end

-- Function to export the current profile, excluding the "internal" table
function DungeonDocs:DB_ExportProfile(profileName)
    local profile = self.db.profiles[profileName] -- Access the specified profile data

    if not profile then
        Log("Error exporting, could not find profile " .. profileName)
        return ""
    end

    local profileCopy = {}
    profileCopy = DeepCopy(profile)
    profileCopy.internal = {}

    local serialized = LibSerialize:Serialize(profileCopy)    -- Serialize profile copy
    local compressed = LibDeflate:CompressDeflate(serialized) -- Compress serialized data
    local encoded = LibDeflate:EncodeForPrint(compressed)     -- Encode to Base64
    return encoded
end

-- Function to import a profile from a Base64 string
function DungeonDocs:DB_ImportProfile(destProfileName, encoded)
    local db = self.db
    local destProfile = db.profiles[destProfileName] -- Access the specified profile data

    if destProfile ~= nil then
        Log("Error importing, profile already exists: " .. destProfileName)
        return
    end

    -- Step 1: Decode, decompress, and deserialize the profile string
    local decoded = LibDeflate:DecodeForPrint(encoded)                  -- Decode Base64
    local decompressed = LibDeflate:DecompressDeflate(decoded)          -- Decompress
    local success, profileData = LibSerialize:Deserialize(decompressed) -- Deserialize to table

    if success then
        -- Init dest profile
        db.profiles[destProfileName] = {}
        -- Step 2: Clear the current profile and apply imported data
        for k, v in pairs(profileData) do
            db.profiles[destProfileName][k] = v -- Copy imported data to current profile
        end

        -- Add the internal defaults
        db.profiles[destProfileName].internal = DeepCopy(dbDefaults.profile.internal)

        Log("Success! Imported profile " .. destProfileName)
        return true
    else
        Log("Error! Could not import profile " .. destProfileName)
        return false
    end
end

function DungeonDocs:DB_CloneProfile(sourceProfileName, destProfileName)
    local db = self.db
    local sourceProfile = db.profiles[sourceProfileName]

    if sourceProfile == nil then
        Log("Error! Could not clone profile, source `" .. sourceProfileName .. "` does not exist")
        return
    end

    if db.profiles[destProfileName] then
        Log("Error! Could not clone profile, destination profile `" .. sourceProfileName .. "` already exists")
        return
    end

    -- Init the profile
    db.profiles[destProfileName] = {}

    -- Copy the source profile
    db.profiles[destProfileName] = DeepCopy(sourceProfile)

    Log("Cloned profile `"..sourceProfileName.."` to profile `"..destProfileName.."`")
end


function DungeonDocs:DB_RenameProfile(sourceProfileName, newProfileName)
    local db = self.db

    -- Check if the current profile exists
    local sourceProfile = db.profiles[sourceProfileName]
    if not sourceProfile then
        Log("Error! Profile does not exist: ", sourceProfileName)
        return
    end

    -- Check if the new profile name is already taken
    if db.profiles[newProfileName] then
        Log("Error! Profile with the name '" .. newProfileName .. "' already exists.")
        return
    end

    -- Copy current profile data to the new profile
    db.profiles[newProfileName] = {}  -- Create an empty table for the new profile
    db.profiles[newProfileName] = DeepCopy(sourceProfile)

    -- If the old profile was active, switch to the new profile
    if db:GetCurrentProfile() == sourceProfileName then
        db:SetProfile(newProfileName)
    end

    -- Delete the old profile
    db.profiles[sourceProfileName] = nil

    Log("Success! Profile renamed from", sourceProfileName, "to", newProfileName)
end

function DungeonDocs:DB_DeleteProfile(profileName)
    local db = self.db

    if profileName == "Default" then
        Log("Error! Cannot delete the default profile")
        return
    end
    -- Check if the profile exists
    if not db.profiles[profileName] then
        Log("Error! Cannot delete, profile does not exist:", profileName)
        return
    end

    -- If the profile being deleted is active, switch to a default profile
    if db:GetCurrentProfile() == profileName then
        db:SetProfile("Default")  -- Switch to "Default" or another fallback profile
    end

    -- Delete the profile
    db.profiles[profileName] = nil
    Log("Profile `".. profileName.."` deleted successfully")
end

function DungeonDocs:DB_ResetProfile(profileName)
    local db = self.db

    if not db.profiles[profileName] then
        Log("Error! Cannot reset, profile does not exist:", profileName)
        return
    end

    -- Clear the profile
    wipe(db.profiles[profileName])

    -- Reapply default values from dbDefaults
    db.profiles[profileName] = DeepCopy(dbDefaults.profile)

    -- If the profile is currently active, apply changes immediately
    if db:GetCurrentProfile() == profileName then
        db:NotifyChange()
    end

    Log("Profile '"..profileName.."` reset to defaults")
end

