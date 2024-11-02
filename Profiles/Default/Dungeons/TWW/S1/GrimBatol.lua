local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


local dungeonBosses = {
  {
    bossName = "General Umbriss",
    encounterId = 2617,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
    mobs = {
      {
        name = "General Umbriss",
        id = 39625,
        displayId = 118920,
      },
    }
  },
  {
    bossName = "Forgemaster Throngus",
    encounterId = 2627,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
    mobs = {
      {
        name = "Forgemaster Throngus",
        id = 40177,
        displayId = 33429,
      },
    }
  },
  {
    bossName = "Drahga Shadowburner",
    encounterId = 2618,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
    mobs = {
      {
        name = "Drahga Shadowburner",
        id = 40319,
        displayId = 31792,
      },
      {
        name = "Valiona",
        id = 40320,
        displayId = 31795,
      },
    }
  },
  {
    bossName = "Erudax",
    encounterId = 2619,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
    mobs = {
      {
        name = "Erudax",
        id = 40484,
        displayId = 119801,
      },
    }
  },
}


local dungeonTrash = {
  {
    name = "Twilight Brute",
    id = 224152,
    displayId = 119878,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Twilight Earthcaller",
    id = 224219,
    displayId = 119892,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Twilight Destroyer",
    id = 224609,
    displayId = 119995,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Twilight Overseer",
    id = 224221,
    displayId = 119893,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Twilight Beguiler",
    id = 40167,
    displayId = 31584,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Molten Giant",
    id = 40166,
    displayId = 38667,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Twilight Enforcer",
    id = 224276,
    displayId = 119898,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Twilight Warlock",
    id = 224271,
    displayId = 119897,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Twilight Flamerender",
    id = 224240,
    displayId = 34353,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Twilight Lavabender",
    id = 224249,
    displayId = 91122,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Mutated Hatchling",
    id = 224853,
    displayId = 119810,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Faceless Corruptor",
    id = 39392,
    displayId = 119899,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Invoked Shadowflame Spirit",
    id = 40357,
    displayId = 116017,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Battered",
    id = 39294,
    displayId = 31463,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
}

local dungeonData = {
  name = "Grim Batol",
  bosses = dungeonBosses,
  trash = dungeonTrash,
}

DD:Profiles_InitProfile("Default*", dungeonData)
