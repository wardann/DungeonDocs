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
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "Demolition Duo",
		ddid = "of2",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "Swampface",
		ddid = "of3",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "Geezle Gigazap",
		ddid = "of4",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
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
