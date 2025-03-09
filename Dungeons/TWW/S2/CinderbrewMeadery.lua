
---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "cbm" .. index
end

---@class Dungeons
DD.dungeons = DD.dungeons or {}

---@type DocStructure[]
local docStructures = {
	{
		docName = "Brewmaster Aldryr",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Brewmaster Aldryr",
				id = "210271",
				displayId = 116429,
			},
		},
	},
	{
		docName = "I'pa",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "I'pa",
				id = "210267",
				displayId = 117177,
			},
		},
	},
	{
		docName = "Benk Buzzbee",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "Benk Buzzbee",
				id = "218002",
				displayId = 120557,
			},
		},
	},
	{
		docName = "Goldie Baronbottom",
		ddid = createDDID(4),
		isBoss = true,
		mobs = {
			{
				-- name = "Goldie Baronbottom",
				id = "214661",
				displayId = 118000,
			},
		},
	},
	{
		docName = "Tasting Room Attendant",
		ddid = createDDID(5),
		mobs = {
			{
				-- name = "Tasting Room Attendant",
				id = "214920",
				displayId = 121037,
			},
		},
	},
	{
		docName = "Venture Co. Pyromaniac",
		ddid = createDDID(6),
		mobs = {
			{
				-- name = "Venture Co. Pyromaniac",
				id = "218671",
				displayId = 119013,
			},
		},
	},
	{
		docName = "Venture Co. Patron",
		ddid = createDDID(7),
		mobs = {
			{
				-- name = "Venture Co. Patron",
				id = "214668",
				displayId = 119026,
			},
		},
	},
	{
		docName = "Hired Muscle",
		ddid = createDDID(8),
		mobs = {
			{
				-- name = "Hired Muscle",
				id = "210269",
				displayId = 118999,
			},
		},
	},
	{
		docName = "Chef Chewie",
		ddid = createDDID(9),
		mobs = {
			{
				-- name = "Chef Chewie",
				id = "214697",
				displayId = 121036,
			},
		},
	},
	{
		docName = "Worker Bee",
		ddid = createDDID(10),
		mobs = {
			{
				-- name = "Worker Bee",
				id = "210265",
				displayId = 121054,
			},
		},
	},
	{
		docName = "Royal Jelly Purveyor",
		ddid = createDDID(11),
		mobs = {
			{
				-- name = "Royal Jelly Purveyor",
				id = "220141",
				displayId = 118378,
			},
		},
	},
	{
		docName = "Venture Co. Honey Harvester",
		ddid = createDDID(12),
		mobs = {
			{
				-- name = "Venture Co. Honey Harvester",
				id = "220946",
				displayId = 108585,
			},
		},
	},
	{
		docName = "Bee Wrangler",
		ddid = createDDID(13),
		mobs = {
			{
				-- name = "Bee Wrangler",
				id = "210264",
				displayId = 118076,
			},
		},
	},
	{
		docName = "Bee-let",
		ddid = createDDID(14),
		mobs = {
			{
				-- name = "Bee-let",
				id = "218865",
				displayId = 121060,
			},
		},
	},
	{
		docName = "Flavor Scientist",
		ddid = createDDID(15),
		mobs = {
			{
				-- name = "Flavor Scientist",
				id = "214673",
				displayId = 119436,
			},
		},
	},
	{
		docName = "Taste Tester",
		ddid = createDDID(16),
		mobs = {
			{
				-- name = "Taste Tester",
				id = "220060",
				displayId = 118003,
			},
		},
	},
	{
		docName = "Careless Hopgoblin",
		ddid = createDDID(17),
		mobs = {
			{
				-- name = "Careless Hopgoblin",
				id = "223423",
				displayId = 121087,
			},
		},
	},
	{
		docName = "Brew Drop",
		ddid = createDDID(18),
		mobs = {
			{
				-- name = "Brew Drop",
				id = "210270",
				displayId = 117828,
			},
		},
	},
	{
		docName = "Yes Man",
		ddid = createDDID(19),
		mobs = {
			{
				-- name = "Yes Man",
				id = "219588",
				displayId = 121109,
			},
		},
	},
	{
		docName = "Flavor Scientist",
		ddid = createDDID(20),
		mobs = {
			{
				-- name = "Flavor Scientist",
				id = "222964",
				displayId = 119436,
			},
		},
	},
	{
		docName = "Brew Drop",
		ddid = createDDID(21),
		mobs = {
			{
				-- name = "Brew Drop",
				id = "219301",
				displayId = 120498,
			},
		},
	},
	{
		docName = "Ravenous Cinderbee",
		ddid = createDDID(22),
		mobs = {
			{
				-- name = "Ravenous Cinderbee",
				id = "218016",
				displayId = 120631,
			},
		},
	},
	{
		docName = "Worker Bee",
		ddid = createDDID(23),
		mobs = {
			{
				-- name = "Worker Bee",
				id = "223497",
				displayId = 121054,
			},
		},
	},
	{
		docName = "Bee-let",
		ddid = createDDID(24),
		mobs = {
			{
				-- name = "Bee-let",
				id = "223498",
				displayId = 121060,
			},
		},
	},

}

---@type DungeonData
local dungeonData = {
	dungeonName = "Cinderbrew Meadery",
	icon = "Interface\\Icons\\inv_drink_04",
	seasonId = "TWWS2",
	docStructures = docStructures,
}

function DD.dungeons.InitCinderbrewMeadery()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
