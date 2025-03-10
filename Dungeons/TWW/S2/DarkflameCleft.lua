
---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "dfc" .. index
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
		docName = "Ol' Waxbeard",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Ol' Waxbeard",
				id = "210153",
				displayId = 114039,
			},
		},
	},
	{
		docName = "Blazikon",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Blazikon",
				id = "208743",
				displayId = 115888,
			},
		},
	},
	{
		docName = "The Candle King",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "The Candle King",
				id = "208745",
				displayId = 114508,
			},
		},
	},
	{
		docName = "The Darkness",
		ddid = createDDID(4),
		isBoss = true,
		mobs = {
			{
				-- name = "The Darkness",
				id = "208747",
				displayId = 117773,
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
		docName = "Menial Laborer",
		ddid = createDDID(5),
		mobs = {
			{
				-- name = "Menial Laborer",
				id = "210810",
				displayId = 114696,
			},
		},
	},
	{
		docName = "Rank Overseer",
		ddid = createDDID(6),
		mobs = {
			{
				-- name = "Rank Overseer",
				id = "211121",
				displayId = 114091,
			},
		},
	},
	{
		docName = "Lowly Moleherd",
		ddid = createDDID(7),
		mobs = {
			{
				-- name = "Lowly Moleherd",
				id = "210818",
				displayId = 114721,
			},
		},
	},
	{
		docName = "Pack Mole",
		ddid = createDDID(8),
		mobs = {
			{
				-- name = "Pack Mole",
				id = "211977",
				displayId = 112394,
			},
		},
	},
	{
		docName = "Royal Wicklighter",
		ddid = createDDID(9),
		mobs = {
			{
				-- name = "Royal Wicklighter",
				id = "210812",
				displayId = 114709,
			},
		},
	},
	{
		docName = "Kobold Taskworker",
		ddid = createDDID(10),
		mobs = {
			{
				-- name = "Kobold Taskworker",
				id = "212383",
				displayId = 114757,
			},
		},
	},
	{
		docName = "Blazing Fiend",
		ddid = createDDID(11),
		mobs = {
			{
				-- name = "Blazing Fiend",
				id = "220815",
				displayId = 118916,
			},
		},
	},
	{
		docName = "Wandering Candle",
		ddid = createDDID(12),
		mobs = {
			{
				-- name = "Wandering Candle",
				id = "208450",
				displayId = 114467,
			},
		},
	},
	{
		docName = "Kobold Flametender",
		ddid = createDDID(13),
		mobs = {
			{
				-- name = "Kobold Flametender",
				id = "213913",
				displayId = 118173,
			},
		},
	},
	{
		docName = "Sootsnout",
		ddid = createDDID(14),
		mobs = {
			{
				-- name = "Sootsnout",
				id = "212412",
				displayId = 114736,
			},
		},
	},
	{
		docName = "Torchsnarl",
		ddid = createDDID(15),
		mobs = {
			{
				-- name = "Torchsnarl",
				id = "212411",
				displayId = 114705,
			},
		},
	},
	{
		docName = "Skittering Darkness",
		ddid = createDDID(16),
		mobs = {
			{
				-- name = "Skittering Darkness",
				id = "208457",
				displayId = 92318,
			},
		},
	},
	{
		docName = "Shuffling Horror",
		ddid = createDDID(17),
		mobs = {
			{
				-- name = "Shuffling Horror",
				id = "208456",
				displayId = 92318,
			},
		},
	},
	{
		docName = "Corridor Creeper",
		ddid = createDDID(18),
		mobs = {
			{
				-- name = "Corridor Creeper",
				id = "210539",
				displayId = 92709,
			},
		},
	},
	{
		docName = "Blazing Fiend",
		ddid = createDDID(19),
		mobs = {
			{
				-- name = "Blazing Fiend",
				id = "211228",
				displayId = 118916,
			},
		},
	},
	{
		docName = "Blazing Fiend",
		ddid = createDDID(20),
		mobs = {
			{
				-- name = "Blazing Fiend",
				id = "223770",
				displayId = 118916,
			},
		},
	},
	{
		docName = "Blazing Fiend",
		ddid = createDDID(21),
		mobs = {
			{
				-- name = "Blazing Fiend",
				id = "223772",
				displayId = 118916,
			},
		},
	},
	{
		docName = "Blazing Fiend",
		ddid = createDDID(22),
		mobs = {
			{
				-- name = "Blazing Fiend",
				id = "223773",
				displayId = 118916,
			},
		},
	},
	{
		docName = "Blazing Fiend",
		ddid = createDDID(23),
		mobs = {
			{
				-- name = "Blazing Fiend",
				id = "223774",
				displayId = 118916,
			},
		},
	},
	{
		docName = "Blazing Fiend",
		ddid = createDDID(24),
		mobs = {
			{
				-- name = "Blazing Fiend",
				id = "223775",
				displayId = 118916,
			},
		},
	},
	{
		docName = "Blazing Fiend",
		ddid = createDDID(25),
		mobs = {
			{
				-- name = "Blazing Fiend",
				id = "223776",
				displayId = 118916,
			},
		},
	},
	{
		docName = "Blazing Fiend",
		ddid = createDDID(26),
		mobs = {
			{
				-- name = "Blazing Fiend",
				id = "223777",
				displayId = 118916,
			},
		},
	},
	{
		docName = "Corridor Sleeper",
		ddid = createDDID(27),
		mobs = {
			{
				-- name = "Corridor Sleeper",
				id = "220616",
				displayId = 92709,
			},
		},
	},
	{
		docName = "Menial Laborer",
		ddid = createDDID(28),
		mobs = {
			{
				-- name = "Menial Laborer",
				id = "210148",
				displayId = 114170,
			},
		},
	},
	{
		docName = "Dynamite Mine Cart",
		ddid = createDDID(29),
		mobs = {
			{
				-- name = "Dynamite Mine Cart",
				id = "213751",
				displayId = 114373,
			},
		},
	},
	{
		docName = "Wriggling Darkspawn",
		ddid = createDDID(30),
		mobs = {
			{
				-- name = "Wriggling Darkspawn",
				id = "213008",
				displayId = 68714,
			},
		},
	},

}

---@type DungeonData
local dungeonData = {
	dungeonName = "Darkflame Cleft",
	icon = "Interface\\Icons\\spell_shadow_shadowbolt",
	seasonId = "TWWS2",
	docStructures = docStructures,
}

function DD.dungeons.InitDarkflameCleft()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
