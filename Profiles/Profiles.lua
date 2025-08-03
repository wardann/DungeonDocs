---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@class Profiles
local M = {}

---@alias ProfileDungeonNotes {dungeonName: string, notes: PlayerNote[]}

---@type string[]
local reservedProfileNames = {}

---@param profileName string
function M.ReserveProfileName(profileName)
	table.insert(reservedProfileNames, profileName)
end

---@param profileName string
---@return boolean
function M.IsReservedProfile(profileName)
	for _, value in ipairs(reservedProfileNames) do
		if value == profileName then
			return true
		end
	end
	return false
end

---@param profileDungeonNotes ProfileDungeonNotes
---@return PlayerNote[]
function M.BuildProfileNotes(profileDungeonNotes)
	local profileNotes = {} ---@type PlayerNote[]

	---@param note PlayerNote
	local function shouldInsert(note)
		return note.primaryNote ~= "" or note.healerNote ~= "" or note.damageNote ~= "" or note.tankNote ~= ""
	end

	for _, note in ipairs(profileDungeonNotes.notes) do
		if shouldInsert(note) then
			table.insert(profileNotes, note)
		end
	end

	return profileNotes
end

---@type {profileName: string, profileNotesByDungeon: table<DungeonName, PlayerNote[]>}[]
local reservedProfiles = {}

---@param profileName string
---@param profileNotesByDungeon table<DungeonName, PlayerNote[]>
function M.StoreReservedProfile(profileName, profileNotesByDungeon)
	table.insert(reservedProfiles, {
		profileName = profileName,
		profileNotesByDungeon = profileNotesByDungeon,
	})
end

---@param profileName string
---@param profileNotesByDungeon table<DungeonName, PlayerNote[]>
function M.InitReservedProfile(profileName, profileNotesByDungeon)
	local docs = {} ---@type PlayerNotes
	for dungeonName, playerNotes in pairs(profileNotesByDungeon) do
		---@type ProfileDungeonNotes
		local dungeonNotes = {
			dungeonName = dungeonName,
			notes = playerNotes,
		}
		local profileNotes = M.BuildProfileNotes(dungeonNotes)
		if not DD.utils.IsTableEmpty(profileNotes) then
			docs[dungeonName] = profileNotes
		end
	end

	-- Register profile in the DB
	local database = DD.db.GetEmptyDatabaseStructure()
	database.docs = docs

	DD.db.database.profiles[profileName] = database

	-- Reserve the profile name
	M.ReserveProfileName(profileName)
end

function M.Init()
	for _, profile in ipairs(reservedProfiles) do
		M.InitReservedProfile(profile.profileName, profile.profileNotesByDungeon)
	end
end

DD.profiles = M
