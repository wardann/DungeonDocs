---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@class OmniNote
local M = {}

local omniAnchorFrame ---@type Frame
local omniNoteFrame ---@type Frame
local noteFrames = {} ---@type table<string, Frame>
local targetNoteCount = 10

local testNoteEnabled = false
local ddidsToRender = {} ---@type DDID[]
local guidsEncountered = {} ---@type table<string, boolean>
local ddidsCount = {} ---@type table<DDID, number>
local ddidToDungeon = {} ---@type table<DDID, DungeonName>

local playerTargetMobId ---@type string|nil

local testNoteOpacityEnabled = false

-- ### #     # ### #######
--  #  ##    #  #     #
--  #  # #   #  #     #
--  #  #  #  #  #     #
--  #  #   # #  #     #
--  #  #    ##  #     #
-- ### #     # ###    #

function M.Init()
	omniAnchorFrame = DD.movers.GetOmni()
	M.initNoteFrames()
end

DD.db.SubscribeToDBChange(function()
	M.RenderOmniNote()
end)

---@param index number
local function buildNoteCardName(index)
	return "NoteCard" .. index
end

---@param index number
local function buildSpacerName(index)
	return "Spacer" .. index
end

function M.initNoteFrames()
	local width = omniAnchorFrame:GetWidth()

	---@param parent Frame
	---@param addBackground boolean|nil
	---@param addFontString boolean|nil
	---@return Frame
	local function initFrame(parent, addBackground, addFontString)
		local frame = CreateFrame("Frame", nil, parent)
		frame:SetWidth(width)
		frame:Show()

		if addBackground then
			frame.bg = frame:CreateTexture(nil, "BACKGROUND")
			frame.bg:SetAllPoints(frame)
			frame.bg:SetColorTexture(0, 0, 0, 0)
		end

		if addFontString then
			frame.fontString = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
			frame.fontString:SetWordWrap(true)
		end

		return frame
	end

	omniNoteFrame = initFrame(omniAnchorFrame, true)

	for i = 1, targetNoteCount do
		-- Init note card
		local noteCardName = buildNoteCardName(i)
		local noteCardFrame = initFrame(omniNoteFrame, true)
		noteFrames[noteCardName] = noteCardFrame

		-- Init note card lines
		initFrame(noteCardFrame, true, true) -- NoteTitle
		initFrame(noteCardFrame, true, true) -- PrimaryNote
		initFrame(noteCardFrame, true, true) -- TankHeader
		initFrame(noteCardFrame, true, true) -- TankNote
		initFrame(noteCardFrame, true, true) -- HealerHeader
		initFrame(noteCardFrame, true, true) -- HealerNote
		initFrame(noteCardFrame, true, true) -- DamageHeader
		initFrame(noteCardFrame, true, true) -- DamageNote

		-- Init spacer
		local spacerName = buildSpacerName(i)
		local spacerFrame = initFrame(omniNoteFrame, true)
		noteFrames[spacerName] = spacerFrame
	end
end

-- #####  ###### #    # #####  ###### #####     #    #  ####  ##### ######
-- #    # #      ##   # #    # #      #    #    ##   # #    #   #   #
-- #    # #####  # #  # #    # #####  #    #    # #  # #    #   #   #####
-- #####  #      #  # # #    # #      #####     #  # # #    #   #   #
-- #   #  #      #   ## #    # #      #   #     #   ## #    #   #   #
-- #    # ###### #    # #####  ###### #    #    #    #  ####    #   ######

---@param ddid DDID
---@param dungeonName DungeonName
---@alias DocNote { docStruct: DocStructure, playerNote: PlayerNote }
---@return DocNote | nil
local function renderEncounteredMob(ddid, dungeonName)
	local docStruct = DD.dungeons.DDIDToDocStruct(ddid, dungeonName)
	if not docStruct then
		return
	end

	local playerNote = DD.db.DeriveFullNote(dungeonName, ddid)
	if not playerNote then
		return
	end

	if
		playerNote.primaryNote == ""
		and playerNote.tankNote == ""
		and playerNote.healerNote == ""
		and playerNote.damageNote == ""
	then
		return
	end

	return {
		docStruct = docStruct,
		playerNote = playerNote,
	}
