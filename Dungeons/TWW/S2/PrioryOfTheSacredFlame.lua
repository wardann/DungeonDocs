---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "potsf" .. index
end

---@class Dungeons
DD.dungeons = DD.dungeons or {}

---@type DocStructure[]
local docStructures = {

	-- ######  #######  #####   #####  #######  #####
	-- #     # #     # #     # #     # #       #     #
	-- #     # #     # #       #       #       #
	-- ######  #     #  #####   #####  #####    #####
	-- #     # #     #       #       # #             #
	-- #     # #     # #     # #     # #       #     #
	-- ######  #######  #####   #####  #######  #####
	{
		docName = "Captain Dailcry",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Captain Dailcry",
				id = "207946",
				displayId = 118879,
			},
		},
	},
	{
		docName = "Baron Braunpyke",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Baron Braunpyke",
				id = "207939",
				displayId = 118878,
			},
		},
	},
	{
		docName = "Prioress Murrpray",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "Prioress Murrpray",
				id = "207940",
				displayId = 118877,
			},
		},
	},

	-- ####### ######     #     #####  #     #
	--    #    #     #   # #   #     # #     #
	--    #    #     #  #   #  #       #     #
	--    #    ######  #     #  #####  #######
	--    #    #   #   #######       # #     #
	--    #    #    #  #     # #     # #     #
	--    #    #     # #     #  #####  #     #
	{
		docName = "Arathi Footman",
		ddid = createDDID(4),
		mobs = {
			{
				-- name = "Arathi Footman",
				id = "206705",
				displayId = 120023,
			},
		},
	},
	{
		docName = "Arathi Knight",
		ddid = createDDID(5),
		mobs = {
			{
				-- name = "Arathi Knight",
				id = "206696",
				displayId = 120988,
			},
		},
	},
	{
		docName = "Arathi Neophyte",
		ddid = createDDID(6),
		mobs = {
			{
				-- name = "Arathi Neophyte",
				id = "207943",
				displayId = 121006,
			},
			{
				-- name = "Arathi Neophyte",
				id = "212838",
				displayId = 121017,
			},
			{
				-- name = "Arathi Neophyte",
				id = "209747",
				displayId = 115544,
			},
			{
				-- name = "Arathi Neophyte",
				id = "211140",
				displayId = 115544,
			},
		},
	},
	{
		docName = "Ardent Paladin",
		ddid = createDDID(7),
		mobs = {
			{
				-- name = "Ardent Paladin",
				id = "206704",
				displayId = 121023,
			},
		},
	},
	{
		docName = "Devout Priest",
		ddid = createDDID(8),
		mobs = {
			{
				-- name = "Devout Priest",
				id = "206697",
				displayId = 120847,
			},
		},
	},
	{
		docName = "Elaena Emberlanz",
		ddid = createDDID(9),
		mobs = {
			{
				-- name = "Elaena Emberlanz",
				id = "239833",
				displayId = 118872,
			},
			{
				-- name = "Elaena Emberlanz",
				id = "211290",
				displayId = 118872,
			},
		},
	},
	{
		docName = "Fanatical Conjuror",
		ddid = createDDID(10),
		mobs = {
			{
				-- name = "Fanatical Conjuror",
				id = "206698",
				displayId = 121005,
			},
		},
	},
	{
		docName = "Fervent Sharpshooter",
		ddid = createDDID(11),
		mobs = {
			{
				-- name = "Fervent Sharpshooter",
				id = "206694",
				displayId = 120987,
			},
		},
	},
	{
		docName = "Forge Master Damian",
		ddid = createDDID(12),
		mobs = {
			{
				-- name = "Forge Master Damian",
				id = "212831",
				displayId = 118874,
			},
		},
	},
	{
		docName = "Guard Captain Suleyman",
		ddid = createDDID(13),
		mobs = {
			{
				-- name = "Guard Captain Suleyman",
				id = "212826",
				displayId = 118876,
			},
		},
	},
	{
		docName = "High Priest Aemya",
		ddid = createDDID(14),
		mobs = {
			{
				-- name = "High Priest Aemya",
				id = "212827",
				displayId = 118867,
			},
		},
	},
	{
		docName = "Lightspawn",
		ddid = createDDID(15),
		mobs = {
			{
				-- name = "Lightspawn",
				id = "206710",
				displayId = 120878,
			},
		},
	},
	{
		docName = "Risen Footman",
		ddid = createDDID(16),
		mobs = {
			{
				-- name = "Risen Footman",
				id = "212835",
				displayId = 116189,
			},
		},
	},
	{
		docName = "Risen Mage",
		ddid = createDDID(17),
		mobs = {
			{
				-- name = "Risen Mage",
				id = "221760",
				displayId = 116171,
			},
		},
	},
	{
		docName = "Sergeant Shaynemail",
		ddid = createDDID(18),
		mobs = {
			{
				-- name = "Sergeant Shaynemail",
				id = "239836",
				displayId = 118870,
			},
			{
				-- name = "Sergeant Shaynemail",
				id = "211291",
				displayId = 118870,
			},
		},
	},
	{
		docName = "Sir Braunpyke",
		ddid = createDDID(19),
		mobs = {
			{
				-- name = "Sir Braunpyke",
				id = "217658",
				displayId = 116186,
			},
		},
	},
	{
		docName = "Taener Duelmal",
		ddid = createDDID(20),
		mobs = {
			{
				-- name = "Taener Duelmal",
				id = "239834",
				displayId = 118873,
			},
			{
				-- name = "Taener Duelmal",
				id = "211289",
				displayId = 118873,
			},
		},
	},
	{
		docName = "War Lynx",
		ddid = createDDID(21),
		mobs = {
			{
				-- name = "War Lynx",
				id = "206699",
				displayId = 121012,
			},
		},
	},
	{
		docName = "Zealous Templar",
		ddid = createDDID(22),
		mobs = {
			{
				-- name = "Zealous Templar",
				id = "207949",
				displayId = 121024,
			},
		},
	},
	{
		docName = "Priory of the Sacred Flame",
		ddid = createDDID(23),
		mobs = {
			{
				-- name = "Priory of the Sacred Flame",
				id = "555555",
				displayId = 121006,
			},
		},
	},
}

---@type DungeonData
local dungeonData = {
	dungeonName = DD.DungeonNames.PrioryOfTheSacredFlame,
	icon = "Interface\\Icons\\ability_paladin_divinestorm",
	docStructures = docStructures,
}

function DD.dungeons.InitPrioryOfTheSacredFlame()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
