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
		-- bossName = "Ol' Waxbeard",
		ddid = "dfc1",
		primaryNote = "1. Destroy dynamite cart ASAP\n2. Don't get caught by mobs if fixated. Run, CC, or bait them into carts\n3. Avoid charge",
		healerNote = "",
		damageNote = "",
		tankNote = "- Mitigate [Rock Buster]",
	},
	{
		-- bossName = "Blazikon",
		ddid = "dfc2",
		primaryNote = "- Light candles by moving red circle barrage on them\n- Make sure one candle is lit during [Inferno]\n- Extinguish candles by baiting gust attack towards them\n- Make sure one candle is unlit during [Incite Flames]",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "The Candle King",
		ddid = "dfc3",
		primaryNote = "1. Destroy statues with the purple circle attack or by baiting the pickaxe when targeted\n2. Interrupt [Paranoid Mind]",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "The Darkness",
		ddid = "dfc4",
		primaryNote = "DO NOT let candle die!\n\n1. Move out of purple circle\n2. Move candle out of frontal\n3. Replenish candle\n4. Interrupt [Call Darkspawn]",
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
		-- name = "Menial Laborer",
		ddid = "dfc5",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Rank Overseer",
		ddid = "dfc6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Lowly Moleherd",
		ddid = "dfc7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Pack Mole",
		ddid = "dfc8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Royal Wicklighter",
		ddid = "dfc9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Kobold Taskworker",
		ddid = "dfc10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Blazing Fiend",
		ddid = "dfc11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Wandering Candle",
		ddid = "dfc12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Kobold Flametender",
		ddid = "dfc13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Sootsnout",
		ddid = "dfc14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Torchsnarl",
		ddid = "dfc15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Skittering Darkness",
		ddid = "dfc16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Shuffling Horror",
		ddid = "dfc17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Corridor Creeper",
		ddid = "dfc18",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Corridor Sleeper",
		ddid = "dfc19",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Dynamite Mine Cart",
		ddid = "dfc20",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Wriggling Darkspawn",
		ddid = "dfc21",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = DD.DungeonNames.DarkflameCleft,
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
