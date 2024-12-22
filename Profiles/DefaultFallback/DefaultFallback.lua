--- @type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @class Profiles
DD.profiles = DD.profiles or {}

local profileName = "Default Fallback*"
local docs = {}

--- @param dungeonData ProfileDungeonNotes
function DD.profiles.DefaultFallback_InitDocs(dungeonData)
    local dungeonDocs = DD.profiles.BuildProfileNotes(dungeonData)
    if not DD.utils.IsTableEmpty(dungeonDocs) then
        docs[dungeonData.dungeonName] = dungeonDocs
    end
end

function DD.profiles.DefaultFallback_Init()
    -- Register profile in the DB
    DD.db.database.profiles[profileName] = {
        docs = docs
    }

    -- Reserve the profile name
    DD.profiles.ReserveProfileName(profileName)
end
