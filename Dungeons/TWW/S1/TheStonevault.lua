--- @type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @type CreateDDID
local function createDDID(index)
  return "tsv" .. index
end

--- @class Dungeons
DD.dungeons = DD.dungeons or {}

--- @type DocStructure[]
local docStructures = {
  --
  -- BOSSES
  --
  {
    docName = "E.D.N.A",
    ddid = createDDID(1),
    isBoss = true,
    mobs = {
      {
        -- name = "E.D.N.A",
        id = "210108",
        displayId = 120054,
      },
    }
  },
  {
    docName = "Skarmorak",
    ddid = createDDID(2),
    isBoss = true,
    mobs = {
      {
        -- name = "Skarmorak",
        id = "210156",
        displayId = 118714,
      },
      {
        -- name = "Crystal Shard",
        id = "214443",
        displayId = 37518,
        hideModel = true,
      },
    }
  },
  {
    docName = "Master Machinists",
    ddid = createDDID(3),
    isBoss = true,
    mobs = {
      {
        -- name = "Speaker Brokk",
        id = "213217",
        displayId = 115818,
      },
      {
        -- name = "Speaker Dorlita",
        id = "213216",
        displayId = 116916,
      },
      {
        -- name = "Vent Stalker",
        id = "214049",
        displayId = 100728,
        hideModel = true,
      },
      {
        -- name = "Scrap Block",
        id = "213694",
        displayId = 91401,
        hideModel = true,
      },
    }
  },
  {
    docName = "Void Speaker Eirich",
    ddid = createDDID(4),
    isBoss = true,
    mobs = {
      {
        -- name = "Void Speaker Eirich",
        id = "213119",
        displayId = 119856,
      },
    }
  },
  --
  -- TRASH
  --
  {
    docName = "Cursedheart Invader",
    ddid = createDDID(5),
    mobs = {
      {
        id = "212389",
        displayId = 118702,
      },
      {
        id = "212403",
        displayId = 118702,
      }
    },
  },
  {
    docName = "Earth Infused Golem",
    ddid = createDDID(6),
    mobs = {
      {
        id = "210109",
        displayId = 117402,
      }
    },
  },
  {
    docName = "Ghastly Voidsoul",
    ddid = createDDID(7),
    mobs = {
      {
        id = "212453",
        displayId = 118731,
      }
    },
  },
  {
    docName = "Repurposed Loaderbot",
    ddid = createDDID(8),
    mobs = {
      {
        id = "222923",
        displayId = 118231,
      }
    },
  },
  {
    docName = "Void Bound Despoiler",
    ddid = createDDID(9),
    mobs = {
      {
        id = "212765",
        displayId = 117973,
      }
    },
  },
  {
    docName = "Engine Speaker",
    ddid = createDDID(10),
    mobs = {
      {
        id = "212764",
        displayId = 117641,
      }
    },
  },
  {
    docName = "Void Bound Howler",
    ddid = createDDID(11),
    mobs = {
      {
        id = "221979",
        displayId = 118365,
      }
    },
  },
  {
    docName = "Turned Speaker",
    ddid = createDDID(12),
    mobs = {
      {
        id = "214350",
        displayId = 118692,
      }
    },
  },
  {
    docName = "Void Touched Elemental",
    ddid = createDDID(13),
    mobs = {
      {
        id = "212400",
        displayId = 109870,
      }
    },
  },
  {
    docName = "Aspiring Forgehand",
    ddid = createDDID(14),
    mobs = {
      {
        id = "212405",
        displayId = 114686,
      }
    },
  },
  {
    docName = "Forgebound Mender",
    ddid = createDDID(15),
    mobs = {
      {
        id = "213338",
        displayId = 115974,
      }
    },
  },
  {
    docName = "Forge Loader",
    ddid = createDDID(16),
    mobs = {
      {
        id = "213343",
        displayId = 116911,
      }
    },
  },
  {
    docName = "Cursedforge Honor Guard",
    ddid = createDDID(17),
    mobs = {
      {
        id = "214264",
        displayId = 115944,
      }
    },
  },
  {
    docName = "Cursedforge Stoneshaper",
    ddid = createDDID(18),
    mobs = {
      {
        id = "214066",
        displayId = 115945,
      }
    },
  },
  {
    docName = "Rock Smasher",
    ddid = createDDID(19),
    mobs = {
      {
        id = "213954",
        displayId = 117855,
      }
    },
  },
  {
    docName = "Cursedforge Mender",
    ddid = createDDID(20),
    mobs = {
      {
        id = "224962",
        displayId = 120170,
      }
    },
  },
}

--- @type DungeonData
local dungeonData = {
  dungeonName = "The Stonevault",
  icon = "Interface\\ICONS\\inv_misc_stonetablet_05",
  seasonId = "TWWS1",
  docStructures = docStructures,
}


function DD.dungeons.InitTheStonevault()
  DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
