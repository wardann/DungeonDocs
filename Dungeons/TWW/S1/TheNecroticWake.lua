local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local function createDDID(index)
  return "tnw" .. index
end

local noteStructures = {
  --
  -- BOSSES
  --
  {
    noteName = "Blightbone",
    createDDID(1),
    isBoss = true,
    mobs = {
      {
        -- name = "Blightbone",
        id = 162691,
        displayId = 95467,
      },
    }
  },
  {
    noteName = "Amarth",
    createDDID(2),
    isBoss = true,
    mobs = {
      {
        -- name = "Amarth",
        id = 163157,
        displayId = 94926,
      },
    }
  },
  {
    noteName = "Surgeon Stitchflesh",
    createDDID(3),
    isBoss = true,
    mobs = {
      {
        -- name = "Surgeon Stitchflesh",
        id = 162689,
        displayId = 96477,
      },
    }
  },
  {
    noteName = "Nalthor the Rimebinder",
    createDDID(4),
    isBoss = true,
    mobs = {
      {
        -- name = "Nalthor the Rimebinder",
        id = 162693,
        displayId = 96085,
      },
    }
  },
  {
    noteName = "Patchwerk Soldier",
    ddid = createDDID(5),
    mobs = {
      {
      id = 162729,
      displayId = 95222,
      }
    },
  },
  {
    noteName = "Blight Bag",
    ddid = createDDID(6),
    mobs = {
      {
      id = 165138,
      displayId = 94761,
      }
    },
  },
  {
    noteName = "Corpse Harvester",
    ddid = createDDID(7),
    mobs = {
      {
      id = 166302,
      displayId = 98170,
      }
    },
  },
  {
    noteName = "Stitched Vanguard",
    ddid = createDDID(8),
    mobs = {
      {
      id = 163121,
      displayId = 95227,
      }
    },
  },
  {
    noteName = "Zolramus Gatekeeper",
    ddid = createDDID(9),
    mobs = {
      {
      id = 165137,
      displayId = 95231,
      }
    },
  },
  {
    noteName = "Flesh Crafter",
    ddid = createDDID(10),
    mobs = {
      {
      id = 165872,
      displayId = 96480,
      }
    },
  },
  {
    noteName = "Zolramus Sorcerer",
    ddid = createDDID(11),
    mobs = {
      {
      id = 163128,
      displayId = 94992,
      }
    },
  },
  {
    noteName = "Zolramus Bonecarver",
    ddid = createDDID(12),
    mobs = {
      {
      id = 163619,
      displayId = 93933,
      }
    },
  },
  {
    noteName = "Zolramus Necromancer",
    ddid = createDDID(13),
    mobs = {
      {
      id = 163618,
      displayId = 95233,
      }
    },
  },
  {
    noteName = "Brittlebone Mage",
    ddid = createDDID(14),
    mobs = {
      {
      id = 163126,
      displayId = 96112,
      }
    },
  },
  {
    noteName = "Brittlebone Warrior",
    ddid = createDDID(15),
    mobs = {
      {
      id = 163122,
      displayId = 96107,
      }
    },
  },
  {
    noteName = "Skeletal Marauder",
    ddid = createDDID(16),
    mobs = {
      {
      id = 165919,
      displayId = 96115,
      }
    },
  },
  {
    noteName = "Zolramus Bonemender",
    ddid = createDDID(17),
    mobs = {
      {
      id = 165222,
      displayId = 97668,
      }
    },
  },
  {
    noteName = "Nar'zudah",
    ddid = createDDID(18),
    mobs = {
      {
      id = 165824,
      displayId = 94780,
      }
    },
  },
  {
    noteName = "Skeletal Monstrosity",
    ddid = createDDID(19),
    mobs = {
      {
      id = 165197,
      displayId = 94814,
      }
    },
  },
  {
    noteName = "Brittlebone Crossbowman",
    ddid = createDDID(20),
    mobs = {
      {
      id = 166079,
      displayId = 96114,
      }
    },
  },
  {
    noteName = "Shuffling Corpse",
    ddid = createDDID(21),
    mobs = {
      {
      id = 171500,
      displayId = 96132,
      }
    },
  },
  {
    noteName = "Corpse Collector",
    ddid = createDDID(22),
    mobs = {
      {
      id = 173016,
      displayId = 98170,
      }
    },
  },
  {
    noteName = "Kyrian Stitchwerk",
    ddid = createDDID(23),
    mobs = {
      {
      id = 172981,
      displayId = 98190,
      }
    },
  },
  {
    noteName = "Spare Parts",
    ddid = createDDID(24),
    mobs = {
      {
      id = 166264,
      displayId = 95577,
      }
    },
  },
  {
    noteName = "Loyal Creation",
    ddid = createDDID(25),
    mobs = {
      {
      id = 165911,
      displayId = 95226,
      }
    },
  },
  {
    noteName = "Separation Assistant",
    ddid = createDDID(26),
    mobs = {
      {
      id = 167731,
      displayId = 98227,
      }
    },
  },
  {
    noteName = "Stitching Assistant",
    ddid = createDDID(27),
    mobs = {
      {
      id = 173044,
      displayId = 98226,
      }
    },
  },
  {
    noteName = "Goregrind",
    ddid = createDDID(28),
    mobs = {
      {
      id = 163621,
      displayId = 99122,
      }
    },
  },
  {
    noteName = "Goregrind Bits",
    ddid = createDDID(29),
    mobs = {
      {
      id = 163622,
      displayId = 97800,
      }
    },
  },
  {
    noteName = "Rotspew Leftovers",
    ddid = createDDID(30),
    mobs = {
      {
      id = 163623,
      displayId = 97801,
      }
    },
  },
  {
    noteName = "Rotspew",
    ddid = createDDID(31),
    mobs = {
      {
      id = 163620,
      displayId = 99121,
      }
    },
  },
  {
    noteName = "Stitchflesh's Creation",
    ddid = createDDID(32),
    mobs = {
      {
      id = 164578,
      displayId = 96218,
      }
    },
  },
}

local dungeonData = {
  name = "The Necrotic Wake",
  icon = "Interface\\Icons\\inv_misc_bone_skull_02",
  seasonId = "TWWS1",
  noteStructures = noteStructures,
}


function DD:Dungeons_InitTheNecroticWake()
  DD.Dungeons[dungeonData.name] = dungeonData
end
