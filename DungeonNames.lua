---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@alias DungeonNames {
---     AraKara: DungeonName,
---     CityOfThreads: DungeonName,
---     GrimBatol: DungeonName,
---     MistsOfTirnaScithe: DungeonName,
---     SiegeOfBoralus: DungeonName,
---     TheDawnbreaker: DungeonName,
---     TheNecroticWake: DungeonName,
---     TheStonevault: DungeonName,
---     CinderbrewMeadery: DungeonName,
---     DarkflameCleft: DungeonName,
---     MechagonWorkshop: DungeonName,
---     OperationFloodgate: DungeonName,
---     PrioryOfTheSacredFlame: DungeonName,
---     TheaterOfPain: DungeonName,
---     TheMotherlode: DungeonName,
---     TheRookery: DungeonName,
---     EcoDomeAldani: DungeonName,
---     HallsOfAtonement: DungeonName,
---     TazaveshSoleahsGambit: DungeonName,
---     TazaveshStreetsOfWonder: DungeonName,
---}

---@type DungeonNames
DD.DungeonNames = {
	-- TWW Season 1
	AraKara = "Ara-Kara, City of Echoes",
	CityOfThreads = "City of Threads",
	GrimBatol = "Grim Batol",
	MistsOfTirnaScithe = "Mists of Tirna Scithe",
	SiegeOfBoralus = "Siege of Boralus",
	TheDawnbreaker = "The Dawnbreaker",
	TheNecroticWake = "The Necrotic Wake",
	TheStonevault = "The Stonevault",

	-- TWW Season 2
	CinderbrewMeadery = "Cinderbrew Meadery",
	DarkflameCleft = "Darkflame Cleft",
	MechagonWorkshop = "Operation: Mechagon",
	OperationFloodgate = "Operation: Floodgate",
	PrioryOfTheSacredFlame = "Priory of the Sacred Flame",
	TheaterOfPain = "Theater of Pain",
	TheMotherlode = "The MOTHERLODE!!",
	TheRookery = "The Rookery",

	-- TWW Season 3
	EcoDomeAldani = "Eco-Dome Al'dani",
	HallsOfAtonement = "Halls of Atonement",
	TazaveshSoleahsGambit = "Tazavesh: So'leah's Gambit",
	TazaveshStreetsOfWonder = "Tazavesh: Streets of Wonder",
}
