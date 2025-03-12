---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@type PlayerNote[]
local notes = {

	-- ######  #######  #####   #####  #######  #####
	-- #     # #     # #     # #     # #       #     #
	-- #     # #     # #       #       #       #
	-- ######  #     #  #####   #####  #####    #####
	-- #     # #     #       #       # #             #
	-- #     # #     # #     # #     # #       #     #
	-- ######  #######  #####   #####  #######  #####
	{
		-- bossName = "Captain Dailcry",
		ddid = "potsf1",
		primaryNote = "- Always interrupt [Battle Cry]\n- Break [Savage Mauling] absorb shield ASAP\n- Avoid spear\n- Interrupt Duelmal (if paired with him)",
		healerNote = "",
		damageNote = "",
		tankNote = "- Mitigate [Pierce Armor]\n- Mitigate Emberlanz's attacks (if paired with her)",
	},
	{
		-- bossName = "Baron Braunpyke",
		ddid = "potsf2",
		primaryNote = "1. Avoid hazards\n2. Help tank soak if needed",
		healerNote = "",
		damageNote = "",
		tankNote = "- The 3 Sacrifical Pyre orbs need to be soaked\n- During [Vindictive Wrath], there will be 5 orbs and you may need help",
	},
	{
		-- bossName = "Prioress Murrpray",
		ddid = "potsf3",
		primaryNote = "PHASE 1:\n\n1. Look away when boss casts [Blinding Light]\n2. Bait beam to edges of room if targeted\n3. Interrupt [Holy Smite]\n\n\nPHASE 2:\n\n1. Chase boss upstairs, CC & nuke adds that spawn ASAP\n2. Once shield is broken, Phase 1 mechanics start again",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},

	-- ####### ######     #     #####  #     #
	--    #    #     #   # #   #     # #     #
	--    #    #     #  #   #  #       #     #
	--    #    ######  #     #  #####  #######
	--    #    #   #   #######       # #     #
	--    #    #    #  #     # #     # #     #
	--    #    #     # #     #  #####  #     #
	{
		-- name = "Arathi Footman",
		ddid = "potsf4",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Arathi Knight",
		ddid = "potsf5",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Arathi Neophyte",
		ddid = "potsf6",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Ardent Paladin",
		ddid = "potsf7",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Devout Priest",
		ddid = "potsf8",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Elaena Emberlanz",
		ddid = "potsf9",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Fanatical Conjuror",
		ddid = "potsf10",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Fervent Sharpshooter",
		ddid = "potsf11",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Forge Master Damian",
		ddid = "potsf12",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Guard Captain Suleyman",
		ddid = "potsf13",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "High Priest Aemya",
		ddid = "potsf14",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Lightspawn",
		ddid = "potsf15",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Risen Footman",
		ddid = "potsf16",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Risen Mage",
		ddid = "potsf17",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Sergeant Shaynemail",
		ddid = "potsf18",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Sir Braunpyke",
		ddid = "potsf19",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Taener Duelmal",
		ddid = "potsf20",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "War Lynx",
		ddid = "potsf21",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Zealous Templar",
		ddid = "potsf22",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
	{
		-- name = "Priory of the Sacred Flame",
		ddid = "potsf23",
		primaryNote = "",
		healerNote = "",
		damageNote = "",
		tankNote = "",
	},
}

---@type ProfileDungeonNotes
local profileDungeonNotes = {
	dungeonName = "Priory of the Sacred Flame",
	notes = notes,
}

DD.profiles.DefaultFallback_InitDocs(profileDungeonNotes)
