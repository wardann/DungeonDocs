---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local LibSerialize = LibStub("LibSerialize") ---@type LibSerialize
local LibDeflate = LibStub("LibDeflate") ---@type LibDeflate

---@class DB
local M = {}

---@alias PlayerNote {
---     ddid: DDID,
---     primaryNote?: string,
---     tankNote?: string,
---     healerNote?: string,
---     damageNote?: string,
--- }
---
---@alias PlayerNoteKeys "primaryNote" | "tankNote" | "healerNote" | "damageNote"
---
---@alias PlayerNotes table<DungeonName, PlayerNote[]>

---@alias Position { point: string, relativePoint: string, xOffset: number, yOffset: number }

---@alias TextColor {
---    r: number,
---    g: number,
---    b: number,
---}

---@alias TextStyle {
---    font: string,
---    fontSize: number,
---    color: TextColor,
---}

---@alias OmniNoteSettings {
---    position: nil|Position,
---    noteWidth: number,
---    textAlign: "CENTER" | "LEFT" | "RIGHT",
---    noteGrowDirection: "UP" | "DOWN",
---    textOutline: boolean,
---    linePadding: number,
---    backgroundOpacity: number,
---    untargetedNoteOpacity: number,
---    noteSpacing: number,
---    showNoteTitle: boolean,
---    roleDisplay: "None" | "Current" | "All",
---    roleHeaderIndent: number,
---    roleNoteIndent: number,
---    displayRoleHeader: boolean,
---    tankHeader: string,
---    healerHeader: string,
---    damageHeader: string,
---    enableTrackMobDeaths: boolean,
---    enableMobCounters: boolean,
---    mobCounterPrefix: string,
---    mobCounterSuffix: string,
---    style: {
---        defaultText: TextStyle,
---        noteTitle: {
---            useDefaultTextStyle: boolean,
---            text: TextStyle,
---        },
---        primaryNote: {
---            useDefaultTextStyle: boolean,
---            text: TextStyle,
---        },
---        defaultRoleHeader: TextStyle,
---        tankHeader: {
---            useDefaultRoleHeaderStyle: boolean,
---            text: TextStyle,
---        },
---        tankNote: {
---            useDefaultTextStyle: boolean,
---            text: TextStyle,
---        },
---        healerHeader: {
---            useDefaultRoleHeaderStyle: boolean,
---            text: TextStyle,
---        },
---        healerNote: {
---            useDefaultTextStyle: boolean,
---            text: TextStyle,
---        },
---        damageHeader: {
---            useDefaultRoleHeaderStyle: boolean,
---            text: TextStyle,
---        },
---        damageNote: {
---            useDefaultTextStyle: boolean,
---            text: TextStyle,
---        },
---    },
---}

---@alias DatabaseSchema {
---    dbVersion: number,
---    docs: PlayerNotes,
---    settings: {
---        omniNote: OmniNoteSettings,
---    },
---    internal: {
---       fallbackProfile: string,
---       movers: {
---           omniNote: boolean,
---       },
---       seasons: {
---           TWWS1: string,
---       },
---       selectedSeason: string,
---       developerModeEnabled: boolean,
---    },
---}

local defaultTextFont = "Fonts\\FRIZQT__.TTF"
local defaultHeaderFont = "Fonts\\MORPHEUS_CYR.TTF"

