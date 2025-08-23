---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@alias DocMob {
---     id: string,
---     displayId: number,
---     hideModel?: boolean,
---}
---@alias DocStructure {
---     docName: string,
---     ddid: DDID,
---     isBoss: boolean|nil,
---     mobs: DocMob[],
---}
---@alias DungeonData {
---     dungeonName: DungeonName,
---     icon: string,
---     docStructures: DocStructure[],
---}

---@alias CreateDDID fun(index: number): DDID

---@class Dungeons
local M = {}

---@alias DungeonList table<DungeonName, DungeonData>
---@type DungeonList
M.List = {}

function M.Init()
	-- Season 1
	M.InitAraKara()
	M.InitCityOfThreads()
	M.InitGrimBatol()
	M.InitMistsOfTirnaScithe()
	M.InitSiegeOfBoralus()
	M.InitTheDawnbreaker()
	M.InitTheNecroticWake()
	M.InitTheStonevault()

	-- Season 2
	M.InitCinderbrewMeadery()
	M.InitDarkflameCleft()
	M.InitMechagonWorkshop()
	M.InitOperationFloodgate()
	M.InitPrioryOfTheSacredFlame()
	M.InitTheaterOfPain()
	M.InitTheMotherlode()
	M.InitTheRookery()

	-- Season 3
	M.InitEcoDomeAldani()
	M.InitHallsOfAtonement()
	M.InitTazaveshStreetsOfWonder()
	M.InitTazaveshSoleahsGambit()
end

---@return DungeonList
function M.GetCurrentSeason()
	local db = DD.db.database
	local dungeons = {} ---@type DungeonList

	for _, dungeonName in ipairs(DD.seasons[db.profile.internal.selectedSeason]) do
		local dungeonData = M.List[dungeonName]
		dungeons[dungeonName] = dungeonData
	end

	return dungeons
end

-- Returns name of the current dungeon the player is in
---@param mobId string
---@return DungeonName|nil
function M.GetCurrentDungeon(mobId)
	local instanceName, instanceType = GetInstanceInfo()
	if instanceType ~= "party" then
		return
	end

	-- Compensate for Tazavesh, the Veiled Market being broken into two instances
	if instanceName == "Tazavesh, the Veiled Market" then
		-- Use the provided mob ID to figure out what Tazavesh dungeon we're in

		-- First check Soleah's Gambit
		local tsg = DD.dungeons.List[DD.DungeonNames.TazaveshSoleahsGambit]
		for _, docStruct in ipairs(tsg.docStructures) do
			for _, mob in ipairs(docStruct.mobs) do
				if tostring(mob.id) == tostring(mobId) then
					return DD.DungeonNames.TazaveshSoleahsGambit
				end
			end
		end

		-- Second check Streets of Wonder
		local tsw = DD.dungeons.List[DD.DungeonNames.TazaveshStreetsOfWonder]
		for _, docStruct in ipairs(tsw.docStructures) do
			for _, mob in ipairs(docStruct.mobs) do
				if tostring(mob.id) == tostring(mobId) then
					return DD.DungeonNames.TazaveshStreetsOfWonder
				end
			end
		end

		-- Return nothing if we can't find the Tazavesh mob
		return
	end

	return instanceName
end

---@param mobId string
---@param dungeonName DungeonName
function M.IsBossInDungeon(mobId, dungeonName)
	local dungeon = M.List[dungeonName]

	for _, docStruct in ipairs(dungeon.docStructures) do
		for _, mob in ipairs(docStruct.mobs) do
			if tostring(mob.id) == tostring(mobId) then
				return docStruct.isBoss
			end
		end
	end

	return false
end

---@param mobId string
function M.IsBossInCurrentDungeon(mobId)
	local dungeonName = M.GetCurrentDungeon(mobId)
	if not dungeonName then
		return false
	end
	return M.IsBossInDungeon(mobId, dungeonName)
end

-- Returns the name of the note from a mob id
---@param mobId string
---@param dungeonName DungeonName
function M.MobIdToNoteName(mobId, dungeonName)
	local dungeon = M.List[dungeonName]

	if not dungeon then
		return
	end

	for _, docStruct in ipairs(dungeon.docStructures) do
		for _, mob in ipairs(docStruct.mobs) do
			if tostring(mob.id) == tostring(mobId) then
				return docStruct.docName
			end
		end
	end
end

---@param mobId string
---@param dungeonName DungeonName
function M.MobIdToDDID(mobId, dungeonName)
	local dungeon = M.List[dungeonName]

	if not dungeon then
		return
	end

	for _, docStruct in ipairs(dungeon.docStructures) do
		for _, mob in ipairs(docStruct.mobs) do
			if tostring(mob.id) == tostring(mobId) then
				return docStruct.ddid
			end
		end
	end
end

---@param ddid DDID
---@param dungeonName DungeonName
function M.DDIDToNoteName(ddid, dungeonName)
	local dungeon = M.List[dungeonName]

	if not dungeon then
		return
	end

	for _, docStruct in ipairs(dungeon.docStructures) do
		if docStruct.ddid == ddid then
			return docStruct.docName
		end
	end
end

---@param ddid DDID
---@param dungeonName DungeonName
function M.DDIDToDocStruct(ddid, dungeonName)
	local dungeon = M.List[dungeonName]

	if not dungeon then
		return
	end

	for _, docStruct in ipairs(dungeon.docStructures) do
		if docStruct.ddid == ddid then
			return docStruct
		end
	end
end

---@param mobId string
function M.MobIdToDungeonName(mobId)
	for dungeonName, dungeon in pairs(M.List) do
		for _, docStruct in ipairs(dungeon.docStructures) do
			for _, mob in ipairs(docStruct.mobs) do
				if tostring(mob.id) == tostring(mobId) then
					return dungeonName
				end
			end
		end
	end
end

---@param mobId string
---@param dungeonName DungeonName
function M.MobIDToDDID(mobId, dungeonName)
	local dungeon = M.List[dungeonName]

	if not dungeon then
		return
	end

	for _, docStruct in ipairs(dungeon.docStructures) do
		for _, mob in ipairs(docStruct.mobs) do
			if tostring(mob.id) == tostring(mobId) then
				return docStruct.ddid
			end
		end
	end
end

DD.dungeons = M
