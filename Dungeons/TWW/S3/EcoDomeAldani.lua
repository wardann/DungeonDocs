---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "eda" .. index
end

---@class Dungeons
DD.dungeons = DD.dungeons or {}

---@type DocStructure[]
local docStructures = {
	{
		docName = "Azhiccar",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Azhiccar",
				id = "234893",
				displayId = 131246,
			},
		},
	},
	{
		docName = "Taah'bat",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Taah'bat",
				id = "234933",
				displayId = 123825,
			},
		},
	},
	{
		docName = "Soul-Scribe",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "Soul-Scribe",
				id = "234935",
				displayId = 128654,
			},
		},
	},
	{
		docName = "A'wazj",
		ddid = createDDID(4),
		isBoss = true,
		mobs = {
			{
				-- name = "A'wazj",
				id = "237514",
				displayId = 126474,
			},
		},
	},
	{
		docName = "Ravaging Scavenger",
		ddid = createDDID(5),
		mobs = {
			{
				-- name = "Ravaging Scavenger",
				id = "234912",
				displayId = 131383,
			},
			{
				-- name = "Ravaging Scavenger",
				id = "245411",
				displayId = 100364,
			},
		},
	},
	{
		docName = "Overgorged Mite",
		ddid = createDDID(6),
		mobs = {
			{
				-- name = "Overgorged Mite",
				id = "242209",
				displayId = 131381,
			},
		},
	},
	{
		docName = "Invading Mite",
		ddid = createDDID(7),
		mobs = {
			{
				-- name = "Invading Mite",
				id = "234870",
				displayId = 131382,
			},
		},
	},
	{
		docName = "Voracious Gorger",
		ddid = createDDID(8),
		mobs = {
			{
				-- name = "Voracious Gorger",
				id = "234883",
				displayId = 131385,
			},
			{
				-- name = "Voracious Gorger",
				id = "245412",
				displayId = 94225,
			},
		},
	},
	{
		docName = "Ravenous Destroyer",
		ddid = createDDID(9),
		mobs = {
			{
				-- name = "Ravenous Destroyer",
				id = "236995",
				displayId = 129837,
			},
		},
	},
	{
		docName = "Overcharged Sentinel",
		ddid = createDDID(10),
		mobs = {
			{
				-- name = "Overcharged Sentinel",
				id = "242631",
				displayId = 126549,
			},
		},
	},
	{
		docName = "Tamed Ruinstalker",
		ddid = createDDID(11),
		mobs = {
			{
				-- name = "Tamed Ruinstalker",
				id = "234960",
				displayId = 131397,
			},
		},
	},
	{
		docName = "Wastelander Farstalker",
		ddid = createDDID(12),
		mobs = {
			{
				-- name = "Wastelander Farstalker",
				id = "234962",
				displayId = 123861,
			},
		},
	},
	{
		docName = "Wastelander Phaseblade",
		ddid = createDDID(13),
		mobs = {
			{
				-- name = "Wastelander Phaseblade",
				id = "234872",
				displayId = 131410,
			},
		},
	},
	{
		docName = "Wastelander Ritualist",
		ddid = createDDID(14),
		mobs = {
			{
				-- name = "Wastelander Ritualist",
				id = "234957",
				displayId = 123820,
			},
		},
	},
	{
		docName = "Wastelander Pactspeaker",
		ddid = createDDID(15),
		mobs = {
			{
				-- name = "Wastelander Pactspeaker",
				id = "234955",
				displayId = 123884,
			},
		},
	},
	{
		docName = " K'aresh Elemental",
		ddid = createDDID(16),
		mobs = {
			{
				-- name = " K'aresh Elemental",
				id = "235151",
				displayId = 129736,
			},
		},
	},
	{
		docName = "Wastes Creeper",
		ddid = createDDID(17),
		mobs = {
			{
				-- name = "Wastes Creeper",
				id = "234918",
				displayId = 131441,
			},
		},
	},
	{
		docName = "Burrowing Creeper",
		ddid = createDDID(18),
		mobs = {
			{
				-- name = "Burrowing Creeper",
				id = "245092",
				displayId = 131449,
			},
		},
	},
	{
		docName = "Frenzied Mite",
		ddid = createDDID(19),
		mobs = {
			{
				-- name = "Frenzied Mite",
				id = "236190",
				displayId = 130695,
			},
		},
	},
	{
		docName = "Whisper of Fate",
		ddid = createDDID(20),
		mobs = {
			{
				-- name = "Whisper of Fate",
				id = "240253",
				displayId = 92725,
			},
		},
	},
	{
		docName = "Terrified Broker",
		ddid = createDDID(21),
		mobs = {
			{
				-- name = "Terrified Broker",
				id = "244927",
				displayId = 130323,
			},
		},
	},
	{
		docName = "Unbound Ethereal",
		ddid = createDDID(22),
		mobs = {
			{
				-- name = "Unbound Ethereal",
				id = "239379",
				displayId = 123951,
			},
		},
	},
	{
		docName = "A'wazj",
		ddid = createDDID(23),
		mobs = {
			{
				-- name = "A'wazj",
				id = "241375",
				displayId = 126474,
			},
		},
	},
	{
		docName = "Binding Javelin",
		ddid = createDDID(24),
		mobs = {
			{
				-- name = "Binding Javelin",
				id = "244302",
				displayId = 131370,
			},
		},
	},
	{
		docName = "Arcane Siphon",
		ddid = createDDID(25),
		mobs = {
			{
				-- name = "Arcane Siphon",
				id = "247244",
				displayId = 92725,
			},
		},
	},
}

---@type DungeonData
local dungeonData = {
	dungeonName = DD.DungeonNames.EcoDomeAldani,
	icon = "Interface\\Icons\\inv_spell_arcane_telepotdornogal",
	docStructures = docStructures,
}

function DD.dungeons.InitEcoDomeAldani()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
