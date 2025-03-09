
---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "tr" .. index
end

---@class Dungeons
DD.dungeons = DD.dungeons or {}

---@type DocStructure[]
local docStructures = {
	{
		docName = "Kyrioss",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Kyrioss",
				id = "209230",
				displayId = 114856,
			},
		},
	},
	{
		docName = "Stormguard Gorren",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Stormguard Gorren",
				id = "207205",
				displayId = 114403,
			},
		},
	},
	{
		docName = "Voidstone Monstrosity",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "Voidstone Monstrosity",
				id = "207207",
				displayId = 114324,
			},
		},
	},
	{
		docName = "Quartermaster Koratite",
		ddid = createDDID(4),
		mobs = {
			{
				-- name = "Quartermaster Koratite",
				id = "209801",
				displayId = 114849,
			},
		},
	},
	{
		docName = "Cursed Thunderer",
		ddid = createDDID(5),
		mobs = {
			{
				-- name = "Cursed Thunderer",
				id = "207198",
				displayId = 118407,
			},
		},
	},
	{
		docName = "Cursed Rookguard",
		ddid = createDDID(6),
		mobs = {
			{
				-- name = "Cursed Rookguard",
				id = "207197",
				displayId = 118393,
			},
		},
	},
	{
		docName = "Voidrider",
		ddid = createDDID(7),
		mobs = {
			{
				-- name = "Voidrider",
				id = "212786",
				displayId = 117707,
			},
		},
	},
	{
		docName = "Unruly Stormrook",
		ddid = createDDID(8),
		mobs = {
			{
				-- name = "Unruly Stormrook",
				id = "207186",
				displayId = 117707,
			},
		},
	},
	{
		docName = "Cursed Rooktender",
		ddid = createDDID(9),
		mobs = {
			{
				-- name = "Cursed Rooktender",
				id = "207199",
				displayId = 114851,
			},
		},
	},
	{
		docName = "Void-Cursed Crusher",
		ddid = createDDID(10),
		mobs = {
			{
				-- name = "Void-Cursed Crusher",
				id = "214419",
				displayId = 117972,
			},
		},
	},
	{
		docName = "Corrupted Oracle",
		ddid = createDDID(11),
		mobs = {
			{
				-- name = "Corrupted Oracle",
				id = "214439",
				displayId = 119838,
			},
		},
	},
	{
		docName = "Coalescing Void Diffuser",
		ddid = createDDID(12),
		mobs = {
			{
				-- name = "Coalescing Void Diffuser",
				id = "214421",
				displayId = 117974,
			},
		},
	},
	{
		docName = "Afflicted Civilian",
		ddid = createDDID(13),
		mobs = {
			{
				-- name = "Afflicted Civilian",
				id = "219066",
				displayId = 121686,
			},
		},
	},
	{
		docName = "Void Ascendant",
		ddid = createDDID(14),
		mobs = {
			{
				-- name = "Void Ascendant",
				id = "212793",
				displayId = 118418,
			},
		},
	},
	{
		docName = "Radiating Voidstone",
		ddid = createDDID(15),
		mobs = {
			{
				-- name = "Radiating Voidstone",
				id = "212739",
				displayId = 114860,
			},
		},
	},
	{
		docName = "Stormrider Vokmar",
		ddid = createDDID(16),
		mobs = {
			{
				-- name = "Stormrider Vokmar",
				id = "211260",
				displayId = 116266,
			},
		},
	},
	{
		docName = "Voidstone Awakened",
		ddid = createDDID(17),
		mobs = {
			{
				-- name = "Voidstone Awakened",
				id = "213741",
				displayId = 114860,
			},
		},
	},

}

---@type DungeonData
local dungeonData = {
	dungeonName = "The Rookery",
	icon = "Interface\\Icons\\inv_misc_web_01",
	seasonId = "TWWS2",
	docStructures = docStructures,
}

function DD.dungeons.InitTheRookery()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
