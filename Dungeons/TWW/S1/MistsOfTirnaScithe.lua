---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "mots" .. index
end

---@class Dungeons
DD.dungeons = DD.dungeons or {}

---@type DocStructure[]
local docStructures = {
	--
	-- BOSSES
	--
	{
		docName = "Ingra Maloch",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Ingra Maloch",
				id = "164567",
				displayId = 95497,
			},
			{
				-- name = "Droman Oulfarran",
				id = "164804",
				displayId = 95564,
			},
		},
	},
	{
		docName = "Mistcaller",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Mistcaller",
				id = "164501",
				displayId = 96451,
			},
		},
	},
	{
		docName = "Tred'ova",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "Tred'ova",
				id = "164517",
				displayId = 95809,
			},
		},
	},
	---
	--- TRASH
	---
	{
		docName = "Starved Crawler",
		ddid = createDDID(4),
		mobs = {
			{
				id = "216336",
				displayId = 120876,
			},
		},
	},
	{
		docName = "Drust Spiteclaw",
		ddid = createDDID(5),
		mobs = {
			{
				id = "165111",
				displayId = 86207,
			},
		},
	},
	{
		docName = "Tirnenn Villager",
		ddid = createDDID(6),
		mobs = {
			{
				id = "164929",
				displayId = 95618,
			},
		},
	},
	{
		docName = "Drust Soulcleaver",
		ddid = createDDID(7),
		mobs = {
			{
				id = "164920",
				displayId = 95612,
			},
		},
	},
	{
		docName = "Drust Harvester",
		ddid = createDDID(8),
		mobs = {
			{
				id = "164921",
				displayId = 95613,
			},
		},
	},
	{
		docName = "Drust Boughbreaker",
		ddid = createDDID(9),
		mobs = {
			{
				id = "164926",
				displayId = 95615,
			},
		},
	},
	{
		docName = "Mistveil Defender",
		ddid = createDDID(10),
		mobs = {
			{
				id = "163058",
				displayId = 95256,
			},
		},
	},
	{
		docName = "Mistveil Stalker",
		ddid = createDDID(11),
		mobs = {
			{
				id = "166301",
				displayId = 93762,
			},
		},
	},
	{
		docName = "Mistveil Stinger",
		ddid = createDDID(12),
		mobs = {
			{
				id = "166304",
				displayId = 95198,
			},
		},
	},
	{
		docName = "Mistveil Guardian",
		ddid = createDDID(13),
		mobs = {
			{
				id = "166276",
				displayId = 95261,
			},
		},
	},
	{
		docName = "Mistveil Tender",
		ddid = createDDID(14),
		mobs = {
			{
				id = "166299",
				displayId = 95908,
			},
		},
	},
	{
		docName = "Mistveil Shaper",
		ddid = createDDID(15),
		mobs = {
			{
				id = "166275",
				displayId = 95051,
			},
		},
	},
	{
		docName = "Mistveil Nightblossom",
		ddid = createDDID(16),
		mobs = {
			{
				id = "173714",
				displayId = 55772,
			},
		},
	},
	{
		docName = "Spinemaw Staghorn",
		ddid = createDDID(17),
		mobs = {
			{
				id = "167111",
				displayId = 94190,
			},
		},
	},
	{
		docName = "Spinemaw Acidgullet",
		ddid = createDDID(18),
		mobs = {
			{
				id = "167113",
				displayId = 94205,
			},
		},
	},
	{
		docName = "Spinemaw Gorger",
		ddid = createDDID(19),
		mobs = {
			{
				id = "172312",
				displayId = 94197,
			},
		},
	},
	{
		docName = "Spinemaw Larva",
		ddid = createDDID(20),
		mobs = {
			{
				id = "167117",
				displayId = 94208,
			},
		},
	},
	{
		docName = "Spinemaw Reaver",
		ddid = createDDID(21),
		mobs = {
			{
				id = "167116",
				displayId = 95692,
			},
		},
	},
	{
		docName = "Mistveil Gorgegullet",
		ddid = createDDID(22),
		mobs = {
			{
				id = "173720",
				displayId = 98502,
			},
		},
	},
	{
		docName = "Mistveil Stinger",
		ddid = createDDID(23),
		mobs = {
			{
				id = "166304",
				displayId = 95198,
			},
		},
	},
	{
		docName = "Mistveil Matriarch",
		ddid = createDDID(24),
		mobs = {
			{
				id = "173655",
				displayId = 98569,
			},
		},
	},
}

---@type DungeonData
local dungeonData = {
	dungeonName = "Mists of Tirna Scithe",
	icon = "Interface\\ICONS\\spell_nature_moonkey",
	seasonId = "TWWS1",
	docStructures = docStructures,
}

function DD.dungeons.InitMistsOfTirnaScithe()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
