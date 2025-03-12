---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type PlayerNote[]
local notes = {

	-- ######  #######  #####   #####  #######  #####
	-- #     # #     # #     # #     # #       #     #
	-- #     # #     # #       #       #       #
	-- ######  #     #  #####   #####  #####    #####
	-- #     # #     #       #       # #             #
	-- #     # #     # #     # #     # #       #     #
	-- ######  #######  #####   #####  #######  #####
	{
		-- bossName = "Affront of Challengers",
		ddid = "top1",
		primaryNote = "- Interrupt [Necrotic Bolts]\n- Avoid ground hazards",
		healerNote = "- Dispel DoTs\n- Save a cooldown for [Mighty Smash]",
		damageNote = "",
		tankNote = "- Mitigate [Mortal Strike]",
	},
	{
		-- bossName = "Xav the Unfallen",
		ddid = "top2",
		primaryNote = "1. NUKE banner to make moving out of green areas easier\n2. Don't actually duel",
		healerNote = "",
		damageNote = "",
		tankNote = "- Mitigate [Brutal Combo]",
	},
	{
		-- bossName = "Gorechop",
		ddid = "top3",
		primaryNote = "1. Stay next to boss until the circle appears and THEN move\n2. Move through the gaps to avoid the meat hooks wall",
		healerNote = "",
		damageNote = "",
		tankNote = "- Mitigate [Hateful Strike]",
	},
	{
		-- bossName = "Kul'tharok",
		ddid = "top4",
		primaryNote = "1. Stack when the boss casts [Draw Soul]\n2. Nuke/CC adds ASAP\n3. Avoid green hazards\n4. Interrupt bolts",
		healerNote = "",
		damageNote = "",
		tankNote = "- Stay in boss's melee range",
	},
	{
		-- bossName = "Mordretha",
		ddid = "top5",
		primaryNote = "- Phase 1: avoid beam & don't get sucked into [Grasping Rift]\n- Phase 2: same, but also avoid ghosts & charges",
		healerNote = "",
		damageNote = "",
		tankNote = "- Mitigate [Reaping Scythe]",
	},

	-- ####### ######     #     #####  #     #
	--    #    #     #   # #   #     # #     #
	--    #    #     #  #   #  #       #     #
	--    #    ######  #     #  #####  #######
	--    #    #   #   #######       # #     #
	--    #    #    #  #     # #     # #     #
	--    #    #     # #     #  #####  #     #
	{
		-- name = "Battlefield Ritualist",
		ddid = "top6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Unyielding Contender",
		ddid = "top7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Raging Bloodhorn",
		ddid = "top8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Shambling Arbalest",
		ddid = "top9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Ossified Conscript",
		ddid = "top10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Dokigg the Brutalizer",
		ddid = "top11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Harugia the Bloodthirsty",
		ddid = "top12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Ancient Captain",
		ddid = "top13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Advent Nevermore",
		ddid = "top14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Shackled Soul",
		ddid = "top15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Portal Guardian",
		ddid = "top16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Bone Magus",
		ddid = "top17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Maniacal Soulbinder",
		ddid = "top18",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Soulforged Bonereaver",
		ddid = "top19",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Nefarious Darkspeaker",
		ddid = "top20",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Disgusting Refuse",
		ddid = "top21",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Diseased Horror",
		ddid = "top22",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Putrid Butcher",
		ddid = "top23",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Rancid Gasbag",
		ddid = "top24",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Nekthara the Mangler",
		ddid = "top25",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Heavin the Breaker",
		ddid = "top26",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Rek the Hardened",
		ddid = "top27",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Blighted Sludge-Spewer",
		ddid = "top28",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Oozing Leftovers",
		ddid = "top29",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Oppressive Banner",
		ddid = "top30",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Lost Soul",
		ddid = "top31",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Deathwalker",
		ddid = "top32",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = "Theater of Pain",
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
