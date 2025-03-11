require("Dungeons.Dungeons")

require("Dungeons.TWW.S1.AraKara")
require("Dungeons.TWW.S1.CityOfThreads")
require("Dungeons.TWW.S1.GrimBatol")
require("Dungeons.TWW.S1.MistsOfTirnaScithe")
require("Dungeons.TWW.S1.SiegeOfBoralus")
require("Dungeons.TWW.S1.TheDawnbreaker")
require("Dungeons.TWW.S1.TheNecroticWake")
require("Dungeons.TWW.S1.TheStonevault")

require("Dungeons.TWW.S2.CinderbrewMeadery")
require("Dungeons.TWW.S2.DarkflameCleft")
require("Dungeons.TWW.S2.OperationFloodgate")
require("Dungeons.TWW.S2.OperationMechagon")
require("Dungeons.TWW.S2.PrioryOfTheSacredFlame")
require("Dungeons.TWW.S2.TheaterOfPain")
require("Dungeons.TWW.S2.TheMotherlode")
require("Dungeons.TWW.S2.TheRookery")

---@param dungeonList DungeonList
---@return number
local dungeonChecker = function(dungeonList)
	local foundPrefixes = {} ---@type string[]

	local isFoundPrefix = function(prefix)
		for _, foundPrefix in ipairs(foundPrefixes) do
			if foundPrefix == prefix then
				return true
			end
		end
		return false
	end

	local totalDocStructureCount = 0

	for _, dungeonData in pairs(dungeonList) do
		local dungeonPrefix = ""

		for i, docStruct in ipairs(dungeonData.docStructures) do
			local prefix, number = docStruct.ddid:match("(%a+)(%d+)")
			if i == 1 then
				dungeonPrefix = prefix
				if isFoundPrefix(dungeonPrefix) then
					error("dungeon prefix is not unique across dungeons: " .. docStruct.ddid)
				else
					table.insert(foundPrefixes, prefix)
				end
			else
				if dungeonPrefix ~= prefix then
					error("dungeon prefix is not the same throughout dungeon: " .. docStruct.ddid)
				end
			end

			if tostring(i) ~= number then
				error("dungeon prefix not incrementing as expected for DDID: " .. docStruct.ddid)
			end

			totalDocStructureCount = totalDocStructureCount + 1
		end
	end

	return totalDocStructureCount
end

describe("dungeonChecker", function()
	it("valid DDIDs should pass", function()
		local dungeons = {
			dungeon = {
				docStructures = {
					{
						ddid = "dh1",
					},
					{
						ddid = "dh2",
					},
				},
			},
		}
		---@diagnostic disable-next-line
		assert.has_no.error(function()
			dungeonChecker(dungeons)
		end)
	end)

	it("repeated DDIDs should error", function()
		local dungeons = {
			dungeon = {
				docStructures = {
					{
						ddid = "dh1",
					},
					{
						ddid = "dh1",
					},
				},
			},
		}
		assert.has_error(function()
			dungeonChecker(dungeons)
		end, "dungeon prefix not incrementing as expected for DDID: dh1")
	end)

	it("different DDID prefixes in the same dungeon should error", function()
		local dungeons = {
			dungeon = {
				docStructures = {
					{
						ddid = "dh1",
					},
					{
						ddid = "vh1",
					},
				},
			},
		}
		assert.has_error(function()
			dungeonChecker(dungeons)
		end, "dungeon prefix is not the same throughout dungeon: vh1")
	end)

	it("repeated DDIDs across dungeons should error", function()
		local dungeons = {
			dungeon1 = {
				docStructures = {
					{
						ddid = "dh1",
					},
				},
			},
			dungeon2 = {
				docStructures = {
					{
						ddid = "dh1",
					},
				},
			},
		}
		assert.has_error(function()
			dungeonChecker(dungeons)
		end, "dungeon prefix is not unique across dungeons: dh1")
	end)
end)