-- Define default db values
---@type DatabaseSchema
local dbDefaults = {
	dbVersion = 1,
	docs = {}, ---@type PlayerNotes
	settings = {
		omniNote = {

			position = nil, ---@type nil|Position
			noteWidth = 380,

			textAlign = "LEFT", -- Values are "CENTER", "LEFT", "RIGHT"
			noteGrowDirection = "UP", -- Values are "UP", "DOWN"
			textOutline = false,
			linePadding = 5,
			backgroundOpacity = 0,
			untargetedNoteOpacity = 0.7,
			noteSpacing = 15,

			showNoteTitle = true,

			roleDisplay = "All", -- Values are "None", "Current", or "All"
			roleHeaderIndent = 0,
			roleNoteIndent = 0,
			displayRoleHeader = true,

			tankHeader = "Tank",
			healerHeader = "Healer",
			damageHeader = "Damage",

			enableTrackMobDeaths = true,
			enableMobCounters = true,
			mobCounterPrefix = "(",
			mobCounterSuffix = ")",

			style = {
				defaultText = {
					font = defaultTextFont,
					fontSize = 14,
					color = {
						r = 1,
						g = 1,
						b = 1,
					},
				},
				noteTitle = {
					useDefaultTextStyle = false,
					text = {
						font = defaultHeaderFont,
						fontSize = 22,
						color = {
							r = 255 / 255,
							g = 213 / 255,
							b = 116 / 255,
						},
					},
				},
				primaryNote = {
					useDefaultTextStyle = true,
					text = {
						font = defaultTextFont,
						fontSize = 14,
						color = {
							r = 1,
							g = 1,
							b = 1,
						},
					},
				},
				defaultRoleHeader = {
					font = defaultHeaderFont,
					fontSize = 16,
					color = {
						r = 255 / 255,
						g = 213 / 255,
						b = 116 / 255,
					},
				},
				tankHeader = {
					useDefaultRoleHeaderStyle = true,
					text = {
						font = defaultTextFont,
						fontSize = 14,
						color = {
							r = 1,
							g = 1,
							b = 1,
						},
					},
				},
				tankNote = {
					useDefaultTextStyle = true,
					text = {
						font = defaultTextFont,
						fontSize = 14,
						color = {
							r = 1,
							g = 1,
							b = 1,
						},
					},
				},
				healerHeader = {
					useDefaultRoleHeaderStyle = true,
					text = {
						font = defaultTextFont,
						fontSize = 14,
						color = {
							r = 1,
							g = 1,
							b = 1,
						},
					},
				},
				healerNote = {
					useDefaultTextStyle = true,
					text = {
						font = defaultTextFont,
						fontSize = 14,
						color = {
							r = 1,
							g = 1,
							b = 1,
						},
					},
				},
				damageHeader = {
					useDefaultRoleHeaderStyle = true,
					text = {
						font = defaultTextFont,
						fontSize = 14,
						color = {
							r = 1,
							g = 1,
							b = 1,
						},
					},
				},
				damageNote = {
					useDefaultTextStyle = true,
					text = {
						font = defaultTextFont,
						fontSize = 14,
						color = {
							r = 1,
							g = 1,
							b = 1,
						},
					},
				},
			},
		},
	},
	internal = {
		fallbackProfile = "Default Fallback*",
		movers = {
			primaryNote = false,
			roleNote = false,
			omniNote = false,
		},
		seasons = {
			TWWS1 = "The War Within - Season 1",
			TWWS2 = "The War Within - Season 2",
			TWWS3 = "The War Within - Season 3",
		},

		selectedSeason = "TWWS3",
		testText = "This is some test to text with.\nChange it to see how your notes might look.",
		showTestText = false,
		developerModeEnabled = false,
	},
}

---@return DatabaseSchema
function M.GetEmptyDatabaseStructure()
	return {
		dbVersion = 1, -- Default version
		docs = {}, -- Empty table for docs
		settings = {}, -- Empty table for settings
		internal = {}, -- Empty table for internal data
	}
end

---@return DatabaseSchema
function M.GetDBDefaults()
	return dbDefaults
end

---@return boolean
function M.ToggleDevMode()
	local devModeEnabled = not M.database.profile.internal.developerModeEnabled
	M.database.profile.internal.developerModeEnabled = devModeEnabled
	M.NotifyDBChange()
	return devModeEnabled
end

---@param profile DatabaseSchema
---@param defaults DatabaseSchema
local function applyDefaults(profile, defaults)
	--- NOTE: the types aren't getting inferred correctly here.
	--- Unsure how to solve, disabling for now
	---@diagnostic disable-next-line
	for key, value in pairs(defaults) do
		if profile[key] == nil then
			---@diagnostic disable-next-line
			profile[key] = DD.utils.DeepCopy(value)
		elseif type(value) == "table" and type(profile[key]) == "table" then
			---@diagnostic disable-next-line
			applyDefaults(profile[key], value) -- Recursively apply for nested tables
		end
	end
end

---@param profileName string
function M.EnsureDefaults(profileName)
	local p = M.database.profiles[profileName]
	if not p then
		DD.utils.Log("Error: could not ensure defaults, profile does not exist: ", profileName)
		return
	end
	applyDefaults(p, dbDefaults)
end

function M.EnsureDefaultsAllProfiles()
	for profileName in pairs(M.database.profiles) do
		M.EnsureDefaults(profileName)
	end
end

