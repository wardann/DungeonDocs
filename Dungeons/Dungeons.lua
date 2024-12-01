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

-- Returns ame of the current dungeon the player is in
function DD:Dungeons_GetCurrentDungeon()
    local instanceName, instanceType = GetInstanceInfo()
    if instanceType ~= "party" then
        return
    end
    return instanceName
end

function DD:Dungeons_IsBossInDungeon(mobId, dungeonName)
    local dungeon = DD.Dungeons[dungeonName]

    for _, noteStruct in ipairs(dungeon.noteStructures) do
        for _, mob in ipairs(noteStruct.mobs) do
            if tostring(mob.id) == tostring(mobId) then
                return noteStruct.isBoss
            end
        end
    end

    return false
end

function DD:Dungeons_IsBossInCurrentDungeon(mobId)
    local dungeonName = DD:Dungeons_GetCurrentDungeon()
    if not dungeonName then return false end
    return DD:Dungeons_IsBossInDungeon(mobId, dungeonName)
end

-- Returns the name of the note from a mob id
function DD:Dungeons_MobIdToNoteName(mobId, dungeonName)
    local dungeon = DD.Dungeons[dungeonName]

    if not dungeon then
        return
    end

    for _, noteStruct in ipairs(dungeon.noteStructures) do
        for _, mob in ipairs(noteStruct.mobs) do
            if tostring(mob.id) == tostring(mobId) then
                return noteStruct.noteName
            end
        end
    end
end

function DD:Dungeons_MobIdToDungeonName(mobId)
    for dungeonName, dungeon in pairs(DD.Dungeons) do
        for _, noteStruct in ipairs(dungeon.noteStructures) do
            for _, mob in ipairs(noteStruct.mobs) do
                if tostring(mob.id) == tostring(mobId) then
                    return dungeonName
                end
            end
        end
    end
end

function DD:Dungeons_MobIDToDDID(mobId, dungeonName)
    local dungeon = DD.Dungeons[dungeonName]

    if not dungeon then
        return
    end

    for _, noteStruct in ipairs(dungeon.noteStructures) do
        for _, mob in ipairs(noteStruct.mobs) do
            if tostring(mob.id) == tostring(mobId) then
                return noteStruct.ddid
            end
        end
    end
end
