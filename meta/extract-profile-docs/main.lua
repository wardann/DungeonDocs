-- Import these before we mock out LibStub, else there will be errors
local LibDeflate = require("Libs.LibDeflate.LibDeflate")
local LibSerialize = require("Libs.LibSerialize.LibSerialize")

require("meta.extract-profile-docs.dd")

require("DungeonNames")

require("Dungeons.Dungeons")

require("Dungeons.TWW.S1.AraKara")
require("Dungeons.TWW.S1.CityOfThreads")
require("Dungeons.TWW.S1.GrimBatol")
require("Dungeons.TWW.S1.MistsOfTirnaScithe")
require("Dungeons.TWW.S1.SiegeOfBoralus")
require("Dungeons.TWW.S1.TheDawnbreaker")
require("Dungeons.TWW.S1.TheNecroticWake")
require("Dungeons.TWW.S1.TheStonevault")

require("Dungeons.TWW.S2.CinderbrewMeadery")
require("Dungeons.TWW.S2.DarkflameCleft")
require("Dungeons.TWW.S2.OperationFloodgate")
require("Dungeons.TWW.S2.OperationMechagon")
require("Dungeons.TWW.S2.PrioryOfTheSacredFlame")
require("Dungeons.TWW.S2.TheaterOfPain")
require("Dungeons.TWW.S2.TheMotherlode")
require("Dungeons.TWW.S2.TheRookery")

require("Dungeons.TWW.S3.EcoDomeAldani")
require("Dungeons.TWW.S3.HallsOfAtonement")
require("Dungeons.TWW.S3.TazaveshSoleahsGambit")
require("Dungeons.TWW.S3.TazaveshStreetsOfWonder")

-- Load the Dungeons module
require("Dungeons.Dungeons")

-- Initialize the dungeons
DD.dungeons.Init()

-- Read profile string from stdin
local profileInput = io.read("*a")

local function deserializeProfile(exportedProfile)
	local pattern = "^dd:(%d+):(.+):dd$"
	local dbVersion, encoded = exportedProfile:match(pattern)

	if not dbVersion or not encoded then
		error("Invalid profile format. Expected format: dd:<version>:<encoded_data>:dd")
	end

	if dbVersion ~= "1" then
		error("Unsupported database version: " .. dbVersion)
	end

	local decoded = LibDeflate:DecodeForPrint(encoded) -- Decode Base64
	if not decoded then
		print("Error decoding Base64, got nil")
		return false
	end
	local decompressed = LibDeflate:DecompressDeflate(decoded) -- Decompress
	if not decompressed then
		print("Error")
		return false
	end
	local success, profileData = LibSerialize:Deserialize(decompressed) -- Deserialize to table
	if success and profileData then
		return profileData
	else
		error("Could not extract profile")
		return nil
	end
end

local profile = deserializeProfile(profileInput)

-- Helper function to validate dungeon names
local function IsValidDungeonName(dungeonName)
    return DD.dungeons.List[dungeonName] ~= nil
end

-- Helper function to get docName for a given dungeonName and ddid
local function GetDocName(dungeonName, ddid)
    local dungeonData = DD.dungeons.List[dungeonName]
    if not dungeonData or not dungeonData.docStructures then return nil end
    for _, docStruct in ipairs(dungeonData.docStructures) do
        if docStruct.ddid == ddid then
            return docStruct.docName
        end
    end
    return nil
end

-- Extract all player notes into a flattened array
local flattenedNotes = {}
for dungeonName, instanceDocs in pairs(profile.docs) do
    if IsValidDungeonName(dungeonName) then
        for _, playerNote in ipairs(instanceDocs) do
            local docName = GetDocName(dungeonName, playerNote.ddid)
            table.insert(flattenedNotes, {
                ddid = playerNote.ddid,
                primaryNote = playerNote.primaryNote,
                tankNote = playerNote.tankNote,
                healerNote = playerNote.healerNote,
                damageNote = playerNote.damageNote,
                docName = docName,
                dungeonName = dungeonName
            })
        end
    else
        print(string.format("Warning: dungeonName '%s' not found in DD.dungeons.List", dungeonName))
    end
end

local json = require("dkjson")

-- Build output array (no base64)
local outputArray = {}
for _, note in ipairs(flattenedNotes) do
    table.insert(outputArray, {
        ddid = note.ddid or "",
        primaryNote = note.primaryNote or "",
        tankNote = note.tankNote or "",
        healerNote = note.healerNote or "",
        damageNote = note.damageNote or "",
        docName = note.docName or "",
        dungeonName = note.dungeonName or ""
    })
end

print(json.encode(outputArray, { indent = false }))

