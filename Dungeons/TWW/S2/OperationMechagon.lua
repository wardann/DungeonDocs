
---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "mw" .. index
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
		docName = "Tussle Tonks",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Gnomercy 4.U.",
				id = "145185",
				displayId = 91879,
			},
			{
				-- name = "The Platinum Pummeler",
				id = "144244",
				displayId = 91216,
			},
		},
	},
	{
		docName = "K.U.-J.0.",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "K.U.-J.0.",
				id = "144246",
				displayId = 90775,
			},
		},
	},
	{
		docName = "Head Machinist Sparkflux",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "Head Machinist Sparkflux",
				id = "144248",
				displayId = 23397,
			},
		},
	},
	{
		docName = "King Mechagon",
		ddid = createDDID(4),
		isBoss = true,
		mobs = {
			{
				-- name = "Aerial Unit R-21/X",
				id = "150396",
				displayId = 90547,
			},
			{
				-- name = "Omega Buster",
				id = "144249",
				displayId = 90998,
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
		docName = "Blastatron X-80",
		ddid = createDDID(5),
		mobs = {
			{
				-- name = "Blastatron X-80",
				id = "151476",
				displayId = 90712,
			},
		},
	},
	{
		docName = "Defense Bot Mk I",
		ddid = createDDID(6),
		mobs = {
			{
				-- name = "Defense Bot Mk I",
				id = "151649",
				displayId = 91349,
			},
		},
	},
	{
		docName = "Mechagon Tinkerer",
		ddid = createDDID(7),
		mobs = {
			{
				-- name = "Mechagon Tinkerer",
				id = "144294",
				displayId = 91170,
			},
		},
	},
	{
		docName = "Workshop Defender",
		ddid = createDDID(8),
		mobs = {
			{
				-- name = "Workshop Defender",
				id = "144299",
				displayId = 91183,
			},
		},
	},
	{
		docName = "Mechagon Mechanic",
		ddid = createDDID(9),
		mobs = {
			{
				-- name = "Mechagon Mechanic",
				id = "144295",
				displayId = 91171,
			},
		},
	},
	{
		docName = "Spider Tank",
		ddid = createDDID(10),
		mobs = {
			{
				-- name = "Spider Tank",
				id = "144296",
				displayId = 90710,
			},
		},
	},
	{
		docName = "Defense Bot Mk III",
		ddid = createDDID(11),
		mobs = {
			{
				-- name = "Defense Bot Mk III",
				id = "144298",
				displayId = 90855,
			},
		},
	},
	{
		docName = "Junkyard D.0.G.",
		ddid = createDDID(12),
		mobs = {
			{
				-- name = "Junkyard D.0.G.",
				id = "151773",
				displayId = 90511,
			},
		},
	},
	{
		docName = "Waste Processing Unit",
		ddid = createDDID(13),
		mobs = {
			{
				-- name = "Waste Processing Unit",
				id = "144293",
				displayId = 92177,
			},
		},
	},
	{
		docName = "Living Waste",
		ddid = createDDID(14),
		mobs = {
			{
				-- name = "Living Waste",
				id = "144301",
				displayId = 111780,
			},
		},
	},
	{
		docName = "Bomb Tonk",
		ddid = createDDID(15),
		mobs = {
			{
				-- name = "Bomb Tonk",
				id = "151657",
				displayId = 82724,
			},
		},
	},
	{
		docName = "Rocket Tonk",
		ddid = createDDID(16),
		mobs = {
			{
				-- name = "Rocket Tonk",
				id = "151659",
				displayId = 28573,
			},
		},
	},
	{
		docName = "Strider Tonk",
		ddid = createDDID(17),
		mobs = {
			{
				-- name = "Strider Tonk",
				id = "151658",
				displayId = 6569,
			},
		},
	},
	{
		docName = "G.U.A.R.D.",
		ddid = createDDID(18),
		mobs = {
			{
				-- name = "G.U.A.R.D.",
				id = "144303",
				displayId = 68856,
			},
		},
	},
	{
		docName = "Metal Gunk",
		ddid = createDDID(19),
		mobs = {
			{
				-- name = "Metal Gunk",
				id = "236033",
				displayId = 90423,
			},
		},
	},
	{
		docName = "Inconspicuous Plant",
		ddid = createDDID(20),
		mobs = {
			{
				-- name = "Inconspicuous Plant",
				id = "152033",
				displayId = 91336,
			},
		},
	},

}

---@type DungeonData
local dungeonData = {
	dungeonName = "Operation: Mechagon",
	icon = "Interface\\Icons\\trade_engineering",
	seasonId = "TWWS2",
	docStructures = docStructures,
}

function DD.dungeons.InitMechagonWorkshop()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
