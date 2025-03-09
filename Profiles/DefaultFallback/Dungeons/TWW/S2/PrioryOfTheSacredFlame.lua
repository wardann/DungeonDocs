
---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type PlayerNote[]
local notes = {

	{
		-- bossName = "Captain Dailcry",
		ddid = "potsf1",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "Baron Braunpyke",
		ddid = "potsf2",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "Prioress Murrpray",
		ddid = "potsf3",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Arathi Footman",
		ddid = "potsf4",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Arathi Knight",
		ddid = "potsf5",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Arathi Neophyte",
		ddid = "potsf6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Arathi Neophyte",
		ddid = "potsf7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Arathi Neophyte",
		ddid = "potsf8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Ardent Paladin",
		ddid = "potsf9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Devout Priest",
		ddid = "potsf10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Elaena Emberlanz",
		ddid = "potsf11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Fanatical Conjuror",
		ddid = "potsf12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Fervent Sharpshooter",
		ddid = "potsf13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Forge Master Damian",
		ddid = "potsf14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Guard Captain Suleyman",
		ddid = "potsf15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "High Priest Aemya",
		ddid = "potsf16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Lightspawn",
		ddid = "potsf17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Risen Footman",
		ddid = "potsf18",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Risen Mage",
		ddid = "potsf19",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Sergeant Shaynemail",
		ddid = "potsf20",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Sir Braunpyke",
		ddid = "potsf21",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Taener Duelmal",
		ddid = "potsf22",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "War Lynx",
		ddid = "potsf23",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Zealous Templar",
		ddid = "potsf24",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Arathi Neophyte",
		ddid = "potsf25",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Priory of the Sacred Flame",
		ddid = "potsf26",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Elaena Emberlanz",
		ddid = "potsf27",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Sergeant Shaynemail",
		ddid = "potsf28",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Taener Duelmal",
		ddid = "potsf29",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = "Priory of the Sacred Flame",
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
