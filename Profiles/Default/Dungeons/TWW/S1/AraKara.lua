local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


local dungeonBosses = {
  {
    bossName = "Avanoxx",
    encounterId = 2583,
    primaryNote = "Kill adds before he eats them and wipes the group",
    healerNote = "",
    damageNote = "",
    tankNote = "",
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
    primaryNote = "(1) Avoid swirlies throughout the fight\n(2) At 100 energy, boss summons a swarm. Stay inside the eye of the swarm to survive",
    healerNote = "",
    damageNote = "",
    tankNote = "",
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
    primaryNote = "(1) Create 5-7 blue puddles by striking the slime mobs\n(2) Standing in blue puddles roots you in place\n(3) When the boss casts the pull, STAND IN A PUDDLE to get rooted\n(4) After the pull, KILL ALL ROOTS with EITHER damage or CC\n(5) Avoid swirlies",
    healerNote = "",
    damageNote = "",
    tankNote = "",
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
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Jabbing Flyer",
    id = 216341,
    displayId = 120841,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Trilling Attendant",
    id = 216293,
    displayId = 116588,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Engorged Crawler",
    id = 214840,
    displayId = 117840,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Atik",
    id = 217533,
    displayId = 117119,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Nakt",
    id = 218324,
    displayId = 117119,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Ixin",
    id = 217531,
    displayId = 117119,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Bloodworker",
    id = 216337,
    displayId = 120862,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Bloodstained Assistant",
    id = 216333,
    displayId = 119391,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Bloodstained Webmage",
    id = 223253,
    displayId = 117870,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Hulking Bloodguard",
    id = 216338,
    displayId = 120855,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Sentry Stagshell",
    id = 216340,
    displayId = 116485,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Blood Overseer",
    id = 216364,
    displayId = 115772,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Winged Carrier",
    id = 216365,
    displayId = 116349,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Nerubian Hauler",
    id = 217039,
    displayId = 120861,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Reinforced Drone",
    id = 216363,
    displayId = 120860,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  }
}

local dungeonData = {
  name = "Ara-Kara, City of Echoes",
  bosses = dungeonBosses,
  trash = dungeonTrash,
}


DD:ProfilesDefault_InitDocs(dungeonData)
