local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

-- Define default db values
local dbDefaults = {
    profile = {
        settings = {
            internal = {
                movers = false,
            },
            noteStyle = {
                primaryNote = {
                    font = "Fonts\\FRIZQT__.TTF",
                    fontSize = 14,
                    color = {
                        r = 1,
                        g = 1,
                        b = 1,
                    },
                    outline = false,
                    alignH = "CENTER",
                    alignV = "MIDDLE",
                },
                roleNote = {
                    font = "Fonts\\FRIZQT__.TTF",
                    fontSize = 14,
                    color = {
                        r = 1,
                        g = 1,
                        b = 1,
                    },
                    outline = false,
                    alignH = "CENTER",
                    alignV = "MIDDLE",
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

-- -- Function to set a key-value pair
-- function DungeonDocs:SetKeyValue(key, value)
--     self.db.profile.keyValueStore[key] = value
--     print("Set " .. key .. " to " .. tostring(value))
-- end

-- -- Function to remove a key-value pair
-- function DungeonDocs:RemoveKey(key)
--     self.db.profile.keyValueStore[key] = nil
--     print("Removed key:", key)
-- end

-- -- Function to get a value by key
-- function DungeonDocs:GetValueByKey(key)
--     return self.db.profile.keyValueStore[key]
-- end
