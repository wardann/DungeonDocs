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
		-- bossName = "Coin-Operated Crowd Pummeler",
		ddid = "tm1",
		primaryNote = "- Kick balls into boss\n- Avoid slam",
		healerNote = "",
		damageNote = "",
		tankNote = "- Move boss away from coins on ground",
	},
	{
		-- bossName = "Azerokk",
		ddid = "tm2",
		primaryNote = "1. Kite & CC adds\n2. Kill infused add ASAP\n3. Stay out of quake and smash",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "Rixxa Fluxflame",
		ddid = "tm3",
		primaryNote = "- Drop puddles next to each other to save space\n- Aim boss's [Propellant Blast] towards puddles to clear them",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "Mogul Razdunk",
		ddid = "tm4",
		primaryNote = "PHASE 1:\n\n- Stay close to boss\n- Move out when targeted by missle\n- Don't get gunned down\n\n\nPHASE 2:\n\n- Nuke adds\n- If marked by [Drill Smash], move next to a pillar. Move out when red circle appears",
		healerNote = "",
		damageNote = "",
		tankNote = "- Watch mobs on the edges to figure out safe quadrant. Move boss there",
	},

	-- ####### ######     #     #####  #     #
	--    #    #     #   # #   #     # #     #
	--    #    #     #  #   #  #       #     #
	--    #    ######  #     #  #####  #######
	--    #    #   #   #######       # #     #
	--    #    #    #  #     # #     # #     #
	--    #    #     # #     #  #####  #     #
	{
		-- name = "Big Money Crab",
		ddid = "tm5",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Off-Duty Laborer",
		ddid = "tm6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Refreshment Vendor",
		ddid = "tm7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Mech Jockey",
		ddid = "tm8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Addled Thug",
		ddid = "tm9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Hired Assassin",
		ddid = "tm10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Mechanized Peacekeeper",
		ddid = "tm11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. Earthshaper",
		ddid = "tm12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Mine Rat",
		ddid = "tm13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Wanton Sapper",
		ddid = "tm14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Azerite Extractor",
		ddid = "tm15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Safety Shark",
		ddid = "tm16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Shalebiter",
		ddid = "tm17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Stonefury",
		ddid = "tm18",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Taskmaster Askari",
		ddid = "tm19",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Earthrager",
		ddid = "tm20",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Footbomb Hooligan",
		ddid = "tm21",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. Mastermind",
		ddid = "tm22",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Weapons Tester",
		ddid = "tm23",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. Alchemist",
		ddid = "tm24",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Test Subject",
		ddid = "tm25",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. War Machine",
		ddid = "tm26",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Ordnance Specialist",
		ddid = "tm27",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Crawler Mine",
		ddid = "tm28",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Venture Co. Skyscorcher",
		ddid = "tm29",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "B.O.O.M.B.A.",
		ddid = "tm30",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Azerite Footbomb",
		ddid = "tm31",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = "The MOTHERLODE!!",
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
