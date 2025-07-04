---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "tdb" .. index
end

---@class Dungeons
DD.dungeons = DD.dungeons or {}

---@type DocStructure[]
local docStructures = {
	--
	-- BOSSES
	--
	{
		docName = "Speaker Shadowcrown",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Speaker Shadowcrown",
				id = "211087",
				displayId = 114311,
			},
		},
	},
	{
		docName = "Anubikkaj",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Anubikkaj",
				id = "211089",
				displayId = 114315,
			},
		},
	},
	{
		docName = "Rashanan",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "Rashanan",
				id = "213937",
				displayId = 118404,
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
		docName = "Nightfall Curseblade",
		ddid = createDDID(5),
		mobs = {
			{
				id = "213894",
				displayId = 115528,
			},
		},
	},
	{
		docName = "Nightfall Shadowmage",
		ddid = createDDID(6),
		mobs = {
			{
				id = "213892",
				displayId = 115523,
			},
		},
	},
	{
		docName = "Nightfall Ritualist",
		ddid = createDDID(7),
		mobs = {
			{
				id = "214761",
				displayId = 115526,
			},
		},
	},
	{
		docName = "Nightfall Commander",
		ddid = createDDID(8),
		mobs = {
			{
				id = "214762",
				displayId = 115535,
			},
		},
	},
	{
		docName = "Sureki Webmage",
		ddid = createDDID(9),
		mobs = {
			{
				id = "210966",
				displayId = 117315,
			},
		},
	},
	{
		docName = "Nightfall Darkcaster",
		ddid = createDDID(10),
		mobs = {
			{
				id = "213893",
				displayId = 115520,
			},
		},
	},
	{
		docName = "Nightfall Shadowalker",
		ddid = createDDID(11),
		mobs = {
			{
				id = "213895",
				displayId = 115530,
			},
		},
	},
	{
		docName = "Manifested Shadow",
		ddid = createDDID(12),
		mobs = {
			{
				id = "211341",
				displayId = 117518,
			},
		},
	},
	{
		docName = "Sureki Militant",
		ddid = createDDID(13),
		mobs = {
			{
				id = "213932",
				displayId = 116834,
			},
		},
	},
	{
		docName = "Nightfall Tactician",
		ddid = createDDID(14),
		mobs = {
			{
				id = "213934",
				displayId = 115534,
			},
		},
	},
	{
		docName = "Ascendant Viscoxria",
		ddid = createDDID(15),
		mobs = {
			{
				id = "211261",
				displayId = 115760,
			},
		},
	},
	{
		docName = "Deathscreamer Ikentak",
		ddid = createDDID(16),
		mobs = {
			{
				id = "211263",
				displayId = 115759,
			},
		},
	},
	{
		docName = "Ixkreten The Unbreakable",
		ddid = createDDID(17),
		mobs = {
			{
				id = "211262",
				displayId = 119262,
			},
		},
	},
	{
		docName = "Nightfall Dark Architect",
		ddid = createDDID(18),
		mobs = {
			{
				id = "213885",
				displayId = 120116,
			},
		},
	},
}

---@type DungeonData
local dungeonData = {
	dungeonName = DD.DungeonNames.TheDawnbreaker,
	icon = "Interface\\Icons\\inv_misc_monsterscales_19",
	seasonId = "TWWS1",
	docStructures = docStructures,
}

function DD.dungeons.InitTheDawnbreaker()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
