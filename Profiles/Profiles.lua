--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @class Profiles
local M = {}

--- @alias ProfileNote {ddid: string, primaryNote: string, healerNote: string, damageNote: string, tankNote: string}
--- @alias ProfileDungeonNotes {dungeonName: string, notes: ProfileNote[]}

--- @type string[]
local reservedProfileNames = {}

--- @param profileName string
function M.ReserveProfileName(profileName)
    table.insert(reservedProfileNames, profileName)
end

--- @param profileName string
--- @returns boolean
function M.IsReservedProfile(profileName)
    for _, value in ipairs(reservedProfileNames) do
        if value == profileName then
            return true
        end
    end
    return false
end

--- @param profileDungeonNotes ProfileDungeonNotes
--- @returns ProfileNote[]
function M.BuildProfileNotes(profileDungeonNotes)
    local profileNotes = {} ---@type ProfileNote[]

    --- @param note ProfileNote
    local function shouldInsert(note)
        return note.primaryNote ~= "" or note.healerNote ~= "" or note.damageNote ~= "" or note.tankNote ~= ""
    end

    for _, note in ipairs(profileDungeonNotes.notes) do
        if shouldInsert(note) then
            table.insert(profileNotes, note)
        end
    end

    return profileNotes
end

function M.Init()
    M.DefaultFallback_Init()

    local db = DD.db.database

    -- Bootstrap player Default profile
    if not db.profiles["Default"] then
        db.profiles["Default"] = {}
    end

    -- Set Default profile as active if no profile is active
    if not db.profile then
        db:SetProfile("Default")
    end
end

DD.profiles = M
