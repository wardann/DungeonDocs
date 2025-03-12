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
		-- bossName = "Brewmaster Aldryr",
		ddid = "cbm1",
		primaryNote = "1. Before intermission: avoid hazards\n2. During intermission: bring brews to red patrons\n3. After intermission: avoid more hazards",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "Benk Buzzbee",
		ddid = "cbm2",
		primaryNote = "Kill bee adds, then click on them and ram them into the barrels",
		healerNote = "",
		damageNote = "",
		tankNote = "Drop puddles at the edge of the room",
	},
	{
		-- bossName = "I'pa",
		ddid = "cbm3",
		primaryNote = "- CC and nuke adds ASAP\n- Do NOT let adds touch the boss",
		healerNote = "",
		damageNote = "",
		tankNote = "- Kite when possible",
	},
	{
		-- bossName = "Goldie Baronbottom",
		ddid = "cbm4",
		primaryNote = "- Destroy the big barrles with the red circle attack\n- Don't destroy too many barrels at once",
		healerNote = "",
		damageNote = "",
		tankNote = "- The frontal can also be used to destroy barrels",
	},

	-- ####### ######     #     #####  #     #
	--    #    #     #   # #   #     # #     #
	--    #    #     #  #   #  #       #     #
	--    #    ######  #     #  #####  #######
	--    #    #   #   #######       # #     #
	--    #    #    #  #     # #     # #     #
	--    #    #     # #     #  #####  #     #
	{
		-- name = "Tasting Room Attendant",
		ddid = "cbm5",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. Pyromaniac",
		ddid = "cbm6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. Patron",
		ddid = "cbm7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Hired Muscle",
		ddid = "cbm8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Chef Chewie",
		ddid = "cbm9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Worker Bee",
		ddid = "cbm10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Royal Jelly Purveyor",
		ddid = "cbm11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. Honey Harvester",
		ddid = "cbm12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Bee Wrangler",
		ddid = "cbm13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Bee-let",
		ddid = "cbm14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Taste Tester",
		ddid = "cbm15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Careless Hopgoblin",
		ddid = "cbm16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Brew Drop",
		ddid = "cbm17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Yes Man",
		ddid = "cbm18",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Flavor Scientist",
		ddid = "cbm19",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Ravenous Cinderbee",
		ddid = "cbm20",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = "Cinderbrew Meadery",
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
