--- @type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @type CreateDDID
local function createDDID(index)
  return "sob" .. index
end

--- @class Dungeons
DD.dungeons = DD.dungeons or {}

--- @type NoteStructures
local noteStructures = {
  --
  -- BOSSES
  --
  {
    noteName = "Chopper Redhook",
    ddid = createDDID(1),
    isBoss = true,
    mobs = {
      {
        -- name = "Chopper Redhook",
        id = 128650,
        displayId = 84821,
      },
      {
        -- name = "Irontide Cleaver",
        id = 129879,
        displayId = 81286,
      },
    }
  },
  {
    noteName = "Dread Captain Lockwood",
    ddid = createDDID(2),
    isBoss = true,
    mobs = {
      {
        -- name = "Dread Captain Lockwood",
        id = 129208,
        displayId = 88579,
      },
      {
        -- name = "Ashvane Deckhand",
        id = 136483,
        displayId = 84385,
      },
      {
        -- name = "Ashvane Cannoneer",
        id = 136549,
        displayId = 82852,
      },
    }
  },
  {
    noteName = "Hadal Darkfathom",
    ddid = createDDID(3),
    isBoss = true,
    mobs = {
      {
        -- name = "Hadal Darkfathom",
        id = 128651,
        displayId = 67541,
      },
    }
  },
  {
    noteName = "Viqgoth",
    ddid = createDDID(4),
    isBoss = true,
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
  ---
  --- TRASH
  ---
  {
    noteName = "Scrimshaw Gutter",
    ddid = createDDID(5),
    mobs = {
      {
        id = 133990,
        displayId = 83892,
      }
    },
  },
  {
    noteName = "Blacktar Bomber",
    ddid = createDDID(6),
    mobs = {
      {
        id = 129372,
        displayId = 84136,
      }
    },
  },
  {
    noteName = "Scrimshaw Enforcer",
    ddid = createDDID(7),
    mobs = {
      {
        id = 129374,
        displayId = 86006,
      }
    },
  },
  {
    noteName = "Irontide Waveshaper",
    ddid = createDDID(8),
    mobs = {
      {
        id = 129370,
        displayId = 84327,
      }
    },
  },
  {
    noteName = "Irontide Raider",
    ddid = createDDID(9),
    mobs = {
      {
        id = 129369,
        displayId = 84134,
      }
    },
  },
  {
    noteName = "Riptide Shredder",
    ddid = createDDID(10),
    mobs = {
      {
        id = 129371,
        displayId = 86085,
      }
    },
  },
  {
    noteName = "Snarling Dockhound",
    ddid = createDDID(11),
    mobs = {
      {
        id = 129640,
        displayId = 30222,
      }
    },
  },
  {
    noteName = "Irontide Curseblade",
    ddid = createDDID(12),
    mobs = {
      {
        id = 135258,
        displayId = 79068,
      }
    },
  },
  {
    noteName = "Irontide Powdershot",
    ddid = createDDID(13),
    mobs = {
      {
        id = 137521,
        displayId = 85144,
      }
    },
  },
  {
    noteName = "Ashvane Commander",
    ddid = createDDID(14),
    mobs = {
      {
        id = 128969,
        displayId = 84067,
      }
    },
  },
  {
    noteName = "Ashvane Spotter",
    ddid = createDDID(15),
    mobs = {
      {
        id = 138255,
        displayId = 86436,
      },
      {
        id = 135263,
        displayId = 86436,
      }
    },
  },
  {
    noteName = "Ashvane Deckhand",
    ddid = createDDID(16),
    mobs = {
      {
        id = 138464,
        displayId = 84385,
      }
    },
  },
  {
    noteName = "Ashvane Cannoneer",
    ddid = createDDID(17),
    mobs = {
      {
        id = 138465,
        displayId = 88542,
      }
    },
  },
  {
    noteName = "Bilge Rat Pillager",
    ddid = createDDID(18),
    mobs = {
      {
        id = 135241,
        displayId = 52277,
      }
    },
  },
  {
    noteName = "Bilge Rat Buccaneer",
    ddid = createDDID(19),
    mobs = {
      {
        id = 129366,
        displayId = 81424,
      }
    },
  },
  {
    noteName = "Bilge Rat Demolisher",
    ddid = createDDID(20),
    mobs = {
      {
        id = 135245,
        displayId = 68059,
      }
    },
  },
  {
    noteName = "Bilge Rat Tempest",
    ddid = createDDID(21),
    mobs = {
      {
        id = 129367,
        displayId = 80475,
      }
    },
  },
  {
    noteName = "Bilge Rat Cutthroat",
    ddid = createDDID(22),
    mobs = {
      {
        id = 137511,
        displayId = 80319,
      }
    },
  },
  {
    noteName = "Ashvane Invader",
    ddid = createDDID(23),
    mobs = {
      {
        id = 137516,
        displayId = 79889,
      }
    },
  },
  {
    noteName = "Ashvane Destroyer",
    ddid = createDDID(24),
    mobs = {
      {
        id = 137517,
        displayId = 82852,
      }
    },
  },
  {
    noteName = "Irontide Waveshaper",
    ddid = createDDID(25),
    mobs = {
      {
        id = 144071,
        displayId = 84327,
      }
    },
  },
  {
    noteName = "Irontide Powdershot",
    ddid = createDDID(26),
    mobs = {
      {
        id = 138254,
        displayId = 85144,
      }
    },
  },
  {
    noteName = "Ashvane Sniper",
    ddid = createDDID(27),
    mobs = {
      {
        id = 128967,
        displayId = 82843,
      }
    },
  },
  {
    noteName = "Irontide Curseblade",
    ddid = createDDID(28),
    mobs = {
      {
        id = 138247,
        displayId = 79068,
      }
    },
  },
  {
    noteName = "Irontide Powdershot",
    ddid = createDDID(29),
    mobs = {
      {
        id = 129928,
        displayId = 85144,
      }
    },
  },
  {
    noteName = "Scrimshaw Gutter",
    ddid = createDDID(30),
    mobs = {
      {
        id = 138002,
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
  noteStructures = noteStructures
}


function DD.dungeons.InitSiegeOfBoralus()
  DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
