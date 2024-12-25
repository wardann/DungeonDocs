--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @class Profiles
DD.profiles = DD.profiles or {}

local profileName = "Default Fallback*"
local profileNotesByDungeon = {} ---@type table<DungeonName, PlayerNote[]>

--- @param profileDungeonNotes ProfileDungeonNotes
function DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
	local profileNotes = DD.profiles.BuildProfileNotes(profileDungeonNotes)
	if not DD.utils.IsTableEmpty(profileNotes) then
		profileNotesByDungeon[profileDungeonNotes.dungeonName] = profileNotes
	end
end

function DD.profiles.DefaultFallback_Init()
	-- Register profile in the DB
	local database = DD.db.GetEmptyDatabaseStructure()
	database.docs = profileNotesByDungeon

	DD.db.database.profiles[profileName] = database

	-- Reserve the profile name
	DD.profiles.ReserveProfileName(profileName)
end