end

---@param index number
---@param anchor Frame
---@param docNotesToRender DocNote[]
---@return Frame
function M.RenderNote(index, anchor, docNotesToRender)
	local u = DD.utils
	local noteCardFrame = noteFrames[buildNoteCardName(index)]
	local spacerFrame = noteFrames[buildSpacerName(index)]

	-- Collapse and return if there's no note to render
	local docNote = docNotesToRender[index]
	if not docNote then
		u.SafeFrameCollapse(noteCardFrame)
		u.SafeFrameCollapse(spacerFrame)
		return spacerFrame
	end

	local playerNote = docNote.playerNote
	local docStruct = docNote.docStruct

	local state = DD.db.database.profile.settings.omniNote

	local noteCardLines = { noteCardFrame:GetChildren() }
	local width = omniAnchorFrame:GetWidth()
	local previousFrame = noteCardFrame
	local totalHeight = 0 ---@type number
	local linePadding = state.linePadding * -1
	local firstFrameDisplayed = false

	---@param padding number
	local withPadding = function(padding)
		totalHeight = totalHeight + math.abs(padding) ---@type number
		return padding
	end

	---@param lineName string
	---@return string
	local function resolveText(lineName)
		if lineName == "noteTitle" then
			local mobCount = ddidsCount[docNote.docStruct.ddid]
			local mobCountText = ""
			if state.enableMobCounters and not docStruct.isBoss and mobCount and mobCount > 0 then
				mobCountText = " " .. state.mobCounterPrefix .. mobCount .. state.mobCounterSuffix
			end
			return docStruct.docName .. mobCountText
		end

		if string.find(lineName, "Header") then
			return state[lineName] ---@type string
		end

		return playerNote[lineName]
	end

	---@param lineName string
	local function resolveTextStyle(lineName)
		local defaultTextStyle = state.style.defaultText
		if string.find(lineName, "Header") then
			defaultTextStyle = state.style.defaultRoleHeader
		end

		local styleState = state.style[lineName]
		local textStyle = styleState.text

		if styleState.useDefaultTextStyle or styleState.useDefaultRoleHeaderStyle then
			textStyle = defaultTextStyle
		end

		return textStyle
	end

	---@alias UpdateLineConfig {
	---    name: string,
	---    index: number,
	---    indent: number,
	---    displayed: boolean,
	---}
	---@param line UpdateLineConfig
	local function updateLine(line)
		local frame = noteCardLines[line.index]

		local anchorPoint = "BOTTOM"
		if not firstFrameDisplayed and line.displayed then
			anchorPoint = "TOP"
			firstFrameDisplayed = true
		end

		if not line.displayed then
			u.SafeFrameSetPoint(frame, "TOP", previousFrame, anchorPoint, 0, 0)
			u.SafeFrameCollapse(frame)
			return
		end

		local textStyle = resolveTextStyle(line.name)

		local fontFlags = ""
		if state.textOutline then
			fontFlags = "OUTLINE"
		end

		local alpha = 1.0
		local isTargeted = false
		for _, mob in ipairs(docStruct.mobs) do
			if playerTargetMobId == mob.id then
				isTargeted = true
			end
		end

		if not isTargeted then
			alpha = state.untargetedNoteOpacity
		end

		if testNoteEnabled then
			alpha = 1.0
		end

		if docStruct.isBoss then
			alpha = 1.0
		end

		-- Update font string properties
		if textStyle then
			u.SafeSetFont(frame.fontString, textStyle.font, textStyle.fontSize, fontFlags)
			u.SafeSetTextColor(frame.fontString, textStyle.color.r, textStyle.color.g, textStyle.color.b, 1)
		end

		u.SafeSetAlpha(frame.fontString, alpha)
		u.SafeSetJustifyH(frame.fontString, state.textAlign)
		u.SafeFrameWidth(frame.fontString, width)
		u.SafeFrameSetPoint(frame.fontString, "LEFT", frame, "LEFT", line.indent, 0)

		-- Update frame properties
		u.SafeFrameShow(frame)
		u.SafeFrameSetPoint(frame, "TOP", previousFrame, anchorPoint, 0, withPadding(linePadding))
		u.SafeFontText(frame, resolveText(line.name))
		u.SafeFrameWidth(frame, width)

		local height = frame.fontString:GetStringHeight()
		u.SafeFrameHeight(frame, height)
		totalHeight = totalHeight + height

		if testNoteOpacityEnabled then
			u.SafeSetAllPoints(frame.bg, frame)
			u.SafeSetColorTexture(frame.bg, 1, 0, 0, 0.5)
		end

		previousFrame = frame
	end

	local defaultIndent = 5
	local roleNoteIndent = defaultIndent + state.roleNoteIndent
	local roleHeaderIndent = defaultIndent + state.roleHeaderIndent

	-- Note title line
	updateLine({
		name = "noteTitle",
		index = 1,
		indent = defaultIndent,
		displayed = state.showNoteTitle,
	})

	-- Primary note line
	updateLine({
		name = "primaryNote",
		index = 2,
		indent = defaultIndent,
		displayed = playerNote.primaryNote ~= "",
	})

	-- Tank header line
	local tankDisplayed = M.ShouldDisplayRole(playerNote.tankNote, "Tank")
	updateLine({
		name = "tankHeader",
		index = 3,
		indent = roleHeaderIndent,
		displayed = tankDisplayed and state.displayRoleHeader,
	})

	-- Tank note line
	updateLine({
		name = "tankNote",
		index = 4,
		indent = roleNoteIndent,
		displayed = tankDisplayed,
	})

	-- Healer header line
	local healerDisplayed = M.ShouldDisplayRole(playerNote.healerNote, "Healer")
	updateLine({
		name = "healerHeader",
		index = 5,
		indent = roleHeaderIndent,
		displayed = healerDisplayed and state.displayRoleHeader,
	})

	-- Healer note line
	updateLine({
		name = "healerNote",
		index = 6,
		indent = roleNoteIndent,
		displayed = healerDisplayed,
	})

	-- Damage header line
	local damageDisplayed = M.ShouldDisplayRole(playerNote.damageNote, "Damage")
	updateLine({
		name = "damageHeader",
		index = 7,
		indent = roleHeaderIndent,
		displayed = damageDisplayed and state.displayRoleHeader,
	})

	-- Damage note line
	updateLine({
		name = "damageNote",
		index = 8,
		indent = roleNoteIndent,
		displayed = damageDisplayed,
	})

	-- Update note card frame
	u.SafeFrameShow(noteCardFrame)
	u.SafeFrameWidth(noteCardFrame, width)
	u.SafeFrameHeight(noteCardFrame, totalHeight)

	-- Update spacer frame
	u.SafeFrameShow(spacerFrame)
	u.SafeFrameWidth(spacerFrame, width)
	u.SafeFrameHeight(spacerFrame, state.noteSpacing)

	-- Handle grow direction UP
	if state.noteGrowDirection == "UP" then
		if index == 1 then
			u.SafeFrameSetPoint(noteCardFrame, "BOTTOM", anchor, "BOTTOM", 0, 0)
		else
			u.SafeFrameSetPoint(noteCardFrame, "BOTTOM", anchor, "TOP", 0, 0)
		end
		u.SafeFrameSetPoint(spacerFrame, "BOTTOM", noteCardFrame, "TOP", 0, 0)
	end

	-- Handle grow direction DOWN
	if state.noteGrowDirection == "DOWN" then
		if index == 1 then
			u.SafeFrameSetPoint(noteCardFrame, "TOP", anchor, "TOP", 0, 0)
		else
			u.SafeFrameSetPoint(noteCardFrame, "TOP", anchor, "BOTTOM", 0, 0)
		end
		u.SafeFrameSetPoint(spacerFrame, "TOP", noteCardFrame, "BOTTOM", 0, 0)
	end

	if testNoteOpacityEnabled then
		u.SafeSetAllPoints(noteCardFrame.bg, noteCardFrame)
		u.SafeSetColorTexture(noteCardFrame.bg, 0, 0, 1, 0.5)

		u.SafeSetAllPoints(spacerFrame.bg, spacerFrame)
		u.SafeSetColorTexture(spacerFrame.bg, 0, 1, 0, 0.5)
	end

	return spacerFrame
