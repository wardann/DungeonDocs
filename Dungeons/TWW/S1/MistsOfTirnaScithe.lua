local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


local dungeonBosses = {
  {
    bossName = "Ingra Maloch",
    encounterId = 2400,
    mobs = {
      {
        name = "Ingra Maloch",
        id = 164567,
        displayId = 95497,
      },
      {
        name = "Droman Oulfarran",
        id = 164804,
        displayId = 95564,
      },
    }
  },
  {
    bossName = "Mistcaller",
    encounterId = 2402,
    mobs = {
      {
        name = "Mistcaller",
        id = 164501,
        displayId = 96451,
      },
    }
  },
  {
    bossName = "Tred'ova",
    encounterId = 2405,
    mobs = {
      {
        name = "Tred'ova",
        id = 164517,
        displayId = 95809,
      },
    }
  },
}


local dungeonTrash = {
  {
    name = "Starved Crawler",
    id = 216336,
    displayId = 120876,
  },
  {
    name = "Drust Spiteclaw",
    id = 165111,
    displayId = 86207,
  },
  {
    name = "Tirnenn Villager",
    id = 164929,
    displayId = 95618,
  },
  {
    name = "Drust Soulcleaver",
    id = 164920,
    displayId = 95612,
  },
  {
    name = "Drust Harvester",
    id = 164921,
    displayId = 95613,
  },
  {
    name = "Drust Boughbreaker",
    id = 164926,
    displayId = 95615,
  },
  {
    name = "Mistveil Defender",
    id = 163058,
    displayId = 95256,
  },
  {
    name = "Mistveil Stalker",
    id = 166301,
    displayId = 93762,
  },
  {
    name = "Mistveil Stinger",
    id = 166304,
    displayId = 95198,
  },
  {
    name = "Mistveil Guardian",
    id = 166276,
    displayId = 95261,
  },
  {
    name = "Mistveil Tender",
    id = 166299,
    displayId = 95908,
  },
  {
    name = "Mistveil Shaper",
    id = 166275,
    displayId = 95051,
  },
  {
    name = "Mistveil Nightblossom",
    id = 173714,
    displayId = 55772,
  },
  {
    name = "Spinemaw Staghorn",
    id = 167111,
    displayId = 94190,
  },
  {
    name = "Spinemaw Acidgullet",
    id = 167113,
    displayId = 94205,
  },
  {
    name = "Spinemaw Gorger",
    id = 172312,
    displayId = 94197,
  },
  {
    name = "Spinemaw Larva",
    id = 167117,
    displayId = 94208,
  },
  {
    name = "Spinemaw Reaver",
    id = 167116,
    displayId = 95692,
  },
  {
    name = "Mistveil Gorgegullet",
    id = 173720,
    displayId = 98502,
  },
  {
    name = "Mistveil Stinger",
    id = 166304,
    displayId = 95198,
  },
  {
    name = "Mistveil Matriarch",
    id = 173655,
    displayId = 98569,
  },
}

local dungeonData = {
  name = "Mists of Tirna Scithe",
  icon = "Interface\\ICONS\\spell_nature_moonkey",
  bosses = dungeonBosses,
  trash = dungeonTrash,
  seasonId = "TWWS1",
}


function DD:Dungeons_InitMistsOfTirnaScithe()
  DD.Dungeons[dungeonData.name] = dungeonData
end
