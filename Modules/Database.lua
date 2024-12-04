local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local DD = DungeonDocs
local LibSerialize = LibStub("LibSerialize")
local LibDeflate = LibStub("LibDeflate")


-- Define default db values
local dbDefaults = {
    dbVersion = 1,
    docs = {},
    settings = {
        omniNote = {
            position = nil,
            noteWidth = 380,

            textAlign = "LEFT",       -- Values are "CENTER", "LEFT", "RIGHT"
            noteGrowDirection = "UP", -- Values are "UP", "DOWN"
            textOutline = false,
            linePadding = 5,
            backgroundOpacity = 0,
            untargetedNoteOpacity = 0.8,
            noteSpacing = 15,

            showNoteTitle = true,

            roleDisplay = "All", -- Values are "None", "Current", or "All"
            roleHeaderIndent = 0,
            roleNoteIndent = 0,
            displayRoleHeader = true,

            tankHeader = "Tank",
            healerHeader = "Healer",
            damageHeader = "Damage",

            style = {
                defaultText = {
                    font = "Fonts\\FRIZQT__.TTF",
                    fontSize = 14,
                    color = {
                        r = 1,
                        g = 1,
                        b = 1,
                    },
                },
                mobName = {
                    useDefaultTextStyle = false,
                    text = {
                        font = "Fonts\\MORPHEUS.TTF",
                        fontSize = 22,
                        color = {
                            r = 255 / 255,
                            g = 213 / 255,
                            b = 116 / 255,
                        },
                    }
                },
                primaryNote = {
                    useDefaultTextStyle = true,
                    text = {
                        font = "Fonts\\FRIZQT__.TTF",
                        fontSize = 14,
                        color = {
                            r = 1,
                            g = 1,
                            b = 1,
                        },

                    }
                },
                defaultRoleHeader = {
                    font = "Fonts\\MORPHEUS.TTF",
                    fontSize = 16,
                    color = {
                        r = 255 / 255,
                        g = 213 / 255,
                        b = 116 / 255,
                    },
                },
                tankHeader = {
                    useDefaultRoleHeaderStyle = true,
                    text = {
                        font = "Fonts\\FRIZQT__.TTF",
                        fontSize = 14,
                        color = {
                            r = 1,
                            g = 1,
                            b = 1,
                        },
                    }
                },
                tankNote = {
                    useDefaultTextStyle = true,
                    text = {
                        font = "Fonts\\FRIZQT__.TTF",
                        fontSize = 14,
                        color = {
                            r = 1,
                            g = 1,
                            b = 1,
                        },
                    }
                },
                healerHeader = {
                    useDefaultRoleHeaderStyle = true,
                    text = {
                        font = "Fonts\\FRIZQT__.TTF",
                        fontSize = 14,
                        color = {
                            r = 1,
                            g = 1,
                            b = 1,
                        },
                    }
                },
                healerNote = {
                    useDefaultTextStyle = true,
                    text = {
                        font = "Fonts\\FRIZQT__.TTF",
                        fontSize = 14,
                        color = {
                            r = 1,
                            g = 1,
                            b = 1,
                        },
                    }
                },
                damageHeader = {
                    useDefaultRoleHeaderStyle = true,
                    text = {
                        font = "Fonts\\FRIZQT__.TTF",
                        fontSize = 14,
                        color = {
                            r = 1,
                            g = 1,
                            b = 1,
                        },
                    }
                },
                damageNote = {
                    useDefaultTextStyle = true,
                    text = {
                        font = "Fonts\\FRIZQT__.TTF",
                        fontSize = 14,
                        color = {
                            r = 1,
                            g = 1,
                            b = 1,
                        },
                    }
                },
            },
        },


        -- noteStyle = {
        --     primary = {
        --         font = "Fonts\\FRIZQT__.TTF",
        --         fontSize = 14,
        --         color = {
        --             r = 1,
        --             g = 1,
        --             b = 1,
        --         },
        --         outline = false,
        --         align = "CENTER",
        --     },
        --     role = {
        --         font = "Fonts\\FRIZQT__.TTF",
        --         fontSize = 14,
        --         color = {
        --             r = 1,
        --             g = 1,
        --             b = 1,
        --         },
        --         outline = false,
        --         align = "CENTER",
        --     },
        --     roleUsesPrimaryStyle = true,
        -- }
    },
    -- notes = {
    --     positions = {
    --         primary = nil,
    --         secondary = nil,
    --     }
    -- },
    internal = {
        fallbackProfile = "Default Fallback*",
        movers = {
            primaryNote = false,
            roleNote = false,
            omniNote = false,
        },
        seasons = {
            TWWS1 = "The War Within - Season 1",
        },
        showTestNote = false,


        selectedSeason = "TWWS1",
        testText = "This is some test to text with.\nChange it to see how your notes might look.",
        showTestText = false,
    },
}

function DungeonDocs:GetDBDefaults()
    return dbDefaults
end

function DungeonDocs:DB_EnsureDefaults(profileName)
    local profile = self.db.profiles[profileName]
    if not profile then
        Log("Error: could not ensure defaults, profile does not exist: ", profileName)
        return
    end

    local function applyDefaults(profile, defaults)
        for key, value in pairs(defaults) do
            if profile[key] == nil then
                profile[key] = DeepCopy(value)
            elseif type(value) == "table" and type(profile[key]) == "table" then
                applyDefaults(profile[key], value) -- Recursively apply for nested tables
            end
        end
    end

    applyDefaults(profile, dbDefaults)
end

function DungeonDocs:DB_EnsureDefaultsAllProfiles()
    for profileName in pairs(self.db.profiles) do
        DungeonDocs:DB_EnsureDefaults(profileName)
    end
