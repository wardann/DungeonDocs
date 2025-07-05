
---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "tslg" .. index
end

---@class Dungeons
DD.dungeons = DD.dungeons or {}

---@type DocStructure[]
local docStructures = {
	{
		docName = "Hylbrande",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Hylbrande",
				id = "175663",
				displayId = 100546,
			},
		},
	},
	{
		docName = "Timecap'n Hooktail",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Timecap'n Hooktail",
				id = "175546",
				displayId = 100063,
			},
		},
	},
	{
		docName = "So'leah",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "So'leah",
				id = "177269",
				displayId = 100737,
			},
		},
	},
	{
		docName = "Murkbrine Shorerunner",
		ddid = createDDID(4),
		mobs = {
			{
				-- name = "Murkbrine Shorerunner",
				id = "178163",
				displayId = 101786,
			},
		},
	},
	{
		docName = "Murkbrine Shellcrusher",
		ddid = createDDID(5),
		mobs = {
			{
				-- name = "Murkbrine Shellcrusher",
				id = "178139",
				displayId = 101785,
			},
		},
	},
	{
		docName = "Murkbrine Fishmancer",
		ddid = createDDID(6),
		mobs = {
			{
				-- name = "Murkbrine Fishmancer",
				id = "178142",
				displayId = 101789,
			},
		},
	},
	{
		docName = "Coastwalker Goliath",
		ddid = createDDID(7),
		mobs = {
			{
				-- name = "Coastwalker Goliath",
				id = "178165",
				displayId = 101790,
			},
		},
	},
	{
		docName = "Murkbrine Wavejumper",
		ddid = createDDID(8),
		mobs = {
			{
				-- name = "Murkbrine Wavejumper",
				id = "178133",
				displayId = 101787,
			},
		},
	},
	{
		docName = "Murkbrine Scalebinder",
		ddid = createDDID(9),
		mobs = {
			{
				-- name = "Murkbrine Scalebinder",
				id = "178141",
				displayId = 101788,
			},
		},
	},
	{
		docName = "Stormforged Guardian",
		ddid = createDDID(10),
		mobs = {
			{
				-- name = "Stormforged Guardian",
				id = "178171",
				displayId = 67358,
			},
		},
	},
	{
		docName = "Burly Deckhand",
		ddid = createDDID(11),
		mobs = {
			{
				-- name = "Burly Deckhand",
				id = "180015",
				displayId = 101457,
			},
		},
	},
	{
		docName = "Hourglass Tidesage",
		ddid = createDDID(12),
		mobs = {
			{
				-- name = "Hourglass Tidesage",
				id = "179388",
				displayId = 101468,
			},
		},
	},
	{
		docName = "Drunk Pirate",
		ddid = createDDID(13),
		mobs = {
			{
				-- name = "Drunk Pirate",
				id = "179399",
				displayId = 101469,
			},
		},
	},
	{
		docName = "Corsair Officer",
		ddid = createDDID(14),
		mobs = {
			{
				-- name = "Corsair Officer",
				id = "179386",
				displayId = 101464,
			},
		},
	},
	{
		docName = "Adorned Starseer",
		ddid = createDDID(15),
		mobs = {
			{
				-- name = "Adorned Starseer",
				id = "180429",
				displayId = 101668,
			},
		},
	},
	{
		docName = "Devoted Accomplice",
		ddid = createDDID(16),
		mobs = {
			{
				-- name = "Devoted Accomplice",
				id = "180432",
				displayId = 101670,
			},
		},
	},
	{
		docName = "Focused Ritualist",
		ddid = createDDID(17),
		mobs = {
			{
				-- name = "Focused Ritualist",
				id = "180431",
				displayId = 101669,
			},
		},
	},

}

---@type DungeonData
local dungeonData = {
	dungeonName = "Tazavesh: So'leah's Gambit",
	icon = "Interface\\Icons\\inv_misc_web_01",
	docStructures = docStructures,
}

function DD.dungeons.InitTazaveshSoleahsGambit()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
