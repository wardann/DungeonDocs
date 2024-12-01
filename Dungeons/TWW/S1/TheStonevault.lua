local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local function createDDID(index)
  return "tsv" .. index
end

local noteStructures = {
  --
  -- BOSSES
  --
  {
    noteName = "E.D.N.A",
    ddid = createDDID(1),
    isBoss = true,
    mobs = {
      {
        -- name = "E.D.N.A",
        id = 210108,
        displayId = 120054,
      },
    }
  },
  {
    noteName = "Skarmorak",
    ddid = createDDID(2),
    isBoss = true,
    mobs = {
      {
        -- name = "Skarmorak",
        id = 210156,
        displayId = 118714,
      },
      {
        -- name = "Crystal Shard",
        id = 214443,
        displayId = 37518,
        hideModel = true,
      },
    }
  },
  {
    noteName = "Master Machinists",
    ddid = createDDID(3),
    isBoss = true,
    mobs = {
      {
        -- name = "Speaker Brokk",
        id = 213217,
        displayId = 115818,
      },
      {
        -- name = "Speaker Dorlita",
        id = 213216,
        displayId = 116916,
      },
      {
        -- name = "Vent Stalker",
        id = 214049,
        displayId = 100728,
        hideModel = true,
      },
      {
        -- name = "Scrap Block",
        id = 213694,
        displayId = 91401,
        hideModel = true,
      },
    }
  },
  {
    noteName = "Void Speaker Eirich",
    ddid = createDDID(4),
    isBoss = true,
    mobs = {
      {
        -- name = "Void Speaker Eirich",
        id = 213119,
        displayId = 119856,
      },
    }
  },
  --
  -- TRASH
  --
  {
    noteName = "Cursedheart Invader",
    ddid = createDDID(5),
    mobs = {
      {
        id = 212389,
        displayId = 118702,
      },
      {
        id = 212403,
        displayId = 118702,
      }
    },
  },
  {
    noteName = "Earth Infused Golem",
    ddid = createDDID(6),
    mobs = {
      {
        id = 210109,
        displayId = 117402,
      }
    },
  },
  {
    noteName = "Ghastly Voidsoul",
    ddid = createDDID(7),
    mobs = {
      {
        id = 212453,
        displayId = 118731,
      }
    },
  },
  {
    noteName = "Repurposed Loaderbot",
    ddid = createDDID(8),
    mobs = {
      {
        id = 222923,
        displayId = 118231,
      }
    },
  },
  {
    noteName = "Void Bound Despoiler",
    ddid = createDDID(9),
    mobs = {
      {
        id = 212765,
        displayId = 117973,
      }
    },
  },
  {
    noteName = "Engine Speaker",
    ddid = createDDID(10),
    mobs = {
      {
        id = 212764,
        displayId = 117641,
      }
    },
  },
  {
    noteName = "Void Bound Howler",
    ddid = createDDID(11),
    mobs = {
      {
        id = 221979,
        displayId = 118365,
      }
    },
  },
  {
    noteName = "Turned Speaker",
    ddid = createDDID(12),
    mobs = {
      {
        id = 214350,
        displayId = 118692,
      }
    },
  },
  {
    noteName = "Void Touched Elemental",
    ddid = createDDID(13),
    mobs = {
      {
        id = 212400,
        displayId = 109870,
      }
    },
  },
  {
    noteName = "Aspiring Forgehand",
    ddid = createDDID(14),
    mobs = {
      {
        id = 212405,
        displayId = 114686,
      }
    },
  },
  {
    noteName = "Forgebound Mender",
    ddid = createDDID(15),
    mobs = {
      {
        id = 213338,
        displayId = 115974,
      }
    },
  },
  {
    noteName = "Forge Loader",
    ddid = createDDID(16),
    mobs = {
      {
        id = 213343,
        displayId = 116911,
      }
    },
  },
  {
    noteName = "Cursedforge Honor Guard",
    ddid = createDDID(17),
    mobs = {
      {
        id = 214264,
        displayId = 115944,
      }
    },
  },
  {
    noteName = "Cursedforge Stoneshaper",
    ddid = createDDID(18),
    mobs = {
      {
        id = 214066,
        displayId = 115945,
      }
    },
  },
  {
    noteName = "Rock Smasher",
    ddid = createDDID(19),
    mobs = {
      {
        id = 213954,
        displayId = 117855,
      }
    },
  },
  {
    noteName = "Cursedforge Mender",
    ddid = createDDID(20),
    mobs = {
      {
        id = 224962,
        displayId = 120170,
      }
    },
  },
}

local dungeonData = {
  name = "The Stonevault",
  icon = "Interface\\ICONS\\inv_misc_stonetablet_05",
  seasonId = "TWWS1",
  noteStructures = noteStructures,
}


function DD:Dungeons_InitTheStonevault()
  DD.Dungeons[dungeonData.name] = dungeonData
end
