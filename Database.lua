local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

-- Define default db values
local dbDefaults = {
    profile = {
        settings = {
            internal = {
                movers = false,
            },
            font = "Fonts\\FRIZQT__.TTF",
        },
        docs = {}
    },
}

function DungeonDocs:GetDBDefaults()
    return dbDefaults
end

function DungeonDocs:InitDungeon(dungeonData)
    local db = self.db

    -- TODO: will likely need to add more fine-grained init than this
    if db.profile.docs[dungeonData.name] == nil then
        db.profile.docs[dungeonData.name] = dungeonData
    end
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
