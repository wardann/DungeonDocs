--- @type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @type CreateDDID
local function createDDID(index)
  return "sob" .. index
end

--- @class Dungeons
DD.dungeons = DD.dungeons or {}

--- @type DocStructure[]
local docStructures = {
  --
  -- BOSSES
  --
  {
    docName = "Chopper Redhook",
    ddid = createDDID(1),
    isBoss = true,
    mobs = {
      {
        -- name = "Chopper Redhook",
        id = "128650",
        displayId = 84821,
      },
      {
        -- name = "Irontide Cleaver",
        id = "129879",
        displayId = 81286,
      },
    }
  },
  {
    docName = "Dread Captain Lockwood",
    ddid = createDDID(2),
    isBoss = true,
    mobs = {
      {
        -- name = "Dread Captain Lockwood",
        id = "129208",
        displayId = 88579,
      },
      {
        -- name = "Ashvane Deckhand",
        id = "136483",
        displayId = 84385,
      },
      {
        -- name = "Ashvane Cannoneer",
        id = "136549",
        displayId = 82852,
      },
    }
  },
  {
    docName = "Hadal Darkfathom",
    ddid = createDDID(3),
    isBoss = true,
    mobs = {
      {
        -- name = "Hadal Darkfathom",
        id = "128651",
        displayId = 67541,
      },
    }
  },
  {
    docName = "Viqgoth",
    ddid = createDDID(4),
    isBoss = true,
    mobs = {
      {
        name = "Viqgoth",
        id = "128652",
        displayId = 87990,
      },
      {
        name = "Gripping Terror",
        id = "137405",
        displayId = 88448,
      },
      {
        name = "Demolishing Terror",
        id = "137614",
        displayId = 86691,
      },
    }
  },
  ---
  --- TRASH
  ---
  {
    docName = "Scrimshaw Gutter",
    ddid = createDDID(5),
    mobs = {
      {
        id = "133990",
        displayId = 83892,
      }
    },
  },
  {
    docName = "Blacktar Bomber",
    ddid = createDDID(6),
    mobs = {
      {
        id = "129372",
        displayId = 84136,
      }
    },
  },
  {
    docName = "Scrimshaw Enforcer",
    ddid = createDDID(7),
    mobs = {
      {
        id = "129374",
        displayId = 86006,
      }
    },
  },
  {
    docName = "Irontide Waveshaper",
    ddid = createDDID(8),
    mobs = {
      {
        id = "129370",
        displayId = 84327,
      }
    },
  },
  {
    docName = "Irontide Raider",
    ddid = createDDID(9),
    mobs = {
      {
        id = "129369",
        displayId = 84134,
      }
    },
  },
  {
    docName = "Riptide Shredder",
    ddid = createDDID(10),
    mobs = {
      {
        id = "129371",
        displayId = 86085,
      }
    },
  },
  {
    docName = "Snarling Dockhound",
    ddid = createDDID(11),
    mobs = {
      {
        id = "129640",
        displayId = 30222,
      }
    },
  },
  {
    docName = "Irontide Curseblade",
    ddid = createDDID(12),
    mobs = {
      {
        id = "135258",
        displayId = 79068,
      }
    },
  },
  {
    docName = "Irontide Powdershot",
    ddid = createDDID(13),
    mobs = {
      {
        id = "137521",
        displayId = 85144,
      }
    },
  },
  {
    docName = "Ashvane Commander",
    ddid = createDDID(14),
    mobs = {
      {
        id = "128969",
        displayId = 84067,
      }
    },
  },
  {
    docName = "Ashvane Spotter",
    ddid = createDDID(15),
    mobs = {
      {
        id = "138255",
        displayId = 86436,
      },
      {
        id = "135263",
        displayId = 86436,
      }
    },
  },
  {
    docName = "Ashvane Deckhand",
    ddid = createDDID(16),
    mobs = {
      {
        id = "138464",
        displayId = 84385,
      }
    },
  },
  {
    docName = "Ashvane Cannoneer",
    ddid = createDDID(17),
    mobs = {
      {
        id = "138465",
        displayId = 88542,
      }
    },
  },
  {
    docName = "Bilge Rat Pillager",
    ddid = createDDID(18),
    mobs = {
      {
        id = "135241",
        displayId = 52277,
      }
    },
  },
  {
    docName = "Bilge Rat Buccaneer",
    ddid = createDDID(19),
    mobs = {
      {
        id = "129366",
        displayId = 81424,
      }
    },
  },
  {
    docName = "Bilge Rat Demolisher",
    ddid = createDDID(20),
    mobs = {
      {
        id = "135245",
        displayId = 68059,
      }
    },
  },
  {
    docName = "Bilge Rat Tempest",
    ddid = createDDID(21),
    mobs = {
      {
        id = "129367",
        displayId = 80475,
      }
    },
  },
  {
    docName = "Bilge Rat Cutthroat",
    ddid = createDDID(22),
    mobs = {
      {
        id = "137511",
        displayId = 80319,
      }
    },
  },
  {
    docName = "Ashvane Invader",
    ddid = createDDID(23),
    mobs = {
      {
        id = "137516",
        displayId = 79889,
      }
    },
  },
  {
    docName = "Ashvane Destroyer",
    ddid = createDDID(24),
    mobs = {
      {
        id = "137517",
        displayId = 82852,
      }
    },
  },
  {
    docName = "Irontide Waveshaper",
    ddid = createDDID(25),
    mobs = {
      {
        id = "144071",
        displayId = 84327,
      }
    },
  },
  {
    docName = "Irontide Powdershot",
    ddid = createDDID(26),
    mobs = {
      {
        id = "138254",
        displayId = 85144,
      }
    },
  },
  {
    docName = "Ashvane Sniper",
    ddid = createDDID(27),
    mobs = {
      {
        id = "128967",
        displayId = 82843,
      }
    },
  },
  {
    docName = "Irontide Curseblade",
    ddid = createDDID(28),
    mobs = {
      {
        id = "138247",
        displayId = 79068,
      }
    },
  },
  {
    docName = "Irontide Powdershot",
    ddid = createDDID(29),
    mobs = {
      {
        id = "129928",
        displayId = 85144,
      }
    },
  },
  {
    docName = "Scrimshaw Gutter",
    ddid = createDDID(30),
    mobs = {
      {
        id = "138002",
        displayId = 83892,
      }
    },
  },
}

--- @type DungeonData
local dungeonData = {
  dungeonName = "Siege of Boralus",
  icon = "Interface\\ICONS\\inv_misc_monsterhorn_03",
  seasonId = "TWWS1",
  docStructures = docStructures
}


function DD.dungeons.InitSiegeOfBoralus()
  DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
