local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local function createDDID(index)
  return "mistsoftirnascithe" .. index
end

local noteStructures = {
  --
  -- BOSSES
  --
  {
    noteName = "Ingra Maloch",
    ddid = createDDID(1),
    isBoss = true,
    mobs = {
      {
        -- name = "Ingra Maloch",
        id = 164567,
        displayId = 95497,
      },
      {
        -- name = "Droman Oulfarran",
        id = 164804,
        displayId = 95564,
      },
    }
  },
  {
    noteName = "Mistcaller",
    ddid = createDDID(2),
    isBoss = true,
    mobs = {
      {
        -- name = "Mistcaller",
        id = 164501,
        displayId = 96451,
      },
    }
  },
  {
    noteName = "Tred'ova",
    ddid = createDDID(3),
    isBoss = true,
    mobs = {
      {
        -- name = "Tred'ova",
        id = 164517,
        displayId = 95809,
      },
    }
  },
  ---
  --- TRASH
  ---
  {
    noteName = "Starved Crawler",
    ddid = createDDID(4),
    mobs = {
      {
        id = 216336,
        displayId = 120876,
      }
    },
  },
  {
    noteName = "Drust Spiteclaw",
    ddid = createDDID(5),
    mobs = {
      {
        id = 165111,
        displayId = 86207,
      }
    },
  },
  {
    noteName = "Tirnenn Villager",
    ddid = createDDID(6),
    mobs = {
      {
        id = 164929,
        displayId = 95618,
      }
    },
  },
  {
    noteName = "Drust Soulcleaver",
    ddid = createDDID(7),
    mobs = {
      {
        id = 164920,
        displayId = 95612,
      }
    },
  },
  {
    noteName = "Drust Harvester",
    ddid = createDDID(8),
    mobs = {
      {
        id = 164921,
        displayId = 95613,
      }
    },
  },
  {
    noteName = "Drust Boughbreaker",
    ddid = createDDID(9),
    mobs = {
      {
        id = 164926,
        displayId = 95615,
      }
    },
  },
  {
    noteName = "Mistveil Defender",
    ddid = createDDID(10),
    mobs = {
      {
        id = 163058,
        displayId = 95256,
      }
    },
  },
  {
    noteName = "Mistveil Stalker",
    ddid = createDDID(11),
    mobs = {
      {
        id = 166301,
        displayId = 93762,
      }
    },
  },
  {
    noteName = "Mistveil Stinger",
    ddid = createDDID(12),
    mobs = {
      {
        id = 166304,
        displayId = 95198,
      }
    },
  },
  {
    noteName = "Mistveil Guardian",
    ddid = createDDID(13),
    mobs = {
      {
        id = 166276,
        displayId = 95261,
      }
    },
  },
  {
    noteName = "Mistveil Tender",
    ddid = createDDID(14),
    mobs = {
      {
        id = 166299,
        displayId = 95908,
      }
    },
  },
  {
    noteName = "Mistveil Shaper",
    ddid = createDDID(15),
    mobs = {
      {
        id = 166275,
        displayId = 95051,
      }
    },
  },
  {
    noteName = "Mistveil Nightblossom",
    ddid = createDDID(16),
    mobs = {
      {
        id = 173714,
        displayId = 55772,
      }
    },
  },
  {
    noteName = "Spinemaw Staghorn",
    ddid = createDDID(17),
    mobs = {
      {
        id = 167111,
        displayId = 94190,
      }
    },
  },
  {
    noteName = "Spinemaw Acidgullet",
    ddid = createDDID(18),
    mobs = {
      {
        id = 167113,
        displayId = 94205,
      }
    },
  },
  {
    noteName = "Spinemaw Gorger",
    ddid = createDDID(19),
    mobs = {
      {
        id = 172312,
        displayId = 94197,
      }
    },
  },
  {
    noteName = "Spinemaw Larva",
    ddid = createDDID(20),
    mobs = {
      {
        id = 167117,
        displayId = 94208,
      }
    },
  },
  {
    noteName = "Spinemaw Reaver",
    ddid = createDDID(21),
    mobs = {
      {
        id = 167116,
        displayId = 95692,
      }
    },
  },
  {
    noteName = "Mistveil Gorgegullet",
    ddid = createDDID(22),
    mobs = {
      {
        id = 173720,
        displayId = 98502,
      }
    },
  },
  {
    noteName = "Mistveil Stinger",
    ddid = createDDID(23),
    mobs = {
      {
        id = 166304,
        displayId = 95198,
      }
    },
  },
  {
    noteName = "Mistveil Matriarch",
    ddid = createDDID(24),
    mobs = {
      {
        id = 173655,
        displayId = 98569,
      }
    },
  },
}

local dungeonData = {
  name = "Mists of Tirna Scithe",
  icon = "Interface\\ICONS\\spell_nature_moonkey",
  seasonId = "TWWS1",
  noteStructures = noteStructures,
}


function DD:Dungeons_InitMistsOfTirnaScithe()
  DD.Dungeons[dungeonData.name] = dungeonData
end