end

---@param note string
---@param role string
function M.ShouldDisplayRole(note, role)
	if note == "" then
		return false
	end

	local state = DD.db.database.profile.settings.omniNote

	if state.roleDisplay == "All" then
		return true
	end

	if state.roleDisplay == "None" then
		return false
	end

	-- Handle state.roleDisplay == "Current"
	local specIndex = GetSpecialization()
	if not specIndex then
		return false
	end
	local specRole = GetSpecializationRole(specIndex)

	---@param r string
	local normalizeRole = function(r)
		r = string.sub(r, 1, 1)
		return string.lower(r)
	end

	return normalizeRole(role) == normalizeRole(specRole)
end

local previousNoteGrowDirection ---@type string

-- #####  ###### #    # #####  ###### #####      ####  #    # #    # #
-- #    # #      ##   # #    # #      #    #    #    # ##  ## ##   # #
-- #    # #####  # #  # #    # #####  #    #    #    # # ## # # #  # #
-- #####  #      #  # # #    # #      #####     #    # #    # #  # # #
-- #   #  #      #   ## #    # #      #   #     #    # #    # #   ## #
-- #    # ###### #    # #####  ###### #    #     ####  #    # #    # #

function M.RenderOmniNote()
	local u = DD.utils
	local state = DD.db.database.profile.settings.omniNote
	local internal = DD.db.database.profile.internal

	--- Clear all points if the grow direction has changed, else
	--- we run into height calculation issues all over the place
	if not previousNoteGrowDirection then
		previousNoteGrowDirection = state.noteGrowDirection
	end
	if state.noteGrowDirection ~= previousNoteGrowDirection then
		omniNoteFrame:ClearAllPoints()

		for _, frame in pairs(noteFrames) do
			frame:ClearAllPoints()
		end

		previousNoteGrowDirection = state.noteGrowDirection
	end

	local docNotesToRender = {} ---@type DocNote[]
	for _, ddid in ipairs(ddidsToRender) do
		local dungeonName = ddidToDungeon[ddid]
		local docNote = renderEncounteredMob(ddid, dungeonName)
		if docNote then
			table.insert(docNotesToRender, docNote)
		end
	end

	local previousSpacer = omniNoteFrame
	for i = 1, targetNoteCount do
		local newSpacer = M.RenderNote(i, previousSpacer, docNotesToRender)

		-- Collapse the previous spacer if there are no more notes
		if newSpacer:GetHeight() == 0 then
			DD.utils.SafeFrameCollapse(previousSpacer)
		end

		previousSpacer = newSpacer
	end

	local totalHeight = 0
	for _, frame in pairs(noteFrames) do
		totalHeight = totalHeight + frame:GetHeight()
	end

	u.SafeFrameShow(omniNoteFrame)
	u.SafeFrameHeight(omniNoteFrame, totalHeight)
	u.SafeFrameWidth(omniNoteFrame, omniAnchorFrame:GetWidth())

	if state.noteGrowDirection == "UP" then
		if internal.movers.omniNote then
			u.SafeFrameSetPoint(omniNoteFrame, "BOTTOM", omniAnchorFrame, "TOP", 0, 0)
		else
			u.SafeFrameSetPoint(omniNoteFrame, "BOTTOM", omniAnchorFrame, "BOTTOM", 0, 0)
		end
	else
		if internal.movers.omniNote then
			u.SafeFrameSetPoint(omniNoteFrame, "TOP", omniAnchorFrame, "BOTTOM", 0, 0)
		else
			u.SafeFrameSetPoint(omniNoteFrame, "TOP", omniAnchorFrame, "TOP", 0, 0)
		end
	end

	-- Set opacity
	u.SafeSetAllPoints(omniNoteFrame.bg, omniNoteFrame)
	u.SafeSetColorTexture(omniNoteFrame.bg, 0, 0, 0, state.backgroundOpacity)
