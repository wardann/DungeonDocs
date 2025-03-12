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
		-- bossName = "Big M.O.M.M.A.",
		ddid = "of1",
		primaryNote = "1) Focus adds, interrupt them, avoid their charge\n2) When targeted, point [Sonic Boom] away from group",
		healerNote = "",
		damageNote = "",
		tankNote = "- Mitigate [Electrocrush]\n- Move boss after each intermission",
	},
	{
		-- bossName = "Demolition Duo",
		ddid = "of2",
		primaryNote = "1) When targeted by the charge, bait boss to run over bombs\n2) When circle spawns around you, go next to bombs",
		healerNote = "- Dispel circle from players next to bombs to destroy them",
		damageNote = "",
		tankNote = "- Mitigate [Wallop]",
	},
	{
		-- bossName = "Swampface",
		ddid = "of3",
		primaryNote = "Stay next to the player you're tethered to. Dodge the boss's attacks together",
		healerNote = "",
		damageNote = "",
		tankNote = "Mitigate [Sludge Claws]",
	},
	{
		-- bossName = "Geezle Gigazap",
		ddid = "of4",
		primaryNote = "1) Do NOT step in water puddles with the [Gigazap] DoT\n2) Bait the sparks that focus you into the water puddles",
		healerNote = "",
		damageNote = "",
		tankNote = "- Do NOT get knocked out of the arena by [Thunder Punch]",
	},

	-- ####### ######     #     #####  #     #
	--    #    #     #   # #   #     # #     #
	--    #    #     #  #   #  #       #     #
	--    #    ######  #     #  #####  #######
	--    #    #   #   #######       # #     #
	--    #    #    #  #     # #     # #     #
	--    #    #     # #     #  #####  #     #
	{
		-- name = "Shreddinator 3000",
		ddid = "of5",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Darkfuse Soldier",
		ddid = "of6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Mechadrone Sniper",
		ddid = "of7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Loaderbot",
		ddid = "of8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. Contractor",
		ddid = "of9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Darkfuse Hyena",
		ddid = "of10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Darkfuse Demolitionist",
		ddid = "of11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Darkfuse Bloodwarper",
		ddid = "of12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Darkfuse Inspector",
		ddid = "of13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. Surveyor",
		ddid = "of14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. Electrician",
		ddid = "of15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Bombshell Crab",
		ddid = "of16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. Diver",
		ddid = "of17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. Architect",
		ddid = "of18",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Disturbed Kelp",
		ddid = "of19",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Bubbles",
		ddid = "of20",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Darkfuse Jumpstarter",
		ddid = "of21",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Darkfuse Mechadrone",
		ddid = "of22",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Undercrawler",
		ddid = "of23",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Waterworks Crocolisk",
		ddid = "of24",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = "Operation: Floodgate",
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
