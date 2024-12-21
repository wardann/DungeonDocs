--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local LibSerialize = LibStub("LibSerialize") --- @type LibSerialize
local LibDeflate = LibStub("LibDeflate") --- @type LibDeflate


--- @class DB
local M = {}

-- Define default db values
--- @class DatabaseStructure
local dbDefaults = {
    dbVersion = 1,
    docs = {},
    settings = {
        omniNote = {

            --- @alias Position { point: string, relativePoint: string, xOffset: number, yOffset: number }
            position = nil, --- @type nil|Position
            noteWidth = 380,

            textAlign = "LEFT",       -- Values are "CENTER", "LEFT", "RIGHT"
            noteGrowDirection = "UP", -- Values are "UP", "DOWN"
            textOutline = false,
            linePadding = 5,
            backgroundOpacity = 0,
            untargetedNoteOpacity = 0.7,
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

--- @returns DatabaseStructure
function M.GetDBDefaults()
    return dbDefaults
end

function M.EnsureDefaults(profileName)
    local p = M.database.profiles[profileName]
    if not p then
        DD.utils.Log("Error: could not ensure defaults, profile does not exist: ", profileName)
        return
    end

    local function applyDefaults(profile, defaults)
        for key, value in pairs(defaults) do
            if profile[key] == nil then
                profile[key] = DD.utils.DeepCopy(value)
            elseif type(value) == "table" and type(profile[key]) == "table" then
                applyDefaults(profile[key], value) -- Recursively apply for nested tables
            end
        end
    end

    applyDefaults(p, dbDefaults)
end

function M.EnsureDefaultsAllProfiles()
    for profileName in pairs(M.database.profiles) do
        M.EnsureDefaults(profileName)
    end
end

function M.Init()
    M.database = LibStub("AceDB-3.0"):New("DungeonDocsDB") --- @type AceDB

    -- Init defaults on all profiles
    M.EnsureDefaultsAllProfiles()

    -- Reset internal vars
    M.database.profile.internal.showTestText = false
    M.database.profile.internal.movers.primaryNote = false
    M.database.profile.internal.movers.roleNote = false
    M.database.profile.internal.movers.omniNote = false
end

-- A table to hold subscriber functions
local dbChangeSubscribers = {}

function M.SubscribeToDBChange(callback)
    table.insert(dbChangeSubscribers, callback)
end

function M.NotifyDBChange()
    for _, callback in ipairs(dbChangeSubscribers) do
        local status, err = pcall(callback)
        if not status then
            error(err)
        end
    end
end

function M.UpdateDB(updater)
    updater()
    M.NotifyDBChange()
end

function M.ListProfiles()
    return M.database:GetProfiles()
end

function M.SelectProfile(profileName)
    local db = M.database
    if db:GetCurrentProfile() ~= profileName then -- Only switch if different
        db:SetProfile(profileName)
        M.NotifyDBChange()
    end
end

function M.SelectFallbackProfile(profileName)
    local db = M.database
    db.profile.internal.fallbackProfile = profileName
    M.NotifyDBChange()
end

-- Function to export the current profile, excluding the "internal" table
function M.ExportProfile(profileName, includeFallbackProfile)
    local profile = M.database.profiles[profileName] -- Access the specified profile data
    local fallbackProfileName = profile.internal.fallbackProfile
    local fallbackProfile = M.database.profiles[fallbackProfileName]

    if not profile then
        DD.utils.Log("Error exporting, could not find profile " .. profileName)
        return ""
    end

    if includeFallbackProfile and not fallbackProfile then
        DD.utils.Log("Error exporting, could not find fallback profile " .. fallbackProfileName)
        return
    end

    local docs
    if not includeFallbackProfile then
        docs = profile.docs
    else
        docs = DD.utils.MergeDocs(profile.docs, fallbackProfile.docs)
    end


    local profileCopy = DD.utils.DeepCopy(profile)
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
function M.ImportProfile(destProfileName, wrapped)
    local db = M.database
    local destProfile = db.profiles[destProfileName] -- Access the specified profile data

    if destProfile ~= nil then
        DD.utils.Log("Error importing, profile already exists: " .. destProfileName)
        return false
    end

    local result, err = validateAndParseWrappedString(wrapped)
    if err then
        DD.utils.Log("Error importing, the provided string seems to be incomplete")
        return false
    end

    if not result then
        DD.utils.Log("Error importing, an unexpected error occurred")
        return false
    end

    local encoded = result.encoded

    -- Decode, decompress, and deserialize the profile string
    local decoded = LibDeflate:DecodeForPrint(encoded)                  -- Decode Base64
    if not decoded then
        DD.utils.Log("Error decoding, got nil")
        return false
    end
    local decompressed = LibDeflate:DecompressDeflate(decoded)          -- Decompress
    if not decompressed then
        DD.utils.Log("Error deflating, got nil")
        return false
    end
    local success, profileData = LibSerialize:Deserialize(decompressed) -- Deserialize to table

    if success and profileData then
        -- Init dest profile
        db.profiles[destProfileName] = DD.utils.DeepCopy(profileData)
        M.EnsureDefaults(destProfileName)
        M.NotifyDBChange()

        DD.utils.Log("Success! Imported profile " .. destProfileName)
        return true
    else
        DD.utils.Log("Error! Could not import profile " .. destProfileName)
        return false
    end
end

function M.CloneProfile(sourceProfileName, destProfileName)
    local db = M.database
    local sourceProfile = db.profiles[sourceProfileName]

    if sourceProfile == nil then
        DD.utils.Log("Error! Could not clone profile, source `" .. sourceProfileName .. "` does not exist")
        return
    end

    if db.profiles[destProfileName] then
        DD.utils.Log("Error! Could not clone profile, destination profile `" .. sourceProfileName .. "` already exists")
        return
    end

    -- Init the profile
    db.profiles[destProfileName] = {}

    -- Copy the source profile
    db.profiles[destProfileName] = DD.utils.DeepCopy(sourceProfile)

    M.NotifyDBChange()

    DD.utils.Log("Cloned profile `" .. sourceProfileName .. "` to profile `" .. destProfileName .. "`")
end

function M.RenameProfile(sourceProfileName, newProfileName)
    local db = M.database

    -- Check if the current profile exists
    local sourceProfile = db.profiles[sourceProfileName]
    if not sourceProfile then
        DD.utils.Log("Error! Profile does not exist: ", sourceProfileName)
        return
    end

    -- Check if the new profile name is already taken
    if db.profiles[newProfileName] then
        DD.utils.Log("Error! Profile with the name '" .. newProfileName .. "' already exists.")
        return
    end

    -- Copy current profile data to the new profile
    db.profiles[newProfileName] = {} -- Create an empty table for the new profile
    db.profiles[newProfileName] = DD.utils.DeepCopy(sourceProfile)

    -- If the old profile was active, switch to the new profile
    if db:GetCurrentProfile() == sourceProfileName then
        db:SetProfile(newProfileName)
    end

    -- Delete the old profile
    db.profiles[sourceProfileName] = nil

    M.NotifyDBChange()

    DD.utils.Log("Success! Profile renamed from", sourceProfileName, "to", newProfileName)
end

function M.DeleteProfile(profileName)
    local db = M.database

    if profileName == "Default" then
        DD.utils.Log("Error! Cannot delete the default profile")
        return
    end
    -- Check if the profile exists
    if not db.profiles[profileName] then
        DD.utils.Log("Error! Cannot delete, profile does not exist:", profileName)
        return
    end

    -- If the profile being deleted is active, switch to a default profile
    if db:GetCurrentProfile() == profileName then
        db:SetProfile("Default") -- Switch to "Default" or another fallback profile
    end

    -- Delete the profile
    db.profiles[profileName] = nil
    DD.utils.Log("Profile `" .. profileName .. "` deleted successfully")
end

function M.ResetProfile(profileName)
    local db = M.database

    if not db.profiles[profileName] then
        DD.utils.Log("Error! Cannot reset, profile does not exist:", profileName)
        return
    end

    local currentProfile = db:GetCurrentProfile()
    db:SetProfile(profileName)

    db.profiles[profileName] = {}
    M.EnsureDefaults(profileName)
    M.NotifyDBChange()

    db:SetProfile(currentProfile) -- Switch back to the original profile

    DD.utils.Log("Profile '" .. profileName .. "` reset to defaults")
end

-- GetNotePrimary gets the note from the DB for the specified note key, falling
-- back to the secondary profile if the note is not found
function M.GetNotePrimary(dungeonName, ddid, noteKey)
    local db = M.database

    local dungeon = db.profile.docs[dungeonName]
    if not dungeon then
        return M.GetNoteFallback(dungeonName, ddid, noteKey)
    end

    local doc
    for _, d in ipairs(dungeon) do
        if d.ddid == ddid then
            doc = d
            break
        end
    end


    if not doc then
        return M.GetNoteFallback(dungeonName, ddid, noteKey)
    end

    if not doc[noteKey] then
        return M.GetNoteFallback(dungeonName, ddid, noteKey)
    end

    return doc[noteKey]
end

function M.DeriveFullNote(dungeonName, ddid)
    return {
        primaryNote = M.GetNotePrimary(dungeonName, ddid, "primaryNote"),
        healerNote = M.GetNotePrimary(dungeonName, ddid, "healerNote"),
        damageNote = M.GetNotePrimary(dungeonName, ddid, "damageNote"),
        tankNote = M.GetNotePrimary(dungeonName, ddid, "tankNote"),
    }
end

function M.GetNoteFallback(dungeonName, ddid, noteKey)
    local db = M.database
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

-- SetNote sets the note from the DB for the specified note key, creating the
-- note if it's not found
function M.SetNote(dungeonName, ddid, noteKey, newNote)
    local db = M.database

    local notes = db.profile.docs[dungeonName]
    if not notes then
        M.UpdateDB(function()
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
        M.UpdateDB(function()
            local newDoc = {
                ddid = ddid,
                [noteKey] = newNote,
            }
            table.insert(db.profile.docs[dungeonName], newDoc)
        end)
        return
    end

    M.UpdateDB(function()
        doc[noteKey] = newNote
    end)
end


DD.db = M