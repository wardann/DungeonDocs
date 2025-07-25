---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type PlayerNote[]
local notes = {
	{
		-- bossName = "Avanoxx",
		ddid = "ak1",
		primaryNote = "Kill adds before he eats them and wipes the group",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "Anubzekt",
		ddid = "ak2",
		primaryNote = "(1) Avoid swirlies throughout the fight\n(2) At 100 energy, boss summons a swarm. Stay inside the eye of the swarm to survive",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- bossName = "Kikatal The Harvester",
		ddid = "ak3",
		primaryNote = "(1) Create 5-7 blue puddles by striking the slime mobs\n(2) Standing in blue puddles roots you in place\n(3) When the boss casts the pull, STAND IN A PUDDLE to get rooted\n(4) After the pull, KILL ALL ROOTS with EITHER damage or CC\n(5) Avoid swirlies",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Starved Crawler",
		ddid = "ak4",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Jabbing Flyer",
		ddid = "ak5",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Trilling Attendant",
		ddid = "ak6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Engorged Crawler",
		ddid = "ak7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Atik",
		ddid = "ak8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Nakt",
		ddid = "ak9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Ixin",
		ddid = "ak10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Bloodworker",
		ddid = "ak11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Bloodstained Assistant",
		ddid = "ak12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Bloodstained Webmage",
		ddid = "ak13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Hulking Bloodguard",
		ddid = "ak14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Sentry Stagshell",
		ddid = "ak15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Blood Overseer",
		ddid = "ak16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Winged Carrier",
		ddid = "ak17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Nerubian Hauler",
		ddid = "ak18",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Reinforced Drone",
		ddid = "ak19",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = DD.DungeonNames.AraKara,
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
