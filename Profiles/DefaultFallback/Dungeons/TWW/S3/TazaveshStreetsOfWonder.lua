---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type PlayerNote[]
local notes = {

	{
		-- bossName = "Zo'phex",
		ddid = "tsow1",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "Zo'gron",
		ddid = "tsow2",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "Alcruux",
		ddid = "tsow3",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "Achillite",
		ddid = "tsow4",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "Venza Goldfuse",
		ddid = "tsow5",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "P.O.S.T. Master",
		ddid = "tsow6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "So'azmi",
		ddid = "tsow7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Customs Security",
		ddid = "tsow8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Gatewarden Zo'mazz",
		ddid = "tsow9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Support Officer",
		ddid = "tsow10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Interrogation Specialist",
		ddid = "tsow11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Armored Overseer",
		ddid = "tsow12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Portalmancer Zo'honn",
		ddid = "tsow13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Tracker Zo'korss",
		ddid = "tsow14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Ancient Core Hound",
		ddid = "tsow15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Enraged Direhorn",
		ddid = "tsow16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Frenzied Nightclaw",
		ddid = "tsow17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Market Peacekeeper",
		ddid = "tsow18",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Veteran Sparkcaster",
		ddid = "tsow19",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Commerce Enforcer",
		ddid = "tsow20",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Commander Zo'far",
		ddid = "tsow21",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Cartel Muscle",
		ddid = "tsow22",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Cartel Smuggler",
		ddid = "tsow23",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Cartel Wiseguy",
		ddid = "tsow24",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Cartel Skulker",
		ddid = "tsow25",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Oasis Security",
		ddid = "tsow26",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Disruptive Patron",
		ddid = "tsow27",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Brawling Patron",
		ddid = "tsow28",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Defective Sorter",
		ddid = "tsow29",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "P.O.S.T. Worker",
		ddid = "tsow30",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Overloaded Mailemental",
		ddid = "tsow31",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = DD.DungeonNames.TazaveshStreetsOfWonder,
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
