local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


local dungeonBosses = {
  {
    bossName = "E.D.N.A",
    encounterId = 2572,
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
  },
  {
    name = "Earth Infused Golem",
    id = 210109,
    displayId = 117402,
  },
  {
    name = "Ghastly Voidsoul",
    id = 212453,
    displayId = 118731,
  },
  {
    name = "Repurposed Loaderbot",
    id = 222923,
    displayId = 118231,
  },
  {
    name = "Void Bound Despoiler",
    id = 212765,
    displayId = 117973,
  },
  {
    name = "Engine Speaker",
    id = 212764,
    displayId = 117641,
  },
  {
    name = "Void Bound Howler",
    id = 221979,
    displayId = 118365,
  },
  {
    name = "Turned Speaker",
    id = 214350,
    displayId = 118692,
  },
  {
    name = "Void Touched Elemental",
    id = 212400,
    displayId = 109870,
  },
  {
    name = "Aspiring Forgehand",
    id = 212405,
    displayId = 114686,
  },
  {
    name = "Forgebound Mender",
    id = 213338,
    displayId = 115974,
  },
  {
    name = "Forge Loader",
    id = 213343,
    displayId = 116911,
  },
  {
    name = "Cursedforge Honor Guard",
    id = 214264,
    displayId = 115944,
  },
  {
    name = "Cursedforge Stoneshaper",
    id = 214066,
    displayId = 115945,
  },
  {
    name = "Rock Smasher",
    id = 213954,
    displayId = 117855,
  },
  {
    name = "Cursedforge Mender",
    id = 224962,
    displayId = 120170,
  },
  {
    name = "Cursedheart Invader",
    id = 212403,
    displayId = 118702,
  },
}

local dungeonData = {
  name = "The Stonevault",
  icon = "Interface\\ICONS\\inv_misc_stonetablet_05",
  bosses = dungeonBosses,
  trash = dungeonTrash,
  seasonId = "TWWS1",
}


function DD:Dungeons_InitTheStonevault()
  DD.Dungeons[dungeonData.name] = dungeonData
end
