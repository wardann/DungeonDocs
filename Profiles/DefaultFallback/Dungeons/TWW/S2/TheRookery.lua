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
		-- bossName = "Kyrioss",
		ddid = "tr1",
		primaryNote = "- Don't overlap circles\n- Electricity = ouch",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "Stormguard Gorren",
		ddid = "tr2",
		primaryNote = "1. Don't pass the DoT to someone with the debuff (unless you know they can mitigate the damage)\n2. Avoid the crush & void tornadoes\n3. Run when boss uses gravity pull",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "Voidstone Monstrosity",
		ddid = "tr3",
		primaryNote = "1. Stay spread out around the boss\n2. After big smash, avoid puddles and move with blue circle on top of crystals",
		healerNote = "- Dispel DoTs, but be careful with positioning as dispelling creates puddles",
		damageNote = "",
		tankNote = "- Point wave attack away from group",
	},

	-- ####### ######     #     #####  #     #
	--    #    #     #   # #   #     # #     #
	--    #    #     #  #   #  #       #     #
	--    #    ######  #     #  #####  #######
	--    #    #   #   #######       # #     #
	--    #    #    #  #     # #     # #     #
	--    #    #     # #     #  #####  #     #
	{
		-- name = "Quartermaster Koratite",
		ddid = "tr4",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Cursed Thunderer",
		ddid = "tr5",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Cursed Rookguard",
		ddid = "tr6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Voidrider",
		ddid = "tr7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Unruly Stormrook",
		ddid = "tr8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Cursed Rooktender",
		ddid = "tr9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Void-Cursed Crusher",
		ddid = "tr10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Corrupted Oracle",
		ddid = "tr11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Coalescing Void Diffuser",
		ddid = "tr12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Afflicted Civilian",
		ddid = "tr13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Void Ascendant",
		ddid = "tr14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Radiating Voidstone",
		ddid = "tr15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Stormrider Vokmar",
		ddid = "tr16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Voidstone Awakened",
		ddid = "tr17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = DD.DungeonNames.TheRookery,
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
