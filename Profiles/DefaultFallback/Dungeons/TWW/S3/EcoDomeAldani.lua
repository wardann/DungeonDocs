---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type PlayerNote[]
local notes = {

	{
		-- bossName = "Azhiccar",
		ddid = "eda1",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "Taah'bat",
		ddid = "eda2",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "Soul-Scribe",
		ddid = "eda3",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "A'wazj",
		ddid = "eda4",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Ravaging Scavenger",
		ddid = "eda5",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Overgorged Mite",
		ddid = "eda6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Invading Mite",
		ddid = "eda7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Voracious Gorger",
		ddid = "eda8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Ravenous Destroyer",
		ddid = "eda9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Overcharged Sentinel",
		ddid = "eda10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Tamed Ruinstalker",
		ddid = "eda11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Wastelander Farstalker",
		ddid = "eda12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Wastelander Phaseblade",
		ddid = "eda13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Wastelander Ritualist",
		ddid = "eda14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Wastelander Pactspeaker",
		ddid = "eda15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = " K'aresh Elemental",
		ddid = "eda16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Wastes Creeper",
		ddid = "eda17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Burrowing Creeper",
		ddid = "eda18",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Frenzied Mite",
		ddid = "eda19",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Whisper of Fate",
		ddid = "eda20",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Terrified Broker",
		ddid = "eda21",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Unbound Ethereal",
		ddid = "eda22",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "A'wazj",
		ddid = "eda23",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Binding Javelin",
		ddid = "eda24",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Arcane Siphon",
		ddid = "eda25",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = DD.DungeonNames.EcoDomeAldani,
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
