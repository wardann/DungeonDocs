---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


---@type ProfileNote[]
local notes = {
  {
    -- bossName = "E.D.N.A",
    ddid = "tsv1",
    primaryNote = "(1) Using the boss's arrow attack, clear a few of the spikes on the ground\n(2) Do NOT break all spikes at the same time\n(3) Do NOT stack",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- bossName = "Skarmorak",
    ddid = "tsv2",
    primaryNote = "(1) When the shards spawn, destory only ONE at a time\n(2) When the orbs spawn, only pick up 1-3 at a time",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- bossName = "Master Machinists",
    ddid = "tsv3",
    encounterId = 2590,
    primaryNote = "(1) Focus the small boss first & always interrupt\n(2) Focus big boss when small boss runs (keep interrupting small boss)\n(3) Do not stand on exhaust vents\n(4) Avoid DEATH CUBE\n(5) Kill both at the same time!",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- bossName = "Void Speaker Eirich",
    ddid = "tsv4",
    primaryNote = "(1) Drop blue circles at the edge of the room\n(2) Clear your corruption by standing near a portal, but NOT on top of it\n(3) Avoid DEATH CONE",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Cursedheart Invader",
    ddid = "tsv5",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Earth Infused Golem",
    ddid = "tsv6",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Ghastly Voidsoul",
    ddid = "tsv7",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Repurposed Loaderbot",
    ddid = "tsv8",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Void Bound Despoiler",
    ddid = "tsv9",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Engine Speaker",
    ddid = "tsv10",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Void Bound Howler",
    ddid = "tsv11",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Turned Speaker",
    ddid = "tsv12",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Void Touched Elemental",
    ddid = "tsv13",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Aspiring Forgehand",
    ddid = "tsv14",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Forgebound Mender",
    ddid = "tsv15",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Forge Loader",
    ddid = "tsv16",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Cursedforge Honor Guard",
    ddid = "tsv17",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Cursedforge Stoneshaper",
    ddid = "tsv18",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Rock Smasher",
    ddid = "tsv19",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
  {
    -- name = "Cursedforge Mender",
    ddid = "tsv20",
    primaryNote = "",
    healerNote = "",
    damageNote = "",
    tankNote = "",
  },
}

--- @type ProfileDungeonNotes
local profileDungeonNotes = {
  dungeonName = "The Stonevault",
  notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
