local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local profileName = "Default Fallback*"
local docs = {}

function DD:ProfilesDefault_InitDocs(dungeonData)
    docs[dungeonData.name] = DD:Profiles_BuildDungeonDocs(dungeonData)
end

function DD:ProfilesDefault_Init()
    local db = self.db

    -- Construct the profile
    local profile = DD:GetDBDefaults()
    profile.docs = docs

    -- Register profile in the DB
    db.profiles[profileName] = profile

    -- Reserve the profile name 
    DD:Profiles_ReserveProfileName(profileName)
end