--- @type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


--- @type ProfileNotes
local notes = {
  {
    -- bossName = "Speaker Shadowcrown",
    ddid = "tdb1",
    primaryNote = "(1) Avoid the rotating purple beams of death\n(2) Fly away at 50% and 0% HP, when boss does instant kill spell",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- bossName = "Anub'ikkaj",
    ddid = "tdb2",
    primaryNote = "(1) Run out of purple circle\n(2) Don't get hit by giant purple ball\n(3) Ball does big AoE damage if it collides with an object(4)\nIf targeted by ball, send up or down the hill",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- bossName = "Rashanan",
    ddid = "tdb3",
    primaryNote = "(1) In the first phase, only the barrels matter, not DPS. Use barrels ASAP.\n(2) You can fly straight to second platform but first grab a gold orb\n(3) In the second phase, take the webs to the edge of the platform\n(4) Boss down at 60%",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Starved Crawler",
    ddid = "tdb4",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Nightfall Curseblade",
    ddid = "tdb5",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Nightfall Shadowmage",
    ddid = "tdb6",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Nightfall Ritualist",
    ddid = "tdb7",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Nightfall Commander",
    ddid = "tdb8",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Sureki Webmage",
    ddid = "tdb9",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Nightfall Darkcaster",
    ddid = "tdb10",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Nightfall Shadowalker",
    ddid = "tdb11",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Manifested Shadow",
    ddid = "tdb12",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Sureki Militant",
    ddid = "tdb13",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Nightfall Tactician",
    ddid = "tdb14",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Ascendant Viscoxria",
    ddid = "tdb15",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Deathscreamer Ikentak",
    ddid = "tdb16",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Ixkreten The Unbreakable",
    ddid = "tdb17",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Nightfall Dark Architect",
    ddid = "tdb18",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
}

--- @type ProfileDungeonNotes
local profileDungeonNotes = {
  dungeonName = "The Dawnbreaker",
  notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
