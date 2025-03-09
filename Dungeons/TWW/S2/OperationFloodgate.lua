
---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "of" .. index
end

---@class Dungeons
DD.dungeons = DD.dungeons or {}

---@type DocStructure[]
local docStructures = {
	{
		docName = "Big M.O.M.M.A.",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Big M.O.M.M.A.",
				id = "226398",
				displayId = 122867,
			},
		},
	},
	{
		docName = "Demolition Duo",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Bront",
				id = "226402",
				displayId = 122215,
			},
			{
				-- name = "Keeza Quickfuse",
				id = "226403",
				displayId = 123036,
			},
		},
	},
	{
		docName = "Swampface",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "Swampface",
				id = "226396",
				displayId = 124283,
			},
		},
	},
	{
		docName = "Geezle Gigazap",
		ddid = createDDID(4),
		isBoss = true,
		mobs = {
			{
				-- name = "Geezle Gigazap",
				id = "226404",
				displayId = 122475,
			},
		},
	},
	{
		docName = "Shreddinator 3000",
		ddid = createDDID(5),
		mobs = {
			{
				-- name = "Shreddinator 3000",
				id = "230740",
				displayId = 122881,
			},
		},
	},
	{
		docName = "Darkfuse Soldier",
		ddid = createDDID(6),
		mobs = {
			{
				-- name = "Darkfuse Soldier",
				id = "228144",
				displayId = 122752,
			},
		},
	},
	{
		docName = "Mechadrone Sniper",
		ddid = createDDID(7),
		mobs = {
			{
				-- name = "Mechadrone Sniper",
				id = "229069",
				displayId = 126613,
			},
		},
	},
	{
		docName = "Loaderbot",
		ddid = createDDID(8),
		mobs = {
			{
				-- name = "Loaderbot",
				id = "231014",
				displayId = 121696,
			},
		},
	},
	{
		docName = "Venture Co. Contractor",
		ddid = createDDID(9),
		mobs = {
			{
				-- name = "Venture Co. Contractor",
				id = "229250",
				displayId = 122082,
			},
		},
	},
	{
		docName = "Darkfuse Hyena",
		ddid = createDDID(10),
		mobs = {
			{
				-- name = "Darkfuse Hyena",
				id = "229252",
				displayId = 121293,
			},
		},
	},
	{
		docName = "Darkfuse Demolitionist",
		ddid = createDDID(11),
		mobs = {
			{
				-- name = "Darkfuse Demolitionist",
				id = "229212",
				displayId = 124724,
			},
		},
	},
	{
		docName = "Darkfuse Bloodwarper",
		ddid = createDDID(12),
		mobs = {
			{
				-- name = "Darkfuse Bloodwarper",
				id = "230748",
				displayId = 126383,
			},
		},
	},
	{
		docName = "Darkfuse Inspector",
		ddid = createDDID(13),
		mobs = {
			{
				-- name = "Darkfuse Inspector",
				id = "231385",
				displayId = 124177,
			},
		},
	},
	{
		docName = "Venture Co. Surveyor",
		ddid = createDDID(14),
		mobs = {
			{
				-- name = "Venture Co. Surveyor",
				id = "229686",
				displayId = 122080,
			},
		},
	},
	{
		docName = "Venture Co. Electrician",
		ddid = createDDID(15),
		mobs = {
			{
				-- name = "Venture Co. Electrician",
				id = "231312",
				displayId = 124181,
			},
		},
	},
	{
		docName = "Bombshell Crab",
		ddid = createDDID(16),
		mobs = {
			{
				-- name = "Bombshell Crab",
				id = "231497",
				displayId = 120779,
			},
		},
	},
	{
		docName = "Venture Co. Diver",
		ddid = createDDID(17),
		mobs = {
			{
				-- name = "Venture Co. Diver",
				id = "231496",
				displayId = 122887,
			},
		},
	},
	{
		docName = "Venture Co. Architect",
		ddid = createDDID(18),
		mobs = {
			{
				-- name = "Venture Co. Architect",
				id = "229251",
				displayId = 122097,
			},
		},
	},
	{
		docName = "Disturbed Kelp",
		ddid = createDDID(19),
		mobs = {
			{
				-- name = "Disturbed Kelp",
				id = "231223",
				displayId = 126961,
			},
		},
	},
	{
		docName = "Bubbles",
		ddid = createDDID(20),
		mobs = {
			{
				-- name = "Bubbles",
				id = "231197",
				displayId = 124782,
			},
		},
	},
	{
		docName = "Darkfuse Jumpstarter",
		ddid = createDDID(21),
		mobs = {
			{
				-- name = "Darkfuse Jumpstarter",
				id = "231325",
				displayId = 122517,
			},
		},
	},
	{
		docName = "Darkfuse Mechadrone",
		ddid = createDDID(22),
		mobs = {
			{
				-- name = "Darkfuse Mechadrone",
				id = "228424",
				displayId = 125461,
			},
		},
	},
	{
		docName = "Undercrawler",
		ddid = createDDID(23),
		mobs = {
			{
				-- name = "Undercrawler",
				id = "231380",
				displayId = 112449,
			},
		},
	},
	{
		docName = "Waterworks Crocolisk",
		ddid = createDDID(24),
		mobs = {
			{
				-- name = "Waterworks Crocolisk",
				id = "227145",
				displayId = 75850,
			},
		},
	},

}

---@type DungeonData
local dungeonData = {
	dungeonName = "Operation: Floodgate",
	icon = "Interface\\Icons\\inv_gizmo_rocketboot_01",
	seasonId = "TWWS2",
	docStructures = docStructures,
}

function DD.dungeons.InitOperationFloodgate()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