end

function DungeonDocs:DB_Init()
    local db = self.db

    -- Init defaults on all profiles
    DungeonDocs:DB_EnsureDefaultsAllProfiles()

    -- Reset internal vars
    db.profile.internal.showTestText = false
    db.profile.internal.movers.primaryNote = false
    db.profile.internal.movers.roleNote = false
    db.profile.internal.movers.omniNote = false
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
function DungeonDocs:DB_ExportProfile(profileName, includeFallbackProfile)
    local profile = self.db.profiles[profileName] -- Access the specified profile data
    local fallbackProfileName = profile.internal.fallbackProfile
    local fallbackProfile = self.db.profiles[fallbackProfileName]

    if not profile then
        Log("Error exporting, could not find profile " .. profileName)
        return ""
    end

    if includeFallbackProfile and not fallbackProfile then
        Log("Error exporting, could not find fallback profile " .. fallbackProfileName)
        return
    end

    local docs
    if not includeFallbackProfile then
        docs = profile.docs
    else
        docs = MergeDocs(profile.docs, fallbackProfile.docs)
    end


    local profileCopy = {}
    profileCopy = DeepCopy(profile)
    profileCopy.internal = {}
    profileCopy.docs = docs

    local serialized = LibSerialize:Serialize(profileCopy)    -- Serialize profile copy
    local compressed = LibDeflate:CompressDeflate(serialized) -- Compress serialized data
    local encoded = LibDeflate:EncodeForPrint(compressed)     -- Encode to Base64
    local wrapped = "dd:" .. profile.dbVersion .. ":" .. encoded .. ":dd"

    return wrapped
end

local function validateAndParseWrappedString(wrapped)
    -- Validate the format using a pattern
    local pattern = "^dd:(%d+):(.+):dd$"
    local dbVersion, encoded = wrapped:match(pattern)

    if not dbVersion or not encoded then
        return nil, "Invalid format. The string does not match the expected pattern."
    end

    -- Convert dbVersion to a number
    dbVersion = tonumber(dbVersion)

    -- Return the parsed values
    return {
        dbVersion = dbVersion,
        encoded = encoded
    }, nil
end

-- Function to import a profile from a Base64 string
function DungeonDocs:DB_ImportProfile(destProfileName, wrapped)
    local db = self.db
    local destProfile = db.profiles[destProfileName] -- Access the specified profile data

    if destProfile ~= nil then
        Log("Error importing, profile already exists: " .. destProfileName)
        return false
    end

    local result, err = validateAndParseWrappedString(wrapped)
    if err then
        Log("Error importing, the provided string seems to be incomplete")
        return false
    end

    if not result then
        Log("Error importing, an unexpected error occurred")
        return false
    end

    local encoded = result.encoded

    -- Decode, decompress, and deserialize the profile string
    local decoded = LibDeflate:DecodeForPrint(encoded)                  -- Decode Base64
    local decompressed = LibDeflate:DecompressDeflate(decoded)          -- Decompress
    local success, profileData = LibSerialize:Deserialize(decompressed) -- Deserialize to table

    if success then
        -- Init dest profile
        db.profiles[destProfileName] = DeepCopy(profileData)
        DD:DB_EnsureDefaults(destProfileName)
        DD:NotifyDBChange()

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

    DD:NotifyDBChange()

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

    DD:NotifyDBChange()

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

    db.profiles[profileName] = {}
    DD:DB_EnsureDefaults(profileName)
    DD:NotifyDBChange()

    db:SetProfile(currentProfile) -- Switch back to the original profile

    Log("Profile '" .. profileName .. "` reset to defaults")
end

-- DB_GetNote gets the note from the DB for the specified note key, falling
-- back to the secondary profile if the note is not found
function DD:DB_GetNotePrimary(dungeonName, ddid, noteKey)
    local db = self.db

    local dungeon = db.profile.docs[dungeonName]
    if not dungeon then
        return DD:DB_GetNoteFallback(dungeonName, ddid, noteKey)
    end

    local doc
    for _, d in ipairs(dungeon) do
        if d.ddid == ddid then
            doc = d
            break
        end
    end


    if not doc then
        return DD:DB_GetNoteFallback(dungeonName, ddid, noteKey)
    end

    if not doc[noteKey] then
        return DD:DB_GetNoteFallback(dungeonName, ddid, noteKey)
    end

    return doc[noteKey]
end

function DD:DB_DeriveFullNote(dungeonName, ddid)
    return {
        primaryNote = DD:DB_GetNotePrimary(dungeonName, ddid, "primaryNote"),
        healerNote = DD:DB_GetNotePrimary(dungeonName, ddid, "healerNote"),
        damageNote = DD:DB_GetNotePrimary(dungeonName, ddid, "damageNote"),
        tankNote = DD:DB_GetNotePrimary(dungeonName, ddid, "tankNote"),
    }
end

function DD:DB_GetNoteFallback(dungeonName, ddid, noteKey)
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
        if d.ddid == ddid then
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
function DD:DB_SetNote(dungeonName, ddid, noteKey, newNote)
    local db = self.db

    local notes = db.profile.docs[dungeonName]
    if not notes then
        DD:DB_Update(function()
            db.profile.docs[dungeonName] = {}
            table.insert(db.profile.docs[dungeonName], {
                ddid = ddid,
                [noteKey] = newNote,
            })
        end)
        return
    end

    local doc
    for _, d in ipairs(notes) do
        if d.ddid == ddid then
            doc = d
            break
        end
    end

    if not doc then
        DD:DB_Update(function()
            local newDoc = {
                ddid = ddid,
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
