local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

DD.Dungeons = {}

function DD:Dungeons_InitAll()
    DD:Dungeons_InitAraKara()
    DD:Dungeons_InitCityOfThreads()
    DD:Dungeons_InitGrimBatol()
    DD:Dungeons_InitMistsOfTirnaScithe()
    DD:Dungeons_InitSiegeOfBoralus()
    DD:Dungeons_InitTheDawnbreaker()
    DD:Dungeons_InitTheNecroticWake()
    DD:Dungeons_InitTheStonevault()
end

function DD:Dungeons_GetCurrentSeason()
    local db = self.db
    local dungeons = {}

    for dungeonName, d in pairs(DD.Dungeons) do
        if d.seasonId == db.profile.internal.selectedSeason then
            dungeons[dungeonName] = d
        end
    end

    return dungeons
end