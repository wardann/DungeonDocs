---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@alias Seasons {
---     TWWS1: DungeonName[],
---     TWWS2: DungeonName[],
---     TWWS3: DungeonName[],
--- }

---@type Seasons
DD.seasons = {
	TWWS1 = {
		DD.DungeonNames.AraKara,
		DD.DungeonNames.CityOfThreads,
		DD.DungeonNames.GrimBatol,
		DD.DungeonNames.MistsOfTirnaScithe,
		DD.DungeonNames.SiegeOfBoralus,
		DD.DungeonNames.TheDawnbreaker,
		DD.DungeonNames.TheNecroticWake,
		DD.DungeonNames.TheStonevault,
	},
	TWWS2 = {
		DD.DungeonNames.CinderbrewMeadery,
		DD.DungeonNames.DarkflameCleft,
		DD.DungeonNames.MechagonWorkshop,
		DD.DungeonNames.OperationFloodgate,
		DD.DungeonNames.PrioryOfTheSacredFlame,
		DD.DungeonNames.TheaterOfPain,
		DD.DungeonNames.TheMotherlode,
		DD.DungeonNames.TheRookery,
	},
	TWWS3 = {
		DD.DungeonNames.TheDawnbreaker,
		DD.DungeonNames.AraKara,
		DD.DungeonNames.OperationFloodgate,
		DD.DungeonNames.PrioryOfTheSacredFlame,
		DD.DungeonNames.EcoDomeAldani,
		DD.DungeonNames.HallsOfAtonement,
		DD.DungeonNames.TazaveshSoleahsGambit,
		DD.DungeonNames.TazaveshStreetsOfWonder,
	},
}