end

-- ###### #    # ###### #    # #####  ####
-- #      #    # #      ##   #   #   #
-- #####  #    # #####  # #  #   #    ####
-- #      #    # #      #  # #   #        #
-- #       #  #  #      #   ##   #   #    #
-- ######   ##   ###### #    #   #    ####

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")

local clearRenderedNotes = function()
	ddidsToRender = {}
	ddidToDungeon = {}
	guidsEncountered = {}
	ddidsCount = {}
	testNoteEnabled = false
end

---@param mobId string
---@param guid string|nil
---@param isDead boolean|nil
local function storeEncounteredMob(mobId, guid, isDead)
	if DD.utils.IsFollowerNPC(mobId) then
		return
	end

	local dungeonName = DD.dungeons.GetCurrentDungeon()
	if not dungeonName then
		return
	end

	local ddid = DD.dungeons.MobIdToDDID(mobId, dungeonName)

	if not ddid then
		return
	end

	-- If we haven't seen this GUID before, store it and
	-- init / increment the DDID count
	if guid and guidsEncountered[guid] == nil then
		guidsEncountered[guid] = true

		if ddidsCount[ddid] == nil then
			ddidsCount[ddid] = 1
		else
			ddidsCount[ddid] = ddidsCount[ddid] + 1
		end
	end

	-- If the mob is dead decrement the count
	if isDead then
		local count = ddidsCount[ddid]
		if count and count > 0 then
			count = count - 1
			ddidsCount[ddid] = count
		end
	end

	local isStored = DD.utils.IsInArray(ddidsToRender, ddid)
	if not isStored then
		table.insert(ddidsToRender, ddid)
		ddidToDungeon[ddid] = dungeonName
	end

	-- Remove mobs if their count is zero, unless it's the player's target
	local state = DD.db.database.profile.settings.omniNote
	if state.enableTrackMobDeaths then
		local targetDDID = "unset" --- @type string|nil
		for i = #ddidsToRender, 1, -1 do
			local ddidToRender = ddidsToRender[i]
			local count = ddidsCount[ddidToRender]
			if not count or count == 0 then
				if targetDDID == "unset" then
					targetDDID = DD.dungeons.MobIdToDDID(playerTargetMobId or "", dungeonName)
				end

				if ddidToRender ~= targetDDID then
					table.remove(ddidsToRender, i)
				end
			end
		end
	end