function M.ApplyFixesAllProfiles()
	for profileName in pairs(M.database.profiles) do
		local p = M.database.profiles[profileName]
		if not p then
			DD.utils.Log("Error: could not apply fixes, profile does not exist: ", profileName)
			return
		end

		-- Apply fix for Eco-Dome Al'dani name correction
		local edaOldName = "Eco-Dome Al’Dani"
		local edaNewName = "Eco-Dome Al'dani"
		if p.docs[edaOldName] ~= nil then
			p.docs[edaNewName] = p.docs[edaOldName]
			p.docs[edaOldName] = nil
			DD.utils.Log("Fixed " .. DD.utils.Gray("Eco-Dome Al'dani") .. " on profile " .. DD.utils.Gray(profileName))
		end
	end
end

function M.Init()
	local defaultProfileName = "Default"

	-- Empty defaults {} are used here so everything gets flushed to disk and missing fields
	-- aren't encountered due to the on-demand pruning AceDB does
	M.database = LibStub("AceDB-3.0"):New("DungeonDocsDB", {}, defaultProfileName) ---@type AceDB

	-- Init defaults on all profiles
	M.EnsureDefaultsAllProfiles()

	-- Apply DB fixes to all profiles
	M.ApplyFixesAllProfiles()

	-- If there is no default profile, then this is the first time the addon is running. Apply
	-- defaults directly to the active profile to ensure all fields are there as expected
	if not M.database.profiles[defaultProfileName] then
		applyDefaults(M.database.profile, dbDefaults)
	end

	-- Reset internal vars
	M.database.profile.internal.movers.omniNote = false
	M.database.profile.internal.selectedSeason = "TWWS3"
end

-- A table to hold subscriber functions
---@type fun()[]
local dbChangeSubscribers = {}

---@param callback fun()
function M.SubscribeToDBChange(callback)
	table.insert(dbChangeSubscribers, callback)
end

function M.NotifyDBChange()
	for _, callback in ipairs(dbChangeSubscribers) do
		---@type boolean, any
		local status, err = pcall(callback)
		if not status then
			error(err)
		end
	end
end

---@param updater fun()
function M.UpdateDB(updater)
	updater()
	M.NotifyDBChange()
end

function M.ListProfiles()
	return M.database:GetProfiles()
end

---@param profileName string
function M.SelectProfile(profileName)
	local db = M.database
	if db:GetCurrentProfile() ~= profileName then -- Only switch if different
		db:SetProfile(profileName)
		DD.db.database.profile.internal.movers.omniNote = false
		M.NotifyDBChange()
		DD.utils.Log("Switched to active profile", DD.utils.Gray(profileName))
	end
end

---@param profileName string
function M.SelectFallbackProfile(profileName)
	local db = M.database
	if db.profile.internal.fallbackProfile == profileName then -- Only switch if different
		return
	end
	db.profile.internal.fallbackProfile = profileName
	M.NotifyDBChange()
	DD.utils.Log("Switched to fallback profile", DD.utils.Gray(profileName))
end

-- Function to export the current profile, excluding the "internal" table
---@param profileName string
---@param includeFallbackProfile boolean
function M.ExportProfile(profileName, includeFallbackProfile)
	local profile = M.database.profiles[profileName] -- Access the specified profile data
	if not profile then
		DD.utils.Log("Error exporting, could not find profile", DD.utils.Gray(profileName))
		return
	end

	local fallbackProfileName = profile.internal.fallbackProfile
	local fallbackProfile = M.database.profiles[fallbackProfileName]

	if includeFallbackProfile and not fallbackProfile then
		DD.utils.Log("Error exporting, could not find fallback profile", DD.utils.Gray(fallbackProfileName))
		return
	end

	local playerNotes ---@type PlayerNotes
	if not includeFallbackProfile then
		playerNotes = profile.docs
	else
		playerNotes = DD.utils.MergePlayerNotes(profile.docs, fallbackProfile.docs)
	end

	local profileCopy = DD.utils.DeepCopy(profile)
	profileCopy.internal = {}
	profileCopy.docs = playerNotes

	local serialized = LibSerialize:Serialize(profileCopy) -- Serialize profile copy
	local compressed = LibDeflate:CompressDeflate(serialized) -- Compress serialized data
	local encoded = LibDeflate:EncodeForPrint(compressed) -- Encode to Base64
	local wrapped = "dd:" .. profile.dbVersion .. ":" .. encoded .. ":dd"

	return wrapped
end

---@param wrapped string
---@return {dbVersion: number, encoded: string}|nil, string|nil
local function validateAndParseWrappedString(wrapped)
	-- Validate the format using a pattern
	local pattern = "^dd:(%d+):(.+):dd$"
	local dbVersion, encoded = wrapped:match(pattern)

	if not dbVersion or not encoded then
		return nil, "Invalid format. The string does not match the expected pattern."
	end

	-- Convert dbVersion to a number
	dbVersion = tonumber(dbVersion)

	-- Return the parsed values
	return {
		dbVersion = dbVersion,
		encoded = encoded,
	}, nil
