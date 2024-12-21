--- @type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


--- @type ProfileNotes
local notes = {
  {
    -- bossName = "General Umbriss",
    ddid = "gb1",
    primaryNote = "(1) Avoid orange circles on ground.\n(2) When room turns purple, look for safe lane",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- bossName = "Forgemaster Throngus",
    ddid = "gb2",
    primaryNote = "(1) When boss changes weapon, he does lots of aoe damage\n(2) Phase 1 is Axe, drop conals next to each other\n(3) Phase 2 is dual wield, tank buster, big heals on tank\n(4) Phase 3 is 2h mace - kite phase\n(5) Rinse & Repeat",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- bossName = "Drahga Shadowburner",
    ddid = "gb3",
    primaryNote = "(1) Phase 1 kill adds\n(2) Phase 2 kill adds and avoid stuff (this can get crazy, help your healer, avoid stuff)\n(3) Boss done at 50%",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- bossName = "Erudax",
    ddid = "gb4",
    primaryNote = "(1) Avoid Tenticles\n(2) Compress when room starts closing in, but still stay as spread out as possible",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Twilight Brute",
    ddid = "gb5",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Twilight Earthcaller",
    ddid = "gb6",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Twilight Destroyer",
    ddid = "gb7",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Twilight Overseer",
    ddid = "gb8",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Twilight Beguiler",
    ddid = "gb9",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Molten Giant",
    ddid = "gb10",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Twilight Enforcer",
    ddid = "gb11",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Twilight Warlock",
    ddid = "gb12",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Twilight Flamerender",
    ddid = "gb13",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Twilight Lavabender",
    ddid = "gb14",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Mutated Hatchling",
    ddid = "gb15",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Faceless Corruptor",
    ddid = "gb16",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Invoked Shadowflame Spirit",
    ddid = "gb17",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Battered",
    ddid = "gb18",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
}

--- @type ProfileDungeonNotes
local profileDungeonNotes = {
  dungeonName = "Grim Batol",
  notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
