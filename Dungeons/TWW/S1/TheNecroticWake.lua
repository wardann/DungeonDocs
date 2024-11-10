local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


local dungeonBosses = {
  {
    bossName = "Blightbone",
    encounterId = 2395,
    mobs = {
      {
        name = "Blightbone",
        id = 162691,
        displayId = 95467,
      },
    }
  },
  {
    bossName = "Amarth",
    encounterId = 2391,
    mobs = {
      {
        name = "Amarth",
        id = 163157,
        displayId = 94926,
      },
    }
  },
  {
    bossName = "Surgeon Stitchflesh",
    encounterId = 2392,
    mobs = {
      {
        name = "Surgeon Stitchflesh",
        id = 162689,
        displayId = 96477,
      },
    }
  },
  {
    bossName = "Nalthor the Rimebinder",
    encounterId = 2396,
    mobs = {
      {
        name = "Nalthor the Rimebinder",
        id = 162693,
        displayId = 96085,
      },
    }
  },
}


local dungeonTrash = {
  {
    name = "Patchwerk Soldier",
    id = 162729,
    displayId = 95222,
  },
  {
    name = "Blight Bag",
    id = 165138,
    displayId = 94761,
  },
  {
    name = "Corpse Harvester",
    id = 166302,
    displayId = 98170,
  },
  {
    name = "Stitched Vanguard",
    id = 163121,
    displayId = 95227,
  },
  {
    name = "Zolramus Gatekeeper",
    id = 165137,
    displayId = 95231,
  },
  {
    name = "Flesh Crafter",
    id = 165872,
    displayId = 96480,
  },
  {
    name = "Zolramus Sorcerer",
    id = 163128,
    displayId = 94992,
  },
  {
    name = "Zolramus Bonecarver",
    id = 163619,
    displayId = 93933,
  },
  {
    name = "Zolramus Necromancer",
    id = 163618,
    displayId = 95233,
  },
  {
    name = "Brittlebone Mage",
    id = 163126,
    displayId = 96112,
  },
  {
    name = "Brittlebone Warrior",
    id = 163122,
    displayId = 96107,
  },
  {
    name = "Skeletal Marauder",
    id = 165919,
    displayId = 96115,
  },
  {
    name = "Zolramus Bonemender",
    id = 165222,
    displayId = 97668,
  },
  {
    name = "Nar'zudah",
    id = 165824,
    displayId = 94780,
  },
  {
    name = "Skeletal Monstrosity",
    id = 165197,
    displayId = 94814,
  },
  {
    name = "Brittlebone Crossbowman",
    id = 166079,
    displayId = 96114,
  },
  {
    name = "Shuffling Corpse",
    id = 171500,
    displayId = 96132,
  },
  {
    name = "Corpse Collector",
    id = 173016,
    displayId = 98170,
  },
  {
    name = "Kyrian Stitchwerk",
    id = 172981,
    displayId = 98190,
  },
  {
    name = "Spare Parts",
    id = 166264,
    displayId = 95577,
  },
  {
    name = "Loyal Creation",
    id = 165911,
    displayId = 95226,
  },
  {
    name = "Separation Assistant",
    id = 167731,
    displayId = 98227,
  },
  {
    name = "Stitching Assistant",
    id = 173044,
    displayId = 98226,
  },
  {
    name = "Goregrind",
    id = 163621,
    displayId = 99122,
  },
  {
    name = "Goregrind Bits",
    id = 163622,
    displayId = 97800,
  },
  {
    name = "Rotspew Leftovers",
    id = 163623,
    displayId = 97801,
  },
  {
    name = "Rotspew",
    id = 163620,
    displayId = 99121,
  },
  {
    name = "Stitchflesh's Creation",
    id = 164578,
    displayId = 96218,
  },
}

local dungeonData = {
  name = "The Necrotic Wake",
  icon = "Interface\\Icons\\inv_misc_bone_skull_02",
  bosses = dungeonBosses,
  trash = dungeonTrash,
  seasonId = "TWWS1",
}


function DD:Dungeons_InitTheNecroticWake()
  DD.Dungeons[dungeonData.name] = dungeonData
end
