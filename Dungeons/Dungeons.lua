--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @alias DocMob {id: number, displayId: number, hideModel?: boolean}
--- @alias DocStructure {docName: string, ddid: DDID, isBoss: boolean|nil, mobs: DocMob[]}
--- @alias DungeonData {dungeonName: DungeonName, icon: string, seasonId: string, docStructures: DocStructure[]}

--- @alias CreateDDID fun(index: number): DDID

--- @class Dungeons
local M = {}

--- @alias DungeonList table<DungeonName, DungeonData>
--- @type DungeonList
M.List = {}


function M.Init()
    M.InitAraKara()
    M.InitCityOfThreads()
    M.InitGrimBatol()
    M.InitMistsOfTirnaScithe()
    M.InitSiegeOfBoralus()
    M.InitTheDawnbreaker()
    M.InitTheNecroticWake()
    M.InitTheStonevault()
end

--- @returns DungeonList
function M.GetCurrentSeason()
    local db = DD.db.database
    local dungeons = {} --- @type DungeonList

    for dungeonName, d in pairs(M.List) do
        if d.seasonId == db.profile.internal.selectedSeason then
            dungeons[dungeonName] = d
        end
    end

    return dungeons
end

-- Returns ame of the current dungeon the player is in
function M.GetCurrentDungeon()
    local instanceName, instanceType = GetInstanceInfo()
    if instanceType ~= "party" then
        return
    end
    return instanceName
end

function M.IsBossInDungeon(mobId, dungeonName)
    local dungeon = M.List[dungeonName]

    for _, docStruct in ipairs(dungeon.docStructures) do
        for _, mob in ipairs(docStruct.mobs) do
            if tostring(mob.id) == tostring(mobId) then
                return docStruct.isBoss
            end
        end
    end

    return false
end

function M.IsBossInCurrentDungeon(mobId)
    local dungeonName = M.GetCurrentDungeon()
    if not dungeonName then return false end
    return M.IsBossInDungeon(mobId, dungeonName)
end

-- Returns the name of the note from a mob id
function M.MobIdToNoteName(mobId, dungeonName)
    local dungeon = M.List[dungeonName]

    if not dungeon then
        return
    end

    for _, docStruct in ipairs(dungeon.docStructures) do
        for _, mob in ipairs(docStruct.mobs) do
            if tostring(mob.id) == tostring(mobId) then
                return docStruct.docName
            end
        end
    end
end

function M.MobIdToDDID(mobId, dungeonName)
    local dungeon = M.List[dungeonName]

    if not dungeon then
        return
    end

    for _, docStruct in ipairs(dungeon.docStructures) do
        for _, mob in ipairs(docStruct.mobs) do
            if tostring(mob.id) == tostring(mobId) then
                return docStruct.ddid
            end
        end
    end
end

function M.DDIDToNoteName(ddid, dungeonName)
    local dungeon = M.List[dungeonName]

    if not dungeon then
        return
    end

    for _, docStruct in ipairs(dungeon.docStructures) do
        if docStruct.ddid == ddid then
            return docStruct.docName
        end
    end
end

function M.DDIDToNoteStruct(ddid, dungeonName)
    local dungeon = M.List[dungeonName]

    if not dungeon then
        return
    end

    for _, docStruct in ipairs(dungeon.docStructures) do
        if docStruct.ddid == ddid then
            return docStruct
        end
    end
end

function M.MobIdToDungeonName(mobId)
    for dungeonName, dungeon in pairs(M.List) do
        for _, docStruct in ipairs(dungeon.docStructures) do
            for _, mob in ipairs(docStruct.mobs) do
                if tostring(mob.id) == tostring(mobId) then
                    return dungeonName
                end
            end
        end
    end
end

function M.MobIDToDDID(mobId, dungeonName)
    local dungeon = M.List[dungeonName]

    if not dungeon then
        return
    end

    for _, docStruct in ipairs(dungeon.docStructures) do
        for _, mob in ipairs(docStruct.mobs) do
            if tostring(mob.id) == tostring(mobId) then
                return docStruct.ddid
            end
        end
    end
end

DD.dungeons = M