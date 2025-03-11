---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "top" .. index
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
		docName = "Affront of Challengers",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Dessia the Decapitator",
				id = "164451",
				displayId = 96820,
			},
			{
				-- name = "Paceran the Virulent",
				id = "164463",
				displayId = 98081,
			},
			{
				-- name = "Sathel the Accursed",
				id = "164461",
				displayId = 98082,
			},
		},
	},
	{
		docName = "Xav the Unfallen",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Xav the Unfallen",
				id = "162329",
				displayId = 95439,
			},
		},
	},
	{
		docName = "Gorechop",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "Gorechop",
				id = "162317",
				displayId = 95106,
			},
		},
	},
	{
		docName = "Kul'tharok",
		ddid = createDDID(4),
		isBoss = true,
		mobs = {
			{
				-- name = "Kul'tharok",
				id = "162309",
				displayId = 96088,
			},
		},
	},
	{
		docName = "Mordretha",
		ddid = createDDID(5),
		isBoss = true,
		mobs = {
			{
				-- name = "Mordretha",
				id = " the Endless Empress",
				displayId = 165946,
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
		docName = "Battlefield Ritualist",
		ddid = createDDID(6),
		mobs = {
			{
				-- name = "Battlefield Ritualist",
				id = "174197",
				displayId = 98696,
			},
		},
	},
	{
		docName = "Unyielding Contender",
		ddid = createDDID(7),
		mobs = {
			{
				-- name = "Unyielding Contender",
				id = "170838",
				displayId = 95570,
			},
		},
	},
	{
		docName = "Raging Bloodhorn",
		ddid = createDDID(8),
		mobs = {
			{
				-- name = "Raging Bloodhorn",
				id = "170850",
				displayId = 96471,
			},
		},
	},
	{
		docName = "Shambling Arbalest",
		ddid = createDDID(9),
		mobs = {
			{
				-- name = "Shambling Arbalest",
				id = "164510",
				displayId = 96212,
			},
		},
	},
	{
		docName = "Ossified Conscript",
		ddid = createDDID(10),
		mobs = {
			{
				-- name = "Ossified Conscript",
				id = "167994",
				displayId = 96253,
			},
		},
	},
	{
		docName = "Dokigg the Brutalizer",
		ddid = createDDID(11),
		mobs = {
			{
				-- name = "Dokigg the Brutalizer",
				id = "167538",
				displayId = 97488,
			},
		},
	},
	{
		docName = "Harugia the Bloodthirsty",
		ddid = createDDID(12),
		mobs = {
			{
				-- name = "Harugia the Bloodthirsty",
				id = "167536",
				displayId = 126297,
			},
		},
	},
	{
		docName = "Ancient Captain",
		ddid = createDDID(13),
		mobs = {
			{
				-- name = "Ancient Captain",
				id = "164506",
				displayId = 96489,
			},
		},
	},
	{
		docName = "Advent Nevermore",
		ddid = createDDID(14),
		mobs = {
			{
				-- name = "Advent Nevermore",
				id = "167533",
				displayId = 126299,
			},
		},
	},
	{
		docName = "Shackled Soul",
		ddid = createDDID(15),
		mobs = {
			{
				-- name = "Shackled Soul",
				id = "169875",
				displayId = 90428,
			},
		},
	},
	{
		docName = "Portal Guardian",
		ddid = createDDID(16),
		mobs = {
			{
				-- name = "Portal Guardian",
				id = "167998",
				displayId = 96442,
			},
		},
	},
	{
		docName = "Bone Magus",
		ddid = createDDID(17),
		mobs = {
			{
				-- name = "Bone Magus",
				id = "170882",
				displayId = 97410,
			},
		},
	},
	{
		docName = "Maniacal Soulbinder",
		ddid = createDDID(18),
		mobs = {
			{
				-- name = "Maniacal Soulbinder",
				id = "160495",
				displayId = 95233,
			},
		},
	},
	{
		docName = "Soulforged Bonereaver",
		ddid = createDDID(19),
		mobs = {
			{
				-- name = "Soulforged Bonereaver",
				id = "162763",
				displayId = 94812,
			},
		},
	},
	{
		docName = "Nefarious Darkspeaker",
		ddid = createDDID(20),
		mobs = {
			{
				-- name = "Nefarious Darkspeaker",
				id = "169893",
				displayId = 97011,
			},
		},
	},
	{
		docName = "Disgusting Refuse",
		ddid = createDDID(21),
		mobs = {
			{
				-- name = "Disgusting Refuse",
				id = "163089",
				displayId = 94761,
			},
		},
	},
	{
		docName = "Diseased Horror",
		ddid = createDDID(22),
		mobs = {
			{
				-- name = "Diseased Horror",
				id = "170690",
				displayId = 97117,
			},
		},
	},
	{
		docName = "Putrid Butcher",
		ddid = createDDID(23),
		mobs = {
			{
				-- name = "Putrid Butcher",
				id = "169927",
				displayId = 97116,
			},
		},
	},
	{
		docName = "Rancid Gasbag",
		ddid = createDDID(24),
		mobs = {
			{
				-- name = "Rancid Gasbag",
				id = "163086",
				displayId = 97161,
			},
		},
	},
	{
		docName = "Nekthara the Mangler",
		ddid = createDDID(25),
		mobs = {
			{
				-- name = "Nekthara the Mangler",
				id = "162744",
				displayId = 97489,
			},
		},
	},
	{
		docName = "Heavin the Breaker",
		ddid = createDDID(26),
		mobs = {
			{
				-- name = "Heavin the Breaker",
				id = "167532",
				displayId = 97490,
			},
		},
	},
	{
		docName = "Rek the Hardened",
		ddid = createDDID(27),
		mobs = {
			{
				-- name = "Rek the Hardened",
				id = "167534",
				displayId = 126296,
			},
		},
	},
	{
		docName = "Blighted Sludge-Spewer",
		ddid = createDDID(28),
		mobs = {
			{
				-- name = "Blighted Sludge-Spewer",
				id = "174210",
				displayId = 94755,
			},
		},
	},
	{
		docName = "Oozing Leftovers",
		ddid = createDDID(29),
		mobs = {
			{
				-- name = "Oozing Leftovers",
				id = "165260",
				displayId = 94761,
			},
		},
	},
	{
		docName = "Oppressive Banner",
		ddid = createDDID(30),
		mobs = {
			{
				-- name = "Oppressive Banner",
				id = "170234",
				displayId = 97254,
			},
		},
	},
	{
		docName = "Lost Soul",
		ddid = createDDID(31),
		mobs = {
			{
				-- name = "Lost Soul",
				id = "234443",
				displayId = 96131,
			},
		},
	},
	{
		docName = "Deathwalker",
		ddid = createDDID(32),
		mobs = {
			{
				-- name = "Deathwalker",
				id = "166524",
				displayId = 96337,
			},
		},
	},
}

---@type DungeonData
local dungeonData = {
	dungeonName = "Theater Of Pain",
	icon = "Interface\\Icons\\spell_shadow_requiem",
	seasonId = "TWWS2",
	docStructures = docStructures,
}

function DD.dungeons.InitTheaterOfPain()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
