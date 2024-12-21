--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @class Profiles
local M = {}

--- @alias ProfileNote {ddid: string, primaryNote: string, healerNote: string, damageNote: string, tankNote: string}
--- @alias ProfileNotes table<ProfileNote>
--- @alias ProfileDungeonNotes {dungeonName: string, notes: ProfileNotes}

--- @type table<string>
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
--- @returns ProfileNotes
function M.BuildProfileNotes(profileDungeonNotes)
    --- @type ProfileNotes
    local profileNotes = {}

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

    -- Bootstrap player Default profile
    if not DD.db.profiles["Default"] then
        DD.db.profiles["Default"] = {}
    end

    -- Set Default profile as active if no profile is active
    if not DD.db.profile then
        DD.db:SetProfile("Default")
    end
end

DD.profiles = M