end

-- Function to import a profile from a Base64 string
function M.ImportProfile(destProfileName, wrapped)
	local db = M.database
	local destProfile = db.profiles[destProfileName] -- Access the specified profile data

	if destProfile ~= nil then
		DD.utils.Log("Error importing, profile already exists: " .. destProfileName)
		return false
	end

	local result, err = validateAndParseWrappedString(wrapped)
	if err then
		DD.utils.Log("Error importing, the provided string seems to be incomplete")
		return false
	end

	if not result then
		DD.utils.Log("Error importing, an unexpected error occurred")
		return false
	end

	local encoded = result.encoded

	-- Decode, decompress, and deserialize the profile string
	local decoded = LibDeflate:DecodeForPrint(encoded) -- Decode Base64
	if not decoded then
		DD.utils.Log("Error decoding, got nil")
		return false
	end
	local decompressed = LibDeflate:DecompressDeflate(decoded) -- Decompress
	if not decompressed then
		DD.utils.Log("Error deflating, got nil")
		return false
	end
	local success, profileData = LibSerialize:Deserialize(decompressed) -- Deserialize to table

	if success and profileData then
		-- Init dest profile
		db.profiles[destProfileName] = DD.utils.DeepCopy(profileData)
		M.EnsureDefaults(destProfileName)
		M.NotifyDBChange()

		DD.utils.Log("Success! Imported profile", DD.utils.Gray(destProfileName))
		return true
	else
		DD.utils.Log("Error! Could not import profile " .. destProfileName)
		return false
	end
end

function M.CloneProfile(sourceProfileName, destProfileName)
	local db = M.database
	local sourceProfile = db.profiles[sourceProfileName]

	if sourceProfile == nil then
		DD.utils.Log("Error! Could not clone profile, source `" .. sourceProfileName .. "` does not exist")
		return
	end

	if db.profiles[destProfileName] then
		DD.utils.Log("Error! Could not clone profile, destination profile `" .. sourceProfileName .. "` already exists")
		return
	end

	-- Init the profile
	db.profiles[destProfileName] = M.GetEmptyDatabaseStructure()

	-- Copy the source profile
	db.profiles[destProfileName] = DD.utils.DeepCopy(sourceProfile)
	M.EnsureDefaults(destProfileName)

	M.NotifyDBChange()

	DD.utils.Log("Profile", DD.utils.Gray(sourceProfileName), "cloned to profile", DD.utils.Gray(destProfileName))
end

function M.RenameProfile(sourceProfileName, newProfileName)
	local db = M.database

	-- Check if the current profile exists
	local sourceProfile = db.profiles[sourceProfileName]
	if not sourceProfile then
		DD.utils.Log("Error! Profile does not exist: ", sourceProfileName)
		return
	end

	-- Check if the new profile name is already taken
	if db.profiles[newProfileName] then
		DD.utils.Log("Error! Profile with the name '" .. newProfileName .. "' already exists.")
		return
	end

	-- Copy current profile data to the new profile
	db.profiles[newProfileName] = M.GetEmptyDatabaseStructure()
	db.profiles[newProfileName] = DD.utils.DeepCopy(sourceProfile)

	-- If the old profile was active, switch to the new profile
	if db:GetCurrentProfile() == sourceProfileName then
		db:SetProfile(newProfileName)
	end

	-- Delete the old profile
	db.profiles[sourceProfileName] = nil

	M.NotifyDBChange()

	DD.utils.Log("Success! Profile renamed from", DD.utils.Gray(sourceProfileName), "to", DD.utils.Gray(newProfileName))
end

function M.DeleteProfile(profileName)
	local db = M.database

	if profileName == "Default" then
		DD.utils.Log("Error! Cannot delete the default profile")
		return
	end
	-- Check if the profile exists
	if not db.profiles[profileName] then
		DD.utils.Log("Error! Cannot delete, profile", DD.utils.Gray(profileName), "does not exist")
		return
	end

	-- Prevent deleting active profile
	if db:GetCurrentProfile() == profileName then
		DD.utils.Log("Error! Cannot delete active profile")
		return
	end

	-- Delete the profile
	db.profiles[profileName] = nil
	DD.utils.Log("Profile", DD.utils.Gray(profileName), "deleted successfully")