describe("Dungeons Module", function()
	local DD ---@type DungeonDocs
	local totalDocStructureCount = 0

	-- Setup: Retrieve the addon object
	before_each(function()
		DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs") ---@type DungeonDocs
	end)

	it("should initialize all dungeons without errors", function()
		---@diagnostic disable-next-line
		assert.has_no.errors(function()
			DD.dungeons.Init()
		end)
	end)

	it("should have expected DDID properties in doc structures", function()
		---@diagnostic disable-next-line
		assert.has_no.errors(function()
			totalDocStructureCount = dungeonChecker(DD.dungeons.List)
		end)
	end)

	it("should have expected doc structure count", function()
		assert.are.equal(377, totalDocStructureCount)
	end)
end)

describe("DD.dungeons.IsBossInDungeon", function()
	local DD ---@type DungeonDocs
	before_each(function()
		DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs") ---@type DungeonDocs
		DD.dungeons.Init()
	end)

	it("should be able to resolve boss if in dungeon", function()
		local avanoxxID = "213179"
		local dungeonName = "Ara-Kara, City of Echoes"
		local isBossInDungeon = DD.dungeons.IsBossInDungeon(avanoxxID, dungeonName)

		assert.is_true(isBossInDungeon)
	end)

	it("should NOT be able to resolve boss if NOT in dungeon", function()
		local badID = "101010"
		local dungeonName = "Ara-Kara, City of Echoes"
		local isBossInDungeon = DD.dungeons.IsBossInDungeon(badID, dungeonName)

		assert.is_false(isBossInDungeon)
	end)
end)

describe("DD.dungeons.MobIdToNoteName", function()
	local DD ---@type DungeonDocs
	before_each(function()
		DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs") ---@type DungeonDocs
		DD.dungeons.Init()
	end)

	it("should be able to resolve boss if in dungeon", function()
		local avanoxxID = "213179"
		local dungeonName = "Ara-Kara, City of Echoes"
		local noteName = DD.dungeons.MobIdToNoteName(avanoxxID, dungeonName)

		assert.is_equal("Avanoxx", noteName)
	end)

	it("should NOT be able to resolve boss if NOT in dungeon", function()
		local badID = "101010"
		local dungeonName = "Ara-Kara, City of Echoes"
		local noteName = DD.dungeons.MobIdToNoteName(badID, dungeonName)

		assert.is_nil(noteName)
	end)
end)

describe("DD.dungeons.MobIdToDungeonName", function()
	local DD ---@type DungeonDocs
	before_each(function()
		DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs") ---@type DungeonDocs
		DD.dungeons.Init()
	end)

	it("should be able to resolve dungeon name if good mob id", function()
		local avanoxxID = "213179"
		local dungeonName = DD.dungeons.MobIdToDungeonName(avanoxxID)

		assert.is_equal("Ara-Kara, City of Echoes", dungeonName)
	end)

	it("should NOT be able to resolve dungeon name if bad mob id", function()
		local badID = "101010"
		local dungeonName = DD.dungeons.MobIdToDungeonName(badID)

		assert.is_nil(dungeonName)
	end)
end)

describe("DD.dungeons.MobIDToDDID", function()
	local DD ---@type DungeonDocs
	before_each(function()
		DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs") ---@type DungeonDocs
		DD.dungeons.Init()
	end)

	it("should be able to resolve DDID if good mob id", function()
		local avanoxxID = "213179"
		local dungeonName = "Ara-Kara, City of Echoes"
		local ddid = DD.dungeons.MobIDToDDID(avanoxxID, dungeonName)

		assert.is_equal("ak1", ddid)
	end)

	it("should NOT be able to resolve DDID if bad mob id", function()
		local badID = "101010"
		local dungeonName = "Ara-Kara, City of Echoes"
		local ddid = DD.dungeons.MobIDToDDID(badID, dungeonName)

		assert.is_nil(ddid)
	end)
end)
