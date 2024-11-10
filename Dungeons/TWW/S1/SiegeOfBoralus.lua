local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


local dungeonBosses = {
  {
    bossName = "Chopper Redhook",
    encounterId = 2654,
    mobs = {
      {
        name = "Chopper Redhook",
        id = 128650,
        displayId = 84821,
      },
      {
        name = "Irontide Cleaver",
        id = 129879,
        displayId = 81286,
      },
    }
  },
  {
    bossName = "Dread Captain Lockwood",
    encounterId = 2173,
    mobs = {
      {
        name = "Dread Captain Lockwood",
        id = 129208,
        displayId = 88579,
      },
      {
        name = "Ashvane Deckhand",
        id = 136483,
        displayId = 84385,
      },
      {
        name = "Ashvane Cannoneer",
        id = 136549,
        displayId = 82852,
      },
    }
  },
  {
    bossName = "Hadal Darkfathom",
    encounterId = 2134,
    mobs = {
      {
        name = "Hadal Darkfathom",
        id = 128651,
        displayId = 67541,
      },
    }
  },
  {
    bossName = "Viqgoth",
    encounterId = 2140,
    mobs = {
      {
        name = "Viqgoth",
        id = 128652,
        displayId = 87990,
      },
      {
        name = "Gripping Terror",
        id = 137405,
        displayId = 88448,
      },
      {
        name = "Demolishing Terror",
        id = 137614,
        displayId = 86691,
      },
    }
  },
}


local dungeonTrash = {
  {
    name = "Scrimshaw Gutter",
    id = 133990,
    displayId = 83892,
  },
  {
    name = "Blacktar Bomber",
    id = 129372,
    displayId = 84136,
  },
  {
    name = "Scrimshaw Enforcer",
    id = 129374,
    displayId = 86006,
  },
  {
    name = "Irontide Waveshaper",
    id = 129370,
    displayId = 84327,
  },
  {
    name = "Irontide Raider",
    id = 129369,
    displayId = 84134,
  },
  {
    name = "Riptide Shredder",
    id = 129371,
    displayId = 86085,
  },
  {
    name = "Snarling Dockhound",
    id = 129640,
    displayId = 30222,
  },
  {
    name = "Irontide Curseblade",
    id = 135258,
    displayId = 79068,
  },
  {
    name = "Irontide Powdershot",
    id = 137521,
    displayId = 85144,
  },
  {
    name = "Ashvane Commander",
    id = 128969,
    displayId = 84067,
  },
  {
    name = "Ashvane Spotter",
    id = 138255,
    displayId = 86436,
  },
  {
    name = "Ashvane Spotter",
    id = 135263,
    displayId = 86436,
  },
  {
    name = "Ashvane Deckhand",
    id = 138464,
    displayId = 84385,
  },
  {
    name = "Ashvane Cannoneer",
    id = 138465,
    displayId = 88542,
  },
  {
    name = "Bilge Rat Pillager",
    id = 135241,
    displayId = 52277,
  },
  {
    name = "Bilge Rat Buccaneer",
    id = 129366,
    displayId = 81424,
  },
  {
    name = "Bilge Rat Demolisher",
    id = 135245,
    displayId = 68059,
  },
  {
    name = "Bilge Rat Tempest",
    id = 129367,
    displayId = 80475,
  },
  {
    name = "Bilge Rat Cutthroat",
    id = 137511,
    displayId = 80319,
  },
  {
    name = "Ashvane Invader",
    id = 137516,
    displayId = 79889,
  },
  {
    name = "Ashvane Destroyer",
    id = 137517,
    displayId = 82852,
  },
  {
    name = "Irontide Waveshaper",
    id = 144071,
    displayId = 84327,
  },
  {
    name = "Irontide Powdershot",
    id = 138254,
    displayId = 85144,
  },
  {
    name = "Ashvane Sniper",
    id = 128967,
    displayId = 82843,
  },
  {
    name = "Irontide Curseblade",
    id = 138247,
    displayId = 79068,
  },
  {
    name = "Irontide Powdershot",
    id = 129928,
    displayId = 85144,
  },
  {
    name = "Scrimshaw Gutter",
    id = 138002,
    displayId = 83892,
  },
}

local dungeonData = {
  name = "Siege of Boralus",
  icon = "Interface\\ICONS\\inv_misc_monsterhorn_03",
  bosses = dungeonBosses,
  trash = dungeonTrash,
  seasonId = "TWWS1",
}


function DD:Dungeons_InitSiegeOfBoralus()
  DD.Dungeons[dungeonData.name] = dungeonData
end
