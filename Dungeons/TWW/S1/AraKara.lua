--- @type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @type CreateDDID
local function createDDID(index)
  return "ak" .. index
end


--- @class Dungeons
DD.dungeons = DD.dungeons or {}

--- @type DocStructure[]
local docStructures = {
  --
  -- BOSSES
  --
  {
    docName = "Avanoxx",
    ddid = createDDID(1),
    isBoss = true,
    mobs = {
      {
        -- name = "Avanoxx",
        id = "213179",
        displayId = 119793,
      },
    }
  },
  {
    docName = "Anubzekt",
    ddid = createDDID(2),
    isBoss = true,
    mobs = {
      {
        -- name = "Anubzekt",
        id = "21540",
        displayId = 115723,
      }
    }
  },
  {
    docName = "Kikatal The Harvester",
    ddid = createDDID(3),
    isBoss = true,
    mobs = {
      {
        -- name = "Kikatal The Harvester",
        id = "215407",
        displayId = 117473,
      }
    }
  },

  -- TRASH
  {
    docName = "Starved Crawler",
    ddid = createDDID(4),
    mobs = {
      {
        id = "216336",
        displayId = 120876,
      }
    }
  },
  {
    docName = "Jabbing Flyer",
    ddid = createDDID(5),
    mobs = {
      {
        id = "216341",
        displayId = 120841,
      }
    }
  },
  {
    docName = "Trilling Attendant",
    ddid = createDDID(6),
    mobs = {
      {
        id = "216293",
        displayId = 116588,
      }
    }
  },
  {
    docName = "Engorged Crawler",
    ddid = createDDID(7),
    mobs = {
      {
        id = "214840",
        displayId = 117840,
      }
    }
  },
  {
    docName = "Atik",
    ddid = createDDID(8),
    mobs = {
      {
        id = "217533",
        displayId = 117119,
      }
    }
  },
  {
    docName = "Nakt",
    ddid = createDDID(9),
    mobs = {
      {
        id = "218324",
        displayId = 117119,
      }
    }
  },
  {
    docName = "Ixin",
    ddid = createDDID(10),
    mobs = {
      {
        id = "217531",
        displayId = 117119,
      }
    }
  },
  {
    docName = "Bloodworker",
    ddid = createDDID(11),
    mobs = {
      {
        id = "216337",
        displayId = 120862,
      }
    }
  },
  {
    docName = "Bloodstained Assistant",
    ddid = createDDID(12),
    mobs = {
      {
        id = "216333",
        displayId = 119391,
      }
    }
  },
  {
    docName = "Bloodstained Webmage",
    ddid = createDDID(13),
    mobs = {
      {
        id = "223253",
        displayId = 117870,
      }
    }
  },
  {
    docName = "Hulking Bloodguard",
    ddid = createDDID(14),
    mobs = {
      {
        id = "216338",
        displayId = 120855,
      }
    }
  },
  {
    docName = "Sentry Stagshell",
    ddid = createDDID(15),
    mobs = {
      {
        id = "216340",
        displayId = 116485,
      }
    }
  },
  {
    docName = "Blood Overseer",
    ddid = createDDID(16),
    mobs = {
      {
        id = "216364",
        displayId = 115772,
      }
    }
  },
  {
    docName = "Winged Carrier",
    ddid = createDDID(17),
    mobs = {
      {
        id = "216365",
        displayId = 116349,
      }
    }
  },
  {
    docName = "Nerubian Hauler",
    ddid = createDDID(18),
    mobs = {
      {
        id = "217039",
        displayId = 120861,
      }
    }
  },
  {
    docName = "Reinforced Drone",
    ddid = createDDID(19),
    mobs = {
      {
        id = "216363",
        displayId = 120860,
      }
    }
  }
}

--- @type DungeonData
local dungeonData = {
  dungeonName = "Ara-Kara, City of Echoes",
  icon = "Interface\\Icons\\inv_misc_web_01",
  seasonId = "TWWS1",
  docStructures = docStructures,
}


function DD.dungeons.InitAraKara()
  DD.dungeons.List[dungeonData.dungeonName] = dungeonData
end
