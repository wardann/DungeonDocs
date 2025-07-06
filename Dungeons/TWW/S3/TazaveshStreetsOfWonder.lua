---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "tsow" .. index
end

---@class Dungeons
DD.dungeons = DD.dungeons or {}

---@type DocStructure[]
local docStructures = {
	{
		docName = "Zo'phex",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Zo'phex",
				id = "175616",
				displayId = 100049,
			},
		},
	},
	{
		docName = "Zo'gron",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Zo'gron",
				id = "176563",
				displayId = 101481,
			},
		},
	},
	{
		docName = "Alcruux",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "Alcruux",
				id = "176556",
				displayId = 101039,
			},
		},
	},
	{
		docName = "Achillite",
		ddid = createDDID(4),
		isBoss = true,
		mobs = {
			{
				-- name = "Achillite",
				id = "176555",
				displayId = 101044,
			},
		},
	},
	{
		docName = "Venza Goldfuse",
		ddid = createDDID(5),
		isBoss = true,
		mobs = {
			{
				-- name = "Venza Goldfuse",
				id = "176705",
				displayId = 100564,
			},
		},
	},
	{
		docName = "P.O.S.T. Master",
		ddid = createDDID(6),
		isBoss = true,
		mobs = {
			{
				-- name = "P.O.S.T. Master",
				id = "175646",
				displayId = 100722,
			},
		},
	},
	{
		docName = "So'azmi",
		ddid = createDDID(7),
		isBoss = true,
		mobs = {
			{
				-- name = "So'azmi",
				id = "175806",
				displayId = 99094,
			},
		},
	},
	{
		docName = "Customs Security",
		ddid = createDDID(8),
		mobs = {
			{
				-- name = "Customs Security",
				id = "177807",
				displayId = 100873,
			},
		},
	},
	{
		docName = "Gatewarden Zo'mazz",
		ddid = createDDID(9),
		mobs = {
			{
				-- name = "Gatewarden Zo'mazz",
				id = "178392",
				displayId = 101505,
			},
		},
	},
	{
		docName = "Support Officer",
		ddid = createDDID(10),
		mobs = {
			{
				-- name = "Support Officer",
				id = "177817",
				displayId = 100876,
			},
		},
	},
	{
		docName = "Interrogation Specialist",
		ddid = createDDID(11),
		mobs = {
			{
				-- name = "Interrogation Specialist",
				id = "177816",
				displayId = 100877,
			},
		},
	},
	{
		docName = "Armored Overseer",
		ddid = createDDID(12),
		mobs = {
			{
				-- name = "Armored Overseer",
				id = "177808",
				displayId = 100874,
			},
		},
	},
	{
		docName = "Portalmancer Zo'honn",
		ddid = createDDID(13),
		mobs = {
			{
				-- name = "Portalmancer Zo'honn",
				id = "179334",
				displayId = 100877,
			},
		},
	},
	{
		docName = "Tracker Zo'korss",
		ddid = createDDID(14),
		mobs = {
			{
				-- name = "Tracker Zo'korss",
				id = "179837",
				displayId = 101474,
			},
		},
	},
	{
		docName = "Ancient Core Hound",
		ddid = createDDID(15),
		mobs = {
			{
				-- name = "Ancient Core Hound",
				id = "180091",
				displayId = 101639,
			},
		},
	},
	{
		docName = "Enraged Direhorn",
		ddid = createDDID(16),
		mobs = {
			{
				-- name = "Enraged Direhorn",
				id = "180495",
				displayId = 47441,
			},
		},
	},
	{
		docName = "Frenzied Nightclaw",
		ddid = createDDID(17),
		mobs = {
			{
				-- name = "Frenzied Nightclaw",
				id = "180567",
				displayId = 101951,
			},
		},
	},
	{
		docName = "Market Peacekeeper",
		ddid = createDDID(18),
		mobs = {
			{
				-- name = "Market Peacekeeper",
				id = "179840",
				displayId = 101475,
			},
		},
	},
	{
		docName = "Veteran Sparkcaster",
		ddid = createDDID(19),
		mobs = {
			{
				-- name = "Veteran Sparkcaster",
				id = "179841",
				displayId = 101476,
			},
		},
	},
	{
		docName = "Commerce Enforcer",
		ddid = createDDID(20),
		mobs = {
			{
				-- name = "Commerce Enforcer",
				id = "179842",
				displayId = 101477,
			},
		},
	},
	{
		docName = "Commander Zo'far",
		ddid = createDDID(21),
		mobs = {
			{
				-- name = "Commander Zo'far",
				id = "179821",
				displayId = 101473,
			},
		},
	},
	{
		docName = "Cartel Muscle",
		ddid = createDDID(22),
		mobs = {
			{
				-- name = "Cartel Muscle",
				id = "180348",
				displayId = 101598,
			},
		},
	},
	{
		docName = "Cartel Smuggler",
		ddid = createDDID(23),
		mobs = {
			{
				-- name = "Cartel Smuggler",
				id = "180335",
				displayId = 101595,
			},
		},
	},
	{
		docName = "Cartel Wiseguy",
		ddid = createDDID(24),
		mobs = {
			{
				-- name = "Cartel Wiseguy",
				id = "180336",
				displayId = 101596,
			},
		},
	},
	{
		docName = "Cartel Skulker",
		ddid = createDDID(25),
		mobs = {
			{
				-- name = "Cartel Skulker",
				id = "179893",
				displayId = 101734,
			},
		},
	},
	{
		docName = "Oasis Security",
		ddid = createDDID(26),
		mobs = {
			{
				-- name = "Oasis Security",
				id = "179269",
				displayId = 101270,
			},
		},
	},
	{
		docName = "Disruptive Patron",
		ddid = createDDID(27),
		mobs = {
			{
				-- name = "Disruptive Patron",
				id = "176565",
				displayId = 101271,
			},
		},
	},
	{
		docName = "Brawling Patron",
		ddid = createDDID(28),
		mobs = {
			{
				-- name = "Brawling Patron",
				id = "180159",
				displayId = 101546,
			},
		},
	},
	{
		docName = "Brawling Patron",
		ddid = createDDID(29),
		mobs = {
			{
				-- name = "Brawling Patron",
				id = "176562",
				displayId = 101544,
			},
		},
	},
	{
		docName = "Defective Sorter",
		ddid = createDDID(30),
		mobs = {
			{
				-- name = "Defective Sorter",
				id = "176396",
				displayId = 100408,
			},
		},
	},
	{
		docName = "P.O.S.T. Worker",
		ddid = createDDID(31),
		mobs = {
			{
				-- name = "P.O.S.T. Worker",
				id = "176394",
				displayId = 100406,
			},
		},
	},
	{
		docName = "Overloaded Mailemental",
		ddid = createDDID(32),
		mobs = {
			{
				-- name = "Overloaded Mailemental",
				id = "176395",
				displayId = 68547,
			},
		},
	},
}

---@type DungeonData
local dungeonData = {
	dungeonName = DD.DungeonNames.TazaveshStreetsOfWonder,
	icon = "Interface\\Icons\\inv_misc_coinbag_special",
	docStructures = docStructures,
}

function DD.dungeons.InitTazaveshStreetsOfWonder()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