end

local ensureTarget = function()
	local inCombat = UnitAffectingCombat("player")
	local guid = UnitGUID("target")
	local unitType, unitId, mobId ---@type string, string, string

	if guid then
		---@type string, string, string, string, string, string
		unitType, _, _, _, _, unitId = strsplit("-", guid)
		mobId = unitId
	end

	-- If in combat without a target, clear target
	if inCombat and not guid then
		playerTargetMobId = nil

	-- If not in combat and no target, clear target and notes
	elseif not inCombat and not guid then
		playerTargetMobId = nil
		clearRenderedNotes()

	-- If not in combat and target is a player, clear target
	elseif not inCombat and guid and unitType == "Player" then
		playerTargetMobId = nil
		clearRenderedNotes()

	-- If not in combat and target is a mob, clear notes, set target, store mob
	elseif not inCombat and guid and unitType ~= "Player" then
		clearRenderedNotes()
		playerTargetMobId = mobId
		storeEncounteredMob(mobId)

	-- If in combat and target is not a player, store mob
	elseif inCombat and guid and unitType ~= "Player" then
		playerTargetMobId = unitId
		storeEncounteredMob(mobId)
	end

	M.RenderOmniNoteWithThrottle()
end

eventFrame:SetScript("OnEvent", function(_, event)
	-- luacheck: ignore
	if event == "PLAYER_REGEN_DISABLED" then
		-- Reset encountered mobs at start of combat
		clearRenderedNotes()
		ensureTarget()
	elseif event == "PLAYER_REGEN_ENABLED" then
		-- Reset encountered mobs at end of combat
		clearRenderedNotes()
		ensureTarget()
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local inCombat = UnitAffectingCombat("player")
		if not inCombat then
			return
		end

		local _, subEvent, _, sourceGUID, _, _, _, destGUID, _ = CombatLogGetCurrentEventInfo()

		local isDead = subEvent == "UNIT_DIED" or subEvent == "UNIT_DESTROYED"

		local sourceMobId = sourceGUID:match("-(%d+)-%x+$")
		local sourceGuidType = sourceGUID:match("^(.-)-")

		local destMobId = destGUID:match("-(%d+)-%x+$")
		local destGuidType = destGUID:match("^(.-)-")

		local isValidEvent = function()
			if isDead then
				return true
			end

			if sourceGuidType == "Player" and destGuidType == "Player" then
				return false
			end

			if DD.utils.IsFollowerNPC(sourceMobId) or DD.utils.IsFollowerNPC(destMobId) then
				return true
			end

			if sourceGuidType == "Player" or destGuidType == "Player" then
				return true
			end
		end

		if isValidEvent() then
			if sourceGuidType ~= "Player" then
				storeEncounteredMob(sourceMobId, sourceGUID, isDead)
			end
			if destGuidType ~= "Player" then
				storeEncounteredMob(destMobId, destGUID, isDead)
			end
			M.RenderOmniNoteWithThrottle()
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		ensureTarget()
	end
end)

