local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


local notes = {
  {
    -- bossName = "Ingra Maloch",
    ddid = "mots1",
    primaryNote = "(1) Save DPS cooldowns for when boss is stunned\n(2) Avoid swirlies",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- bossName = "Mistcaller",
    ddid = "mots2",
    primaryNote = "(1) Avoid BALLS OF DEATH\n(2) Avoid FOX OF DEATH\n(3) When boss creates 4 clones, kill the odd one out",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- bossName = "Tred'ova",
    ddid = "mots3",
    primaryNote = "(1) Avoid swirlies\n(2) The tank & the rest of party should stay on opposite sides of the boss. This makes breaking the tether easier\n(3) Kill adds\n(4) At 70% & 40% the boss shields. DPS shield down quickly and interrupt",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Starved Crawler",
    ddid = "mots4",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Drust Spiteclaw",
    ddid = "mots5",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Tirnenn Villager",
    ddid = "mots6",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Drust Soulcleaver",
    ddid = "mots7",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Drust Harvester",
    ddid = "mots8",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Drust Boughbreaker",
    ddid = "mots9",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Mistveil Defender",
    ddid = "mots10",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Mistveil Stalker",
    ddid = "mots11",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Mistveil Stinger",
    ddid = "mots12",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Mistveil Guardian",
    ddid = "mots13",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Mistveil Tender",
    ddid = "mots14",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Mistveil Shaper",
    ddid = "mots15",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Mistveil Nightblossom",
    ddid = "mots16",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Spinemaw Staghorn",
    ddid = "mots17",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Spinemaw Acidgullet",
    ddid = "mots18",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Spinemaw Gorger",
    ddid = "mots19",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Spinemaw Larva",
    ddid = "mots20",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Spinemaw Reaver",
    ddid = "mots21",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Mistveil Gorgegullet",
    ddid = "mots22",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Mistveil Stinger",
    ddid = "mots23",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Mistveil Matriarch",
    ddid = "mots24",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
}

local dungeonData = {
  name = "Mists of Tirna Scithe",
  notes = notes,
}

DD:ProfilesDefault_InitDocs(dungeonData)
