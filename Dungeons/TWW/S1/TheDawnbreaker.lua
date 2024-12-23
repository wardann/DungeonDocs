--- @type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @type CreateDDID
local function createDDID(index)
  return "tdb" .. index
end

--- @class Dungeons
DD.dungeons = DD.dungeons or {}

--- @type NoteStructure[]
local noteStructures = {
  --
  -- BOSSES
  --
  {
    noteName = "Speaker Shadowcrown",
    ddid = createDDID(1),
    isBoss = true,
    mobs = {
      {
        -- name = "Speaker Shadowcrown",
        id = 211087,
        displayId = 114311,
      },
    }
  },
  {
    noteName = "Anubikkaj",
    ddid = createDDID(2),
    isBoss = true,
    mobs = {
      {
        -- name = "Anubikkaj",
        id = 211089,
        displayId = 114315,
      },
    }
  },
  {
    noteName = "Rashanan",
    ddid = createDDID(3),
    isBoss = true,
    mobs = {
      {
        -- name = "Rashanan",
        id = 213937,
        displayId = 118404,
      },
    }
  },
  ---
  --- TRASH
  ---
  {
    noteName = "Starved Crawler",
    ddid = createDDID(4),
    mobs = {
      {
        id = 216336,
        displayId = 120876,
      }
    },
  },
  {
    noteName = "Nightfall Curseblade",
    ddid = createDDID(5),
    mobs = {
      {
        id = 213894,
        displayId = 115528,
      }
    },
  },
  {
    noteName = "Nightfall Shadowmage",
    ddid = createDDID(6),
    mobs = {
      {
        id = 213892,
        displayId = 115523,
      }
    },
  },
  {
    noteName = "Nightfall Ritualist",
    ddid = createDDID(7),
    mobs = {
      {
        id = 214761,
        displayId = 115526,
      }
    },
  },
  {
    noteName = "Nightfall Commander",
    ddid = createDDID(8),
    mobs = {
      {
        id = 214762,
        displayId = 115535,
      }
    },
  },
  {
    noteName = "Sureki Webmage",
    ddid = createDDID(9),
    mobs = {
      {
        id = 210966,
        displayId = 117315,
      }
    },
  },
  {
    noteName = "Nightfall Darkcaster",
    ddid = createDDID(10),
    mobs = {
      {
        id = 213893,
        displayId = 115520,
      }
    },
  },
  {
    noteName = "Nightfall Shadowalker",
    ddid = createDDID(11),
    mobs = {
      {
        id = 213895,
        displayId = 115530,
      }
    },
  },
  {
    noteName = "Manifested Shadow",
    ddid = createDDID(12),
    mobs = {
      {
        id = 211341,
        displayId = 117518,
      }
    },
  },
  {
    noteName = "Sureki Militant",
    ddid = createDDID(13),
    mobs = {
      {
        id = 213932,
        displayId = 116834,
      }
    },
  },
  {
    noteName = "Nightfall Tactician",
    ddid = createDDID(14),
    mobs = {
      {
        id = 213934,
        displayId = 115534,
      }
    },
  },
  {
    noteName = "Ascendant Viscoxria",
    ddid = createDDID(15),
    mobs = {
      {
        id = 211261,
        displayId = 115760,
      }
    },
  },
  {
    noteName = "Deathscreamer Ikentak",
    ddid = createDDID(16),
    mobs = {
      {
        id = 211263,
        displayId = 115759,
      }
    },
  },
  {
    noteName = "Ixkreten The Unbreakable",
    ddid = createDDID(17),
    mobs = {
      {
        id = 211262,
        displayId = 119262,
      }
    },
  },
  {
    noteName = "Nightfall Dark Architect",
    ddid = createDDID(18),
    mobs = {
      {
        id = 213885,
        displayId = 120116,
      }
    },
  },
}

--- @type DungeonData
local dungeonData = {
  dungeonName = "The Dawnbreaker",
  icon = "Interface\\Icons\\inv_misc_monsterscales_19",
  seasonId = "TWWS1",
  noteStructures = noteStructures,
}


function DD.dungeons.InitTheDawnbreaker()
  DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
