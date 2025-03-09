
---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type CreateDDID
local function createDDID(index)
	return "tm" .. index
end

---@class Dungeons
DD.dungeons = DD.dungeons or {}

---@type DocStructure[]
local docStructures = {
	{
		docName = "Coin-Operated Crowd Pummeler",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Coin-Operated Crowd Pummeler",
				id = "129214",
				displayId = 80443,
			},
		},
	},
	{
		docName = "Azerokk",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Azerokk",
				id = "129227",
				displayId = 83891,
			},
		},
	},
	{
		docName = "Rixxa Fluxflame",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "Rixxa Fluxflame",
				id = "129231",
				displayId = 81489,
			},
		},
	},
	{
		docName = "Mogul Razdunk",
		ddid = createDDID(4),
		isBoss = true,
		mobs = {
			{
				-- name = "Mogul Razdunk",
				id = "129232",
				displayId = 127820,
			},
		},
	},
	{
		docName = "Big Money Crab",
		ddid = createDDID(5),
		mobs = {
			{
				-- name = "Big Money Crab",
				id = "137713",
				displayId = 32024,
			},
		},
	},
	{
		docName = "Off-Duty Laborer",
		ddid = createDDID(6),
		mobs = {
			{
				-- name = "Off-Duty Laborer",
				id = "130436",
				displayId = 81226,
			},
		},
	},
	{
		docName = "Refreshment Vendor",
		ddid = createDDID(7),
		mobs = {
			{
				-- name = "Refreshment Vendor",
				id = "136470",
				displayId = 84784,
			},
		},
	},
	{
		docName = "Mech Jockey",
		ddid = createDDID(8),
		mobs = {
			{
				-- name = "Mech Jockey",
				id = "130488",
				displayId = 81265,
			},
		},
	},
	{
		docName = "Addled Thug",
		ddid = createDDID(9),
		mobs = {
			{
				-- name = "Addled Thug",
				id = "130435",
				displayId = 124175,
			},
		},
	},
	{
		docName = "Hired Assassin",
		ddid = createDDID(10),
		mobs = {
			{
				-- name = "Hired Assassin",
				id = "134232",
				displayId = 83395,
			},
		},
	},
	{
		docName = "Mechanized Peacekeeper",
		ddid = createDDID(11),
		mobs = {
			{
				-- name = "Mechanized Peacekeeper",
				id = "136139",
				displayId = 82943,
			},
		},
	},
	{
		docName = "Venture Co. Earthshaper",
		ddid = createDDID(12),
		mobs = {
			{
				-- name = "Venture Co. Earthshaper",
				id = "130661",
				displayId = 81333,
			},
		},
	},
	{
		docName = "Mine Rat",
		ddid = createDDID(13),
		mobs = {
			{
				-- name = "Mine Rat",
				id = "130437",
				displayId = 114158,
			},
		},
	},
	{
		docName = "Wanton Sapper",
		ddid = createDDID(14),
		mobs = {
			{
				-- name = "Wanton Sapper",
				id = "130653",
				displayId = 81316,
			},
		},
	},
	{
		docName = "Azerite Extractor",
		ddid = createDDID(15),
		mobs = {
			{
				-- name = "Azerite Extractor",
				id = "136643",
				displayId = 84881,
			},
		},
	},
	{
		docName = "Safety Shark",
		ddid = createDDID(16),
		mobs = {
			{
				-- name = "Safety Shark",
				id = "137940",
				displayId = 12207,
			},
		},
	},
	{
		docName = "Shalebiter",
		ddid = createDDID(17),
		mobs = {
			{
				-- name = "Shalebiter",
				id = "134005",
				displayId = 127834,
			},
		},
	},
	{
		docName = "Stonefury",
		ddid = createDDID(18),
		mobs = {
			{
				-- name = "Stonefury",
				id = "130635",
				displayId = 127697,
			},
		},
	},
	{
		docName = "Taskmaster Askari",
		ddid = createDDID(19),
		mobs = {
			{
				-- name = "Taskmaster Askari",
				id = "134012",
				displayId = 83286,
			},
		},
	},
	{
		docName = "Earthrager",
		ddid = createDDID(20),
		mobs = {
			{
				-- name = "Earthrager",
				id = "129802",
				displayId = 124456,
			},
		},
	},
	{
		docName = "Footbomb Hooligan",
		ddid = createDDID(21),
		mobs = {
			{
				-- name = "Footbomb Hooligan",
				id = "138369",
				displayId = 85829,
			},
		},
	},
	{
		docName = "Venture Co. Mastermind",
		ddid = createDDID(22),
		mobs = {
			{
				-- name = "Venture Co. Mastermind",
				id = "133430",
				displayId = 83136,
			},
		},
	},
	{
		docName = "Weapons Tester",
		ddid = createDDID(23),
		mobs = {
			{
				-- name = "Weapons Tester",
				id = "136934",
				displayId = 84962,
			},
		},
	},
	{
		docName = "Venture Co. Alchemist",
		ddid = createDDID(24),
		mobs = {
			{
				-- name = "Venture Co. Alchemist",
				id = "133432",
				displayId = 82915,
			},
		},
	},
	{
		docName = "Test Subject",
		ddid = createDDID(25),
		mobs = {
			{
				-- name = "Test Subject",
				id = "133963",
				displayId = 1141,
			},
		},
	},
	{
		docName = "Venture Co. War Machine",
		ddid = createDDID(26),
		mobs = {
			{
				-- name = "Venture Co. War Machine",
				id = "133463",
				displayId = 83391,
			},
		},
	},
	{
		docName = "Ordnance Specialist",
		ddid = createDDID(27),
		mobs = {
			{
				-- name = "Ordnance Specialist",
				id = "137029",
				displayId = 85024,
			},
		},
	},
	{
		docName = "Crawler Mine",
		ddid = createDDID(28),
		mobs = {
			{
				-- name = "Crawler Mine",
				id = "133482",
				displayId = 127835,
			},
		},
	},
	{
		docName = "Mechanized Peacekeeper",
		ddid = createDDID(29),
		mobs = {
			{
				-- name = "Mechanized Peacekeeper",
				id = "130485",
				displayId = 82943,
			},
		},
	},
	{
		docName = "Venture Co. Skyscorcher",
		ddid = createDDID(30),
		mobs = {
			{
				-- name = "Venture Co. Skyscorcher",
				id = "132056",
				displayId = 82922,
			},
		},
	},
	{
		docName = "B.O.O.M.B.A.",
		ddid = createDDID(31),
		mobs = {
			{
				-- name = "B.O.O.M.B.A.",
				id = "141303",
				displayId = 127819,
			},
		},
	},
	{
		docName = "Azerite Footbomb",
		ddid = createDDID(32),
		mobs = {
			{
				-- name = "Azerite Footbomb",
				id = "129246",
				displayId = 85701,
			},
		},
	},

}

---@type DungeonData
local dungeonData = {
	dungeonName = "The MOTHERLODE!!",
	icon = "Interface\\Icons\\inv_gizmo_goblingtonkcontroller",
	seasonId = "TWWS2",
	docStructures = docStructures,
}

function DD.dungeons.InitTheMotherlode()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
