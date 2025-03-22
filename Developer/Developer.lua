
---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@class Developer
local M = {}

function M.Init()
    if not DD.db.database.profile.internal.developerModeEnabled then
        return
    end

    DD.utils.Log("Developer mode enabled")
end

DD.developer = M