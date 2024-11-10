local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


local dungeonBosses = {
  {
    bossName = "Avanoxx",
    encounterId = 2583,
    mobs = {
      {
        name = "Avanoxx",
        id = 213179,
        displayId = 119793,
      },
    }
  },
  {
    bossName = "Anubzekt",
    encounterId = 2584,
    mobs = {
      {
        name = "Anubzekt",
        id = 215405,
        displayId = 115723,
      }
    }
  },
  {
    bossName = "Kikatal The Harvester",
    encounterId = 2585,
    mobs = {
      {
        name = "Kikatal The Harvester",
        id = 215407,
        displayId = 117473,
      }
    }
  }
}


local dungeonTrash = {
  {
    name = "Starved Crawler",
    id = 216336,
    displayId = 120876,
  },
  {
    name = "Jabbing Flyer",
    id = 216341,
    displayId = 120841,
  },
  {
    name = "Trilling Attendant",
    id = 216293,
    displayId = 116588,
  },
  {
    name = "Engorged Crawler",
    id = 214840,
    displayId = 117840,
  },
  {
    name = "Atik",
    id = 217533,
    displayId = 117119,
  },
  {
    name = "Nakt",
    id = 218324,
    displayId = 117119,
  },
  {
    name = "Ixin",
    id = 217531,
    displayId = 117119,
  },
  {
    name = "Bloodworker",
    id = 216337,
    displayId = 120862,
  },
  {
    name = "Bloodstained Assistant",
    id = 216333,
    displayId = 119391,
  },
  {
    name = "Bloodstained Webmage",
    id = 223253,
    displayId = 117870,
  },
  {
    name = "Hulking Bloodguard",
    id = 216338,
    displayId = 120855,
  },
  {
    name = "Sentry Stagshell",
    id = 216340,
    displayId = 116485,
  },
  {
    name = "Blood Overseer",
    id = 216364,
    displayId = 115772,
  },
  {
    name = "Winged Carrier",
    id = 216365,
    displayId = 116349,
  },
  {
    name = "Nerubian Hauler",
    id = 217039,
    displayId = 120861,
  },
  {
    name = "Reinforced Drone",
    id = 216363,
    displayId = 120860,
  }
}

local dungeonData = {
  name = "Ara-Kara, City of Echoes",
  icon = "Interface\\Icons\\inv_misc_web_01",
  bosses = dungeonBosses,
  trash = dungeonTrash,
  seasonId = "TWWS1",
}


function DD:Dungeons_InitAraKara()
  DD.Dungeons[dungeonData.name] = dungeonData
end