---@param ddid DDID
---@param dungeonName DungeonName
function M.RenderTestNote(ddid, dungeonName)
	local inCombat = UnitAffectingCombat("player")
	if inCombat then
		DD.utils.Log("Cannot render test note while in combat")
		return
	end

	testNoteEnabled = true
	table.insert(ddidsToRender, ddid)
	ddidToDungeon[ddid] = dungeonName

	-- Init or increment count
	if ddidsCount[ddid] == nil then
		ddidsCount[ddid] = 1
	else
		ddidsCount[ddid] = ddidsCount[ddid] + 1
	end
	M.RenderOmniNoteWithThrottle()
end

function M.ClearNotes()
	local inCombat = UnitAffectingCombat("player")
	if inCombat then
		DD.utils.Log("Cannot clear notes while in combat")
		return
	end

	clearRenderedNotes()
	ensureTarget()
	M.RenderOmniNoteWithThrottle()
end

-- ##### #    # #####   ####  ##### ##### #      ######
--   #   #    # #    # #    #   #     #   #      #
--   #   ###### #    # #    #   #     #   #      #####
--   #   #    # #####  #    #   #     #   #      #
--   #   #    # #   #  #    #   #     #   #      #
--   #   #    # #    #  ####    #     #   ###### ######

local THROTTLE_INTERVAL = 0.1 ---@type number
local lastRender = 0 ---@type number
local pendingRender = false

-- Internal function that does the actual rendering
local function doRenderOmniNote()
	lastRender = GetTime()
	pendingRender = false
	M.RenderOmniNote()
end

function M.RenderOmniNoteWithThrottle()
	local now = GetTime()
	local delta = now - lastRender

	-- If enough time has passed, render immediately.
	if delta >= THROTTLE_INTERVAL then
		doRenderOmniNote()
	else
		-- If we haven't already scheduled a pending render, schedule one now
		if not pendingRender then
			pendingRender = true
			local remaining = THROTTLE_INTERVAL - delta
			C_Timer.After(remaining, doRenderOmniNote)
		end
		-- If we already have a pending render, do nothing—
		-- it will happen when the timer expires.
	end
end

DD.omniNote = M
