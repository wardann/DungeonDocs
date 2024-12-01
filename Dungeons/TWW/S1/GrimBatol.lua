local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


local function createDDID(index)
  return "gb" .. index
end

local noteStructures = {
  --
  -- BOSSES
  --
  {
    noteName = "General Umbriss",
    ddid = createDDID(1),
    isBoss = true,
    mobs = {
      {
        -- name = "General Umbriss",
        id = 39625,
        displayId = 118920,
      },
    }
  },
  {
    noteName = "Forgemaster Throngus",
    ddid = createDDID(2),
    isBoss = true,
    mobs = {
      {
        -- name = "Forgemaster Throngus",
        id = 40177,
        displayId = 33429,
      },
    }
  },
  {
    noteName = "Drahga Shadowburner",
    ddid = createDDID(3),
    isBoss = true,
    mobs = {
      {
        -- name = "Drahga Shadowburner",
        id = 40319,
        displayId = 31792,
      },
      {
        -- name = "Valiona",
        id = 40320,
        displayId = 31795,
      },
    }
  },
  {
    noteName = "Erudax",
    ddid = createDDID(4),
    isBoss = true,
    mobs = {
      {
        -- name = "Erudax",
        id = 40484,
        displayId = 119801,
      },
    }
  },
  --
  -- TRASH
  --
  {
    noteName = "Twilight Brute",
    ddid = createDDID(5),
    mobs = {
      {
        id = 224152,
        displayId = 119878,
      }
    },
  },
  {
    noteName = "Twilight Earthcaller",
    ddid = createDDID(6),
    mobs = {
      {
        id = 224219,
        displayId = 119892,
      }
    },
  },
  {
    noteName = "Twilight Destroyer",
    ddid = createDDID(7),
    mobs = {
      {
        id = 224609,
        displayId = 119995,
      }
    },
  },
  {
    noteName = "Twilight Overseer",
    ddid = createDDID(8),
    mobs = {
      {
        id = 224221,
        displayId = 119893,
      }
    },
  },
  {
    noteName = "Twilight Beguiler",
    ddid = createDDID(9),
    mobs = {
      {
        id = 40167,
        displayId = 31584,
      }
    },
  },
  {
    noteName = "Molten Giant",
    ddid = createDDID(10),
    mobs = {
      {
        id = 40166,
        displayId = 38667,
      }
    },
  },
  {
    noteName = "Twilight Enforcer",
    ddid = createDDID(11),
    mobs = {
      {
        id = 224276,
        displayId = 119898,
      }
    },
  },
  {
    noteName = "Twilight Warlock",
    ddid = createDDID(12),
    mobs = {
      {
        id = 224271,
        displayId = 119897,
      }
    },
  },
  {
    noteName = "Twilight Flamerender",
    ddid = createDDID(13),
    mobs = {
      {
        id = 224240,
        displayId = 34353,
      }
    },
  },
  {
    noteName = "Twilight Lavabender",
    ddid = createDDID(14),
    mobs = {
      {
        id = 224249,
        displayId = 91122,
      }
    },
  },
  {
    noteName = "Mutated Hatchling",
    ddid = createDDID(15),
    mobs = {
      {
        id = 224853,
        displayId = 119810,
      }
    },
  },
  {
    noteName = "Faceless Corruptor",
    ddid = createDDID(16),
    mobs = {
      {
        id = 39392,
        displayId = 119899,
      }
    },
  },
  {
    noteName = "Invoked Shadowflame Spirit",
    ddid = createDDID(17),
    mobs = {
      {
        id = 40357,
        displayId = 116017,
      }
    },
  },
  {
    noteName = "Battered",
    ddid = createDDID(18),
    mobs = {
      {
        id = 39294,
        displayId = 31463,
      }
    },
  },
}

local dungeonData = {
  name = "Grim Batol",
  icon = "Interface\\Icons\\inv_misc_head_dragon_black",
  seasonId = "TWWS1",
  noteStructures = noteStructures,
}


function DD:Dungeons_InitGrimBatol()
  DD.Dungeons[dungeonData.name] = dungeonData
end
