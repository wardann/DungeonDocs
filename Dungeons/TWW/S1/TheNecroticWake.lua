--- @type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @type CreateDDID
local function createDDID(index)
	return "tnw" .. index
end

--- @class Dungeons
DD.dungeons = DD.dungeons or {}

--- @type DocStructure[]
local docStructures = {
	--
	-- BOSSES
	--
	{
		docName = "Blightbone",
		ddid = createDDID(1),
		isBoss = true,
		mobs = {
			{
				-- name = "Blightbone",
				id = "162691",
				displayId = 95467,
			},
		},
	},
	{
		docName = "Amarth, The Harvester",
		ddid = createDDID(2),
		isBoss = true,
		mobs = {
			{
				-- name = "Amarth",
				id = "163157",
				displayId = 94926,
			},
		},
	},
	{
		docName = "Surgeon Stitchflesh",
		ddid = createDDID(3),
		isBoss = true,
		mobs = {
			{
				-- name = "Surgeon Stitchflesh",
				id = "162689",
				displayId = 96477,
			},
		},
	},
	{
		docName = "Nalthor the Rimebinder",
		ddid = createDDID(4),
		isBoss = true,
		mobs = {
			{
				-- name = "Nalthor the Rimebinder",
				id = "162693",
				displayId = 96085,
			},
		},
	},
	{
		docName = "Patchwerk Soldier",
		ddid = createDDID(5),
		mobs = {
			{
				id = "162729",
				displayId = 95222,
			},
		},
	},
	{
		docName = "Blight Bag",
		ddid = createDDID(6),
		mobs = {
			{
				id = "165138",
				displayId = 94761,
			},
		},
	},
	{
		docName = "Corpse Harvester",
		ddid = createDDID(7),
		mobs = {
			{
				id = "166302",
				displayId = 98170,
			},
		},
	},
	{
		docName = "Stitched Vanguard",
		ddid = createDDID(8),
		mobs = {
			{
				id = "163121",
				displayId = 95227,
			},
		},
	},
	{
		docName = "Zolramus Gatekeeper",
		ddid = createDDID(9),
		mobs = {
			{
				id = "165137",
				displayId = 95231,
			},
		},
	},
	{
		docName = "Flesh Crafter",
		ddid = createDDID(10),
		mobs = {
			{
				id = "165872",
				displayId = 96480,
			},
		},
	},
	{
		docName = "Zolramus Sorcerer",
		ddid = createDDID(11),
		mobs = {
			{
				id = "163128",
				displayId = 94992,
			},
		},
	},
	{
		docName = "Zolramus Bonecarver",
		ddid = createDDID(12),
		mobs = {
			{
				id = "163619",
				displayId = 93933,
			},
		},
	},
	{
		docName = "Zolramus Necromancer",
		ddid = createDDID(13),
		mobs = {
			{
				id = "163618",
				displayId = 95233,
			},
		},
	},
	{
		docName = "Brittlebone Mage",
		ddid = createDDID(14),
		mobs = {
			{
				id = "163126",
				displayId = 96112,
			},
		},
	},
	{
		docName = "Brittlebone Warrior",
		ddid = createDDID(15),
		mobs = {
			{
				id = "163122",
				displayId = 96107,
			},
		},
	},
	{
		docName = "Skeletal Marauder",
		ddid = createDDID(16),
		mobs = {
			{
				id = "165919",
				displayId = 96115,
			},
		},
	},
	{
		docName = "Zolramus Bonemender",
		ddid = createDDID(17),
		mobs = {
			{
				id = "165222",
				displayId = 97668,
			},
		},
	},
	{
		docName = "Nar'zudah",
		ddid = createDDID(18),
		mobs = {
			{
				id = "165824",
				displayId = 94780,
			},
		},
	},
	{
		docName = "Skeletal Monstrosity",
		ddid = createDDID(19),
		mobs = {
			{
				id = "165197",
				displayId = 94814,
			},
		},
	},
	{
		docName = "Brittlebone Crossbowman",
		ddid = createDDID(20),
		mobs = {
			{
				id = "166079",
				displayId = 96114,
			},
		},
	},
	{
		docName = "Shuffling Corpse",
		ddid = createDDID(21),
		mobs = {
			{
				id = "171500",
				displayId = 96132,
			},
		},
	},
	{
		docName = "Corpse Collector",
		ddid = createDDID(22),
		mobs = {
			{
				id = "173016",
				displayId = 98170,
			},
		},
	},
	{
		docName = "Kyrian Stitchwerk",
		ddid = createDDID(23),
		mobs = {
			{
				id = "172981",
				displayId = 98190,
			},
		},
	},
	{
		docName = "Spare Parts",
		ddid = createDDID(24),
		mobs = {
			{
				id = "166264",
				displayId = 95577,
			},
		},
	},
	{
		docName = "Loyal Creation",
		ddid = createDDID(25),
		mobs = {
			{
				id = "165911",
				displayId = 95226,
			},
		},
	},
	{
		docName = "Separation Assistant",
		ddid = createDDID(26),
		mobs = {
			{
				id = "167731",
				displayId = 98227,
			},
		},
	},
	{
		docName = "Stitching Assistant",
		ddid = createDDID(27),
		mobs = {
			{
				id = "173044",
				displayId = 98226,
			},
		},
	},
	{
		docName = "Goregrind",
		ddid = createDDID(28),
		mobs = {
			{
				id = "163621",
				displayId = 99122,
			},
		},
	},
	{
		docName = "Goregrind Bits",
		ddid = createDDID(29),
		mobs = {
			{
				id = "163622",
				displayId = 97800,
			},
		},
	},
	{
		docName = "Rotspew Leftovers",
		ddid = createDDID(30),
		mobs = {
			{
				id = "163623",
				displayId = 97801,
			},
		},
	},
	{
		docName = "Rotspew",
		ddid = createDDID(31),
		mobs = {
			{
				id = "163620",
				displayId = 99121,
			},
		},
	},
	{
		docName = "Stitchflesh's Creation",
		ddid = createDDID(32),
		mobs = {
			{
				id = "164578",
				displayId = 96218,
			},
		},
	},
}

--- @type DungeonData
local dungeonData = {
	dungeonName = "The Necrotic Wake",
	icon = "Interface\\Icons\\inv_misc_bone_skull_02",
	seasonId = "TWWS1",
	docStructures = docStructures,
}

function DD.dungeons.InitTheNecroticWake()
	DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
