---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type PlayerNote[]
local notes = {

	{
		-- bossName = "Halkias",
		ddid = "hoa1",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "Echelon",
		ddid = "hoa2",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "High Adjudicator Aleez",
		ddid = "hoa3",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- bossName = "Lord Chamberlain",
		ddid = "hoa4",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Depraved Darkblade",
		ddid = "hoa5",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Depraved Houndmaster",
		ddid = "hoa6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Vicious Gargon",
		ddid = "hoa7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Depraved Obliterator",
		ddid = "hoa8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Toiling Groundskeeper",
		ddid = "hoa9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Depraved Collector",
		ddid = "hoa10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Shard of Halkias",
		ddid = "hoa11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Stoneborn Reaver",
		ddid = "hoa12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Stonefiend Anklebiter",
		ddid = "hoa13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Stoneborn Eviscerator",
		ddid = "hoa14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Stoneborn Slasher",
		ddid = "hoa15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Tormented Soul",
		ddid = "hoa16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	{
		-- name = "Inquisitor Sigar",
		ddid = "hoa17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = DD.DungeonNames.HallsOfAtonement,
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
