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
		-- bossName = "Tussle Tonks",
		ddid = "mw1",
		primaryNote = "- Don't get tossed into bombs\n- Avoid saw blades\n- Avoid red areas on ground",
		healerNote = "",
		damageNote = "",
		tankNote = "- Remove plating using hammers\n- Mitigate [Pummel]",
	},
	{
		-- bossName = "K.U.-J.0.",
		ddid = "mw2",
		primaryNote = "- Hide behind boxes when boss casts [Venting Flames]\n- Stay AWAY from boxes when targeted by leap",
		healerNote = "- Dispelling chomp debuff does party damage. Be careful!",
		damageNote = "",
		tankNote = "- Mitigate [Blazing Chomp]",
	},
	{
		-- bossName = "Head Machinist Sparkflux",
		ddid = "mw3",
		primaryNote = "- Stun & kill plants ASAP\n- AVOID fire, gears, lasers",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "King Mechagon",
		ddid = "mw4",
		primaryNote = "PHASE 1:\n\n- Avoid Plasma Orbs\n\n\nPHASE 2:\n\n- Move as little as possible if targeted by [Mega Zap], everyone else step out of cone\n- When magnet pulls, avoid plasma orbs & use defensives",
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
		-- name = "Blastatron X-80",
		ddid = "mw5",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Defense Bot Mk I",
		ddid = "mw6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Mechagon Tinkerer",
		ddid = "mw7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Workshop Defender",
		ddid = "mw8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Mechagon Mechanic",
		ddid = "mw9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Spider Tank",
		ddid = "mw10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Defense Bot Mk III",
		ddid = "mw11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Junkyard D.0.G.",
		ddid = "mw12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Waste Processing Unit",
		ddid = "mw13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Living Waste",
		ddid = "mw14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Bomb Tonk",
		ddid = "mw15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Rocket Tonk",
		ddid = "mw16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Strider Tonk",
		ddid = "mw17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "G.U.A.R.D.",
		ddid = "mw18",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Metal Gunk",
		ddid = "mw19",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Inconspicuous Plant",
		ddid = "mw20",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = DD.DungeonNames.MechagonWorkshop,
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
