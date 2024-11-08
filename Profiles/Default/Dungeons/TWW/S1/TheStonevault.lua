local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


local dungeonBosses = {
  {
    bossName = "E.D.N.A",
    encounterId = 2572,
    primaryNote = "(1) Using the boss's arrow attack, clear a few of the spikes on the ground\n(2) Do NOT break all spikes at the same time\n(3) Do NOT stack",
    healerNote = "",
    damageNote = "",
    tankNote = "",
    mobs = {
      {
        name = "E.D.N.A",
        id = 210108,
        displayId = 120054,
      },
    }
  },
  {
    bossName = "Skarmorak",
    encounterId = 2579,
    primaryNote = "(1) When the shards spawn, destory only ONE at a time\n(2) When the orbs spawn, only pick up 1-3 at a time",
    healerNote = "",
    damageNote = "",
    tankNote = "",
    mobs = {
      {
        name = "Skarmorak",
        id = 210156,
        displayId = 118714,
      },
      {
        name = "Crystal Shard",
        id = 214443,
        displayId = 37518,
      },
    }
  },
  {
    bossName = "Master Machinists",
    encounterId = 2590,
    primaryNote = "(1) Focus the small boss first & always interrupt\n(2) Focus big boss when small boss runs (keep interrupting small boss)\n(3) Do not stand on exhaust vents\n(4) Avoid DEATH CUBE\n(5) Kill both at the same time!",
    healerNote = "",
    damageNote = "",
    tankNote = "",
    mobs = {
      {
        name = "Speaker Brokk",
        id = 213217,
        displayId = 115818,
      },
      {
        name = "Speaker Dorlita",
        id = 213216,
        displayId = 116916,
      },
      {
        name = "Vent Stalker",
        id = 214049,
        displayId = 100728,
      },
      {
        name = "Scrap Block",
        id = 213694,
        displayId = 91401,
      },
    }
  },
  {
    bossName = "Void Speaker Eirich",
    encounterId = 2582,
    primaryNote = "(1) Drop blue circles at the edge of the room\n(2) Clear your corruption by standing near a portal, but NOT on top of it\n(3) Avoid DEATH CONE",
    healerNote = "",
    damageNote = "",
    tankNote = "",
    mobs = {
      {
        name = "Void Speaker Eirich",
        id = 213119,
        displayId = 119856,
      },
    }
  },
}


local dungeonTrash = {
  {
    name = "Cursedheart Invader",
    id = 212389,
    displayId = 118702,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Earth Infused Golem",
    id = 210109,
    displayId = 117402,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Ghastly Voidsoul",
    id = 212453,
    displayId = 118731,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Repurposed Loaderbot",
    id = 222923,
    displayId = 118231,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Void Bound Despoiler",
    id = 212765,
    displayId = 117973,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Engine Speaker",
    id = 212764,
    displayId = 117641,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Void Bound Howler",
    id = 221979,
    displayId = 118365,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Turned Speaker",
    id = 214350,
    displayId = 118692,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Void Touched Elemental",
    id = 212400,
    displayId = 109870,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Aspiring Forgehand",
    id = 212405,
    displayId = 114686,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Forgebound Mender",
    id = 213338,
    displayId = 115974,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Forge Loader",
    id = 213343,
    displayId = 116911,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Cursedforge Honor Guard",
    id = 214264,
    displayId = 115944,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Cursedforge Stoneshaper",
    id = 214066,
    displayId = 115945,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Rock Smasher",
    id = 213954,
    displayId = 117855,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Cursedforge Mender",
    id = 224962,
    displayId = 120170,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Cursedheart Invader",
    id = 212403,
    displayId = 118702,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
}

local dungeonData = {
  name = "The Stonevault",
  bosses = dungeonBosses,
  trash = dungeonTrash,
}

DD:ProfilesDefault_InitDocs(dungeonData)
