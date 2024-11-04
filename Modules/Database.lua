local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local DD = DungeonDocs
local LibSerialize = LibStub("LibSerialize")
local LibDeflate = LibStub("LibDeflate")

-- Define default db values
local dbDefaults = {
    profile = {
        docs = {},
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
        internal = {
            fallbackProfile = "Default Fallback*",
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
    local db = self.db
    db.profile.internal.showTestText = false

    -- Init default profiles
    DD:Profiles_Init()
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
        DungeonDocs:NotifyDBChange()
    end
end

function DungeonDocs:DB_SelectFallbackProfile(profileName)
    local db = self.db
    db.profile.internal.fallbackProfile = profileName
    DungeonDocs:NotifyDBChange()
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
        db.profiles[destProfileName] = DeepCopy(profileData)

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

    Log("Cloned profile `" .. sourceProfileName .. "` to profile `" .. destProfileName .. "`")
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
    db.profiles[newProfileName] = {} -- Create an empty table for the new profile
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
        db:SetProfile("Default") -- Switch to "Default" or another fallback profile
    end

    -- Delete the profile
    db.profiles[profileName] = nil
    Log("Profile `" .. profileName .. "` deleted successfully")
end

function DungeonDocs:DB_ResetProfile(profileName)
    local db = self.db

    if not db.profiles[profileName] then
        Log("Error! Cannot reset, profile does not exist:", profileName)
        return
    end

    local currentProfile = db:GetCurrentProfile()
    db:SetProfile(profileName)
    db:ResetProfile()
    db:SetProfile(currentProfile) -- Switch back to the original profile

    Log("Profile '" .. profileName .. "` reset to defaults")
end

-- DB_GetNote gets the note from the DB for the specified note key, falling
-- back to the secondary profile if the note is not found
function DD:DB_GetNotePrimary(dungeonName, mobId, noteKey)
    local db = self.db

    local dungeon = db.profile.docs[dungeonName]
    if not dungeon then
        return DD:DB_GetNoteFallback(dungeonName, mobId, noteKey)
    end

    local doc
    for _, d in ipairs(dungeon) do
        if d.id == mobId then
            doc = d
            break
        end
    end


    if not doc then
        return DD:DB_GetNoteFallback(dungeonName, mobId, noteKey)
    end

    if not doc[noteKey] then
        return DD:DB_GetNoteFallback(dungeonName, mobId, noteKey)
    end

    return doc[noteKey]
end

function DD:DB_GetNoteFallback(dungeonName, mobId, noteKey)
    local db = self.db
    local fallbackProfileName = db.profile.internal.fallbackProfile

    if not fallbackProfileName then
        return ""
    end

    local fallbackProfile = db.profiles[fallbackProfileName]
    if not fallbackProfile then
        return ""
    end

    if fallbackProfile == "None*" then
        return ""
    end


    local dungeon = fallbackProfile.docs[dungeonName]
    if not dungeon then
        return ""
    end

    local doc

    for _, d in ipairs(dungeon) do
        if d.id == mobId then
            doc = d
            break
        end
    end

    if not doc then
        return ""
    end

    if not doc[noteKey] then
        return ""
    end

    return doc[noteKey]
end

-- DB_SetNote sets the note from the DB for the specified note key, creating the
-- note if it's not found
function DD:DB_SetNote(dungeonName, mobId, noteKey, newNote)
    local db = self.db

    local mobs = db.profile.docs[dungeonName]
    if not mobs then
        DD:DB_Update(function()
            db.profile.docs[dungeonName] = {}
            table.insert(db.profile.docs[dungeonName], {
                id = mobId,
                [noteKey] = newNote,
            })
        end)
        return
    end

    local doc
    for _, d in ipairs(mobs) do
        if d.id == mobId then
            doc = d
            break
        end
    end

    if not doc then
        DD:DB_Update(function()
            local newDoc = {
                id = mobId,
                [noteKey] = newNote,
            }
            table.insert(db.profile.docs[dungeonName], newDoc)
        end)
        return
    end

    DD:DB_Update(function()
        doc[noteKey] = newNote
    end)
end
