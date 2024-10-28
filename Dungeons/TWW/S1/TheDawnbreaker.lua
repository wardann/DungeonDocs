local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


local dungeonBosses = {
  {
    bossName = "Speaker Shadowcrown",
    encounterId = 2580,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
    mobs = {
      {
        name = "Speaker Shadowcrown",
        id = 211087,
        displayId = 114311,
      },
    }
  },
  {
    bossName = "Anubikkaj",
    encounterId = 2581,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
    mobs = {
      {
        name = "Anubikkaj",
        id = 211089,
        displayId = 114315,
      },
    }
  },
  {
    bossName = "Rashanan",
    encounterId = 2591,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
    mobs = {
      {
        name = "Rashanan",
        id = 213937,
        displayId = 118404,
      },
    }
  },
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
    name = "Nightfall Curseblade",
    id = 213894,
    displayId = 115528,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Nightfall Shadowmage",
    id = 213892,
    displayId = 115523,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Nightfall Ritualist",
    id = 214761,
    displayId = 115526,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Nightfall Commander",
    id = 214762,
    displayId = 115535,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Sureki Webmage",
    id = 210966,
    displayId = 117315,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Nightfall Darkcaster",
    id = 213893,
    displayId = 115520,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Nightfall Shadowalker",
    id = 213895,
    displayId = 115530,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Manifested Shadow",
    id = 211341,
    displayId = 117518,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Sureki Militant",
    id = 213932,
    displayId = 116834,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Nightfall Tactician",
    id = 213934,
    displayId = 115534,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Ascendant Viscoxria",
    id = 211261,
    displayId = 115760,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Deathscreamer Ikentak",
    id = 211263,
    displayId = 115759,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Ixkreten The Unbreakable",
    id = 211262,
    displayId = 119262,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    name = "Nightfall Dark Architect",
    id = 213885,
    displayId = 120116,
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
}

local dungeonData = {
  name = "The Dawnbreaker",
  nameFull = "The Dawnbreaker",
  icon = "Interface\\Icons\\inv_misc_monsterscales_19",
  bosses = dungeonBosses,
  trash = dungeonTrash,
  seasonId = "TWWS1",
}


function DungeonDocs:InitTheDawnbreaker()
  DungeonDocs:DB_InitDungeon(dungeonData)
end