end

function M.ResetProfile(profileName)
	local db = M.database

	if not db.profiles[profileName] then
		DD.utils.Log("Error! Cannot reset, profile does not exist:", profileName)
		return
	end

	---@type DatabaseSchema
	db.profiles[profileName] = M.GetEmptyDatabaseStructure()
	M.EnsureDefaults(profileName)
	M.NotifyDBChange()

	local currentProfile = db:GetCurrentProfile()
	if currentProfile == profileName then
		--- Switch to the default fallback profile (which can't be deleted nor reset) and then switch back
		--- This triggers the UI to update if we're already on the profile, just calling M.NotifyDBChange isn't enough
		db:SetProfile("Default Fallback*")
		db:SetProfile(profileName)
		M.NotifyDBChange()
	end

	DD.utils.Log("Profile", DD.utils.Gray(profileName), "reset to defaults")
end

-- GetActiveNoteWithFallback gets the note from the DB for the specified note key, falling
-- back to the fallback profile if the note is not found
---@param dungeonName DungeonName
---@param ddid DDID
---@param noteKey PlayerNoteKeys
function M.GetActiveNoteWithFallback(dungeonName, ddid, noteKey)
	local db = M.database

	local playerNotes = db.profile.docs[dungeonName]
	if not playerNotes then
		return M.GetNoteFallback(dungeonName, ddid, noteKey)
	end

	local playerNote ---@type PlayerNote
	for _, pn in ipairs(playerNotes) do
		if pn.ddid == ddid then
			playerNote = pn
			break
		end
	end

	if not playerNote then
		return M.GetNoteFallback(dungeonName, ddid, noteKey)
	end

	if not playerNote[noteKey] then
		return M.GetNoteFallback(dungeonName, ddid, noteKey)
	end

	return playerNote[noteKey]
end

---@param dungeonName DungeonName
---@param ddid DDID
function M.DeriveFullNote(dungeonName, ddid)
	return {
		primaryNote = M.GetActiveNoteWithFallback(dungeonName, ddid, "primaryNote"),
		healerNote = M.GetActiveNoteWithFallback(dungeonName, ddid, "healerNote"),
		damageNote = M.GetActiveNoteWithFallback(dungeonName, ddid, "damageNote"),
		tankNote = M.GetActiveNoteWithFallback(dungeonName, ddid, "tankNote"),
	}
end

---@param dungeonName DungeonName
---@param ddid DDID
---@param noteKey PlayerNoteKeys
function M.GetNoteFallback(dungeonName, ddid, noteKey)
	local db = M.database
	local fallbackProfileName = db.profile.internal.fallbackProfile

	if not fallbackProfileName then
		return ""
	end

	local fallbackProfile = db.profiles[fallbackProfileName]
	if not fallbackProfile then
		return ""
	end

	if fallbackProfile == "None*" then
		return ""
	end

	local playerNotes = fallbackProfile.docs[dungeonName]
	if not playerNotes then
		return ""
	end

	local playerNote ---@type PlayerNote

	for _, pn in ipairs(playerNotes) do
		if pn.ddid == ddid then
			playerNote = pn
			break
		end
	end

	if not playerNote then
		return ""
	end

	if not playerNote[noteKey] then
		return ""
	end

	return playerNote[noteKey]
end

-- SetNote sets the note from the DB for the specified note key, creating the
-- note if it's not found
---@param dungeonName DungeonName
---@param ddid DDID
---@param noteKey PlayerNoteKeys
---@param newNote string|nil
function M.SetNote(dungeonName, ddid, noteKey, newNote)
	local db = M.database

	local playerNotes = db.profile.docs[dungeonName]
	if not playerNotes then
		M.UpdateDB(function()
			db.profile.docs[dungeonName] = {}
			table.insert(db.profile.docs[dungeonName], {
				ddid = ddid,
				[noteKey] = newNote,
			})
		end)
		return
	end

	local playerNote ---@type PlayerNote
	for _, pn in ipairs(playerNotes) do
		if pn.ddid == ddid then
			playerNote = pn
			break
		end
	end

	if not playerNote then
		M.UpdateDB(function()
			local newDoc = {
				ddid = ddid,
				[noteKey] = newNote,
			}
			table.insert(db.profile.docs[dungeonName], newDoc)
		end)
		return
	end

	M.UpdateDB(function()
		--- NOTE: the typing here appears to be confused, ignoring for now
		---@diagnostic disable-next-line
		playerNote[noteKey] = newNote
	end)
end

DD.db = M
