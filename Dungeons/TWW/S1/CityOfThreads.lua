--- @type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @type CreateDDID
local function createDDID(index)
	return "cot" .. index
end

--- @class Dungeons
DD.dungeons = DD.dungeons or {}

--- @type DocStructure[]
local docStructures = {
	--
	-- BOSSES
	--
	{
		docName = "Orator Krixvizk",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Orator Krixvizk",
				id = "216619",
				displayId = 116692,
			},
		},
	},
	{
		docName = "Fangs of the Queen",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Nx",
				id = "216648",
				displayId = 116699,
			},
			{
				-- name = "Vx",
				id = "216649",
				displayId = 116700,
			},
		},
	},
	{
		docName = "The Coaglamation",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "The Coaglamation",
				id = "216320",
				displayId = 11725,
			},
		},
	},
	{
		docName = "Izo, The Grand Splicer",
		ddid = createDDID(4),
		isBoss = true,
		mobs = {
			{
				-- name = "Izo The Grand Splicer",
				id = "216658",
				displayId = 116701,
			},
		},
	},

	--
	-- TRASH
	--
	{
		docName = "Starved Crawler",
		ddid = createDDID(5),
		mobs = {
			{
				id = "216336",
				displayId = 120876,
			},
		},
	},
	{
		docName = "Sureki Silkbinder",
		ddid = createDDID(6),
		mobs = {
			{
				id = "220195",
				displayId = 120872,
			},
		},
	},
	{
		docName = "Sureki Venomblade",
		ddid = createDDID(7),
		mobs = {
			{
				id = "220193",
				displayId = 120868,
			},
		},
	},
	{
		docName = "Royal Swarmguard",
		ddid = createDDID(8),
		mobs = {
			{
				id = "220197",
				displayId = 120882,
			},
		},
	},
	{
		docName = "Herald Of Ansurek",
		ddid = createDDID(9),
		mobs = {
			{
				id = "220196",
				displayId = 120905,
			},
		},
	},
	{
		docName = "Xephitik",
		ddid = createDDID(10),
		mobs = {
			{
				id = "219984",
				displayId = 119732,
			},
		},
	},
	{
		docName = "Eye Of The Queen",
		ddid = createDDID(11),
		mobs = {
			{
				id = "219983",
				displayId = 119371,
			},
		},
	},
	{
		docName = "Web Marauder",
		ddid = createDDID(12),
		mobs = {
			{
				id = "223182",
				displayId = 119369,
			},
		},
	},
	{
		docName = "Agile Pursuer",
		ddid = createDDID(13),
		mobs = {
			{
				id = "223181",
				displayId = 119370,
			},
		},
	},
	{
		docName = "Congealed Droplet",
		ddid = createDDID(14),
		mobs = {
			{
				id = "216329",
				displayId = 114555,
			},
		},
	},
	{
		docName = "Battle Scarab",
		ddid = createDDID(15),
		mobs = {
			{
				id = "220199",
				displayId = 120589,
			},
		},
	},
	{
		docName = "Covert Webmancer",
		ddid = createDDID(16),
		mobs = {
			{
				id = "223844",
				displayId = 118106,
			},
		},
	},
	{
		docName = "Sureki Conscript",
		ddid = createDDID(17),
		mobs = {
			{
				id = "223357",
				displayId = 120886,
			},
		},
	},
	{
		docName = "Royal Venomshell",
		ddid = createDDID(18),
		mobs = {
			{
				id = "220730",
				displayId = 120890,
			},
		},
	},
	{
		docName = "Skittering Assistant",
		ddid = createDDID(19),
		mobs = {
			{
				id = "216342",
				displayId = 120891,
			},
		},
	},
	{
		docName = "Unstable Test Subject",
		ddid = createDDID(20),
		mobs = {
			{
				id = "216328",
				displayId = 116499,
			},
		},
	},
	{
		docName = "Sureki Unnaturaler",
		ddid = createDDID(21),
		mobs = {
			{
				id = "216339",
				displayId = 120894,
			},
		},
	},
	{
		docName = "Elder Shadeweaver",
		ddid = createDDID(22),
		mobs = {
			{
				id = "221102",
				displayId = 118827,
			},
		},
	},
	{
		docName = "Hulking Warshell",
		ddid = createDDID(23),
		mobs = {
			{
				id = "221103",
				displayId = 118826,
			},
		},
	},
	{
		docName = "Ravenous Scarab",
		ddid = createDDID(24),
		mobs = {
			{
				id = "219198",
				displayId = 116480,
			},
		},
	},
	{
		docName = "Web Marauder",
		ddid = createDDID(25),
		mobs = {
			{
				id = "224731",
				displayId = 119369,
			},
		},
	},
	{
		docName = "Covert Webmancer",
		ddid = createDDID(26),
		mobs = {
			{
				id = "224732",
				displayId = 118106,
			},
		},
	},
	{
		docName = "Agile Pursuer",
		ddid = createDDID(27),
		mobs = {
			{
				id = "228361",
				displayId = 119370,
			},
		},
	},
	{
		docName = "Retired Lord Vul'azak",
		ddid = createDDID(28),
		mobs = {
			{
				id = "220423",
				displayId = 120885,
			},
		},
	},
}

--- @type DungeonData
local dungeonData = {
	dungeonName = "City of Threads",
	icon = "Interface\\Icons\\achievement_zone_silithus_01",
	seasonId = "TWWS1",
	docStructures = docStructures,
}

function DD.dungeons.InitCityOfThreads()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
