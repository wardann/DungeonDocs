--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


--- @type CreateDDID
local function createDDID(index)
  return "gb" .. index
end

--- @class Dungeons
DD.dungeons = DD.dungeons or {}

--- @type DocStructure[]
local docStructures = {
  --
  -- BOSSES
  --
  {
    docName = "General Umbriss",
    ddid = createDDID(1),
    isBoss = true,
    mobs = {
      {
        -- name = "General Umbriss",
        id = "39625",
        displayId = 118920,
      },
    }
  },
  {
    docName = "Forgemaster Throngus",
    ddid = createDDID(2),
    isBoss = true,
    mobs = {
      {
        -- name = "Forgemaster Throngus""",
        id = "40177",
        displayId = 33429,
      },
    }
  },
  {
    docName = "Drahga Shadowburner",
    ddid = createDDID(3),
    isBoss = true,
    mobs = {
      {
        -- name = "Drahga Shadowburner",
        id = "40319",
        displayId = 31792,
      },
      {
        -- name = "Valiona",
        id = "40320",
        displayId = 31795,
      },
    }
  },
  {
    docName = "Erudax",
    ddid = createDDID(4),
    isBoss = true,
    mobs = {
      {
        -- name = "Erudax",
        id = "40484",
        displayId = 119801,
      },
    }
  },
  --
  -- TRASH
  --
  {
    docName = "Twilight Brute",
    ddid = createDDID(5),
    mobs = {
      {
        id = "224152",
        displayId = 119878,
      }
    },
  },
  {
    docName = "Twilight Earthcaller",
    ddid = createDDID(6),
    mobs = {
      {
        id = "224219",
        displayId = 119892,
      }
    },
  },
  {
    docName = "Twilight Destroyer",
    ddid = createDDID(7),
    mobs = {
      {
        id = "224609",
        displayId = 119995,
      }
    },
  },
  {
    docName = "Twilight Overseer",
    ddid = createDDID(8),
    mobs = {
      {
        id = "224221",
        displayId = 119893,
      }
    },
  },
  {
    docName = "Twilight Beguiler",
    ddid = createDDID(9),
    mobs = {
      {
        id = "40167",
        displayId = 31584,
      }
    },
  },
  {
    docName = "Molten Giant",
    ddid = createDDID(10),
    mobs = {
      {
        id = "40166",
        displayId = 38667,
      }
    },
  },
  {
    docName = "Twilight Enforcer",
    ddid = createDDID(11),
    mobs = {
      {
        id = "224276",
        displayId = 119898,
      }
    },
  },
  {
    docName = "Twilight Warlock",
    ddid = createDDID(12),
    mobs = {
      {
        id = "224271",
        displayId = 119897,
      }
    },
  },
  {
    docName = "Twilight Flamerender",
    ddid = createDDID(13),
    mobs = {
      {
        id = "224240",
        displayId = 34353,
      }
    },
  },
  {
    docName = "Twilight Lavabender",
    ddid = createDDID(14),
    mobs = {
      {
        id = "224249",
        displayId = 91122,
      }
    },
  },
  {
    docName = "Mutated Hatchling",
    ddid = createDDID(15),
    mobs = {
      {
        id = "224853",
        displayId = 119810,
      }
    },
  },
  {
    docName = "Faceless Corruptor",
    ddid = createDDID(16),
    mobs = {
      {
        id = "39392",
        displayId = 119899,
      }
    },
  },
  {
    docName = "Invoked Shadowflame Spirit",
    ddid = createDDID(17),
    mobs = {
      {
        id = "40357",
        displayId = 116017,
      }
    },
  },
  {
    docName = "Battered",
    ddid = createDDID(18),
    mobs = {
      {
        id = "39294",
        displayId = 31463,
      }
    },
  },
}

--- @type DungeonData
local dungeonData = {
  dungeonName = "Grim Batol",
  icon = "Interface\\Icons\\inv_misc_head_dragon_black",
  seasonId = "TWWS1",
  docStructures = docStructures,
}


function DD.dungeons.InitGrimBatol()
  DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
