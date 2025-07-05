
---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "hoa" .. index
end

---@class Dungeons
DD.dungeons = DD.dungeons or {}

---@type DocStructure[]
local docStructures = {
	{
		docName = "Halkias",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Halkias",
				id = "165408",
				displayId = 98764,
			},
		},
	},
	{
		docName = "Echelon",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Echelon",
				id = "164185",
				displayId = 96260,
			},
		},
	},
	{
		docName = "High Adjudicator Aleez",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "High Adjudicator Aleez",
				id = "165410",
				displayId = 94503,
			},
		},
	},
	{
		docName = "Lord Chamberlain",
		ddid = createDDID(4),
		isBoss = true,
		mobs = {
			{
				-- name = "Lord Chamberlain",
				id = "164218",
				displayId = 95103,
			},
		},
	},
	{
		docName = "Depraved Darkblade",
		ddid = createDDID(5),
		mobs = {
			{
				-- name = "Depraved Darkblade",
				id = "165515",
				displayId = 93074,
			},
		},
	},
	{
		docName = "Depraved Houndmaster",
		ddid = createDDID(6),
		mobs = {
			{
				-- name = "Depraved Houndmaster",
				id = "164562",
				displayId = 97001,
			},
		},
	},
	{
		docName = "Vicious Gargon",
		ddid = createDDID(7),
		mobs = {
			{
				-- name = "Vicious Gargon",
				id = "164563",
				displayId = 93163,
			},
		},
	},
	{
		docName = "Depraved Obliterator",
		ddid = createDDID(8),
		mobs = {
			{
				-- name = "Depraved Obliterator",
				id = "165414",
				displayId = 93680,
			},
		},
	},
	{
		docName = "Toiling Groundskeeper",
		ddid = createDDID(9),
		mobs = {
			{
				-- name = "Toiling Groundskeeper",
				id = "165415",
				displayId = 93814,
			},
		},
	},
	{
		docName = "Depraved Collector",
		ddid = createDDID(10),
		mobs = {
			{
				-- name = "Depraved Collector",
				id = "165529",
				displayId = 94573,
			},
		},
	},
	{
		docName = "Shard of Halkias",
		ddid = createDDID(11),
		mobs = {
			{
				-- name = "Shard of Halkias",
				id = "164557",
				displayId = 94868,
			},
		},
	},
	{
		docName = "Stoneborn Reaver",
		ddid = createDDID(12),
		mobs = {
			{
				-- name = "Stoneborn Reaver",
				id = "167612",
				displayId = 93829,
			},
		},
	},
	{
		docName = "Stonefiend Anklebiter",
		ddid = createDDID(13),
		mobs = {
			{
				-- name = "Stonefiend Anklebiter",
				id = "167610",
				displayId = 94765,
			},
		},
	},
	{
		docName = "Stoneborn Eviscerator",
		ddid = createDDID(14),
		mobs = {
			{
				-- name = "Stoneborn Eviscerator",
				id = "167611",
				displayId = 94724,
			},
		},
	},
	{
		docName = "Stoneborn Slasher",
		ddid = createDDID(15),
		mobs = {
			{
				-- name = "Stoneborn Slasher",
				id = "167607",
				displayId = 95707,
			},
		},
	},
	{
		docName = "Tormented Soul",
		ddid = createDDID(16),
		mobs = {
			{
				-- name = "Tormented Soul",
				id = "167892",
				displayId = 90426,
			},
		},
	},
	{
		docName = "Inquisitor Sigar",
		ddid = createDDID(17),
		mobs = {
			{
				-- name = "Inquisitor Sigar",
				id = "167876",
				displayId = 93070,
			},
		},
	},

}

---@type DungeonData
local dungeonData = {
	dungeonName = "Halls of Atonement",
	icon = "Interface\\Icons\\inv_misc_web_01",
	docStructures = docStructures,
}

function DD.dungeons.InitHallsOfAtonement()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
