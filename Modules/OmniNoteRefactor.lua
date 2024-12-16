local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local omniAnchorFrame
local omniNoteFrame
local noteFrames = {}
local targetNoteCount = 10

local testNoteEnabled = false
local ddidsToRender = {}
local ddidToDungeon = {}

local function buildNoteCardName(index)
    return "NoteCard" .. index
end

local function buildSpacerName(index)
    return "Spacer" .. index
end

local function initNoteFrames()
    local width = omniAnchorFrame:GetWidth()

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
        initFrame(noteCardFrame, true, true) -- MobName
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

local function storeEncounteredMob(mobId)
    if IsFollowerNPC(mobId) then return end

    local dungeonName = DD:Dungeons_GetCurrentDungeon()
    local ddid = DD:Dungeons_MobIdToDDID(mobId, dungeonName)

    if not ddid then return end

    for _, foundDDID in ipairs(ddidsToRender) do
        if foundDDID == ddid then
            return
        end
    end

    table.insert(ddidsToRender, ddid)
    ddidToDungeon[ddid] = dungeonName

    Log(">>> storing ddid", ddid)
    return true
end

local function renderEncounteredMob(ddid, dungeonName)
    local noteName = DD:Dungeons_DDIDToNoteName(ddid, dungeonName)
    if not noteName then
        return
    end

    local note = DD:DB_DeriveFullNote(dungeonName, ddid)
    if not note then
        return
    end

    if note.primaryNote == "" and note.tankNote == "" and note.healerNote == "" and note.damageNote == "" then
        return
    end

    return {
        noteName = noteName,
        note = note,
    }
end


function DD:RenderNote(index, anchor)
    local noteCardFrame = noteFrames[buildNoteCardName(index)]
    local spacerFrame = noteFrames[buildSpacerName(index)]

    local ddid = ddidsToRender[index]
    if not ddid then
        FrameCollapse(noteCardFrame)
        FrameCollapse(spacerFrame)
        return spacerFrame
    end

    local dungeonName = ddidToDungeon[ddid]
    local noteInfo = renderEncounteredMob(ddid, dungeonName)


    if not noteInfo then
        FrameCollapse(noteCardFrame)
        FrameCollapse(spacerFrame)
        return spacerFrame
    end

    local note = noteInfo.note
    local noteName = noteInfo.noteName

    local state         = self.db.profile.settings.omniNote
    local internal      = self.db.profile.internal

    local width         = omniAnchorFrame:GetWidth()
    local noteCardLines = { noteCardFrame:GetChildren() }
    local previousFrame = noteCardFrame
    local totalHeight   = 0

    local function resolveText(lineName)
        if lineName == "mobName" then
            return noteName
        end

        if string.find(lineName, "Header") then
            return state[lineName]
        end

        return note[lineName]
    end

    local function updateLine(lineName, lineIndex)
        local frame = noteCardLines[lineIndex]

        local anchorPoint = "BOTTOM"
        if lineIndex == 1 then
            anchorPoint = "TOP"
        end

        FrameShow(frame)
        FrameSetPoint(frame, "TOP", previousFrame, anchorPoint, 0, 0) -- TODO add line padding
        FontText(frame, resolveText(lineName))

        local height = frame.fontString:GetStringHeight()
        FrameHeight(frame, height)
        totalHeight = totalHeight + height

        FrameWidth(frame, width)
        frame.fontString:SetPoint("LEFT", frame, "LEFT", 0, 0) -- TODO add indent, switch to FrameSetPoint

        previousFrame = frame
    end

    -- Update note card lines
    updateLine("mobName", 1)
    updateLine("primaryNote", 2)
    updateLine("tankHeader", 3)
    updateLine("tankNote", 4)
    updateLine("healerHeader", 5)
    updateLine("healerNote", 6)
    updateLine("damageHeader", 7)
    updateLine("damageNote", 8)


    -- Update note card frame
    FrameShow(noteCardFrame)
    FrameWidth(noteCardFrame, width)
    FrameHeight(noteCardFrame, totalHeight)

    -- Update spacer frame
    FrameShow(spacerFrame)
    FrameWidth(spacerFrame, width)
    FrameHeight(spacerFrame, state.noteSpacing)

    -- Handle grow direction UP
    if state.noteGrowDirection == "UP" then
        if index == 1 then
            FrameSetPoint(noteCardFrame, "BOTTOM", anchor, "BOTTOM", 0, 0)
        else
            FrameSetPoint(noteCardFrame, "BOTTOM", anchor, "TOP", 0, 0)
        end
        FrameSetPoint(spacerFrame, "BOTTOM", noteCardFrame, "TOP", 0, 0)
    end

    -- Handle grow direction DOWN
    if state.noteGrowDirection == "DOWN" then
        if index == 1 then
            FrameSetPoint(noteCardFrame, "TOP", anchor, "TOP", 0, 0)
        else
            FrameSetPoint(noteCardFrame, "TOP", anchor, "BOTTOM", 0, 0)
        end
        FrameSetPoint(spacerFrame, "TOP", noteCardFrame, "BOTTOM", 0, 0)
    end

    -- TEMP ADD BACKGROUND
    noteCardFrame.bg:SetAllPoints(noteCardFrame)   -- Make the texture cover the entire frame
    noteCardFrame.bg:SetColorTexture(0, 0, 1, 0.5) -- Blue with 50% opacity

    spacerFrame.bg:SetAllPoints(spacerFrame)       -- Make the texture cover the entire frame
    spacerFrame.bg:SetColorTexture(0, 1, 0, 0.5)   -- Green with 50% opacity

    return spacerFrame
end

function DD:RenderOmniNote()
    local previousSpacer = omniNoteFrame
    for i = 1, targetNoteCount do
        local newSpacer = DD:RenderNote(i, previousSpacer)
        
        -- Collapse the previous spacer if there are no more notes
        if newSpacer:GetHeight() == 0 then
            FrameCollapse(previousSpacer)
        end

        previousSpacer = newSpacer
    end

    local totalHeight = 0
    for _, frame in pairs(noteFrames) do
        totalHeight = totalHeight + frame:GetHeight()
    end

    FrameShow(omniNoteFrame)
    FrameHeight(omniNoteFrame, totalHeight)
    FrameWidth(omniNoteFrame, omniAnchorFrame:GetWidth())

    local state    = self.db.profile.settings.omniNote
    local internal = self.db.profile.internal

    if state.noteGrowDirection == "UP" then
        if internal.movers.omniNote then
            FrameSetPoint(omniNoteFrame, "BOTTOM", omniAnchorFrame, "TOP", 0, 0)
        else
            FrameSetPoint(omniNoteFrame, "BOTTOM", omniAnchorFrame, "BOTTOM", 0, 0)
        end
    else
        if internal.movers.omniNote then
            FrameSetPoint(omniNoteFrame, "TOP", omniAnchorFrame, "BOTTOM", 0, 0)
        else
            FrameSetPoint(omniNoteFrame, "TOP", omniAnchorFrame, "TOP", 0, 0)
        end
    end
end

function DD:OmniNote_Init()
    omniAnchorFrame = DD:Movers_GetOmni()
    initNoteFrames()
end

DD:SubscribeToDBChange(function()
    DD:RenderOmniNote()
end)

local playerTargetMobId

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")

local ensureTarget = function()
    local inCombat = UnitAffectingCombat("player")
    local guid = UnitGUID("target")
    local unitType, unitId, mobId

    if guid then
        unitType, _, _, _, _, unitId = strsplit("-", guid)
        mobId = tonumber(unitId)
    end

    if inCombat and not guid then
        playerTargetMobId = nil
    elseif not inCombat and not guid then
        playerTargetMobId = nil

        ddidsToRender = {}
        ddidToDungeon = {}
        testNoteEnabled = false
    elseif not inCombat and guid and unitType == "Player" then
        playerTargetMobId = nil
    elseif not inCombat and guid and unitType ~= "Player" then
        ddidsToRender = {}
        ddidToDungeon = {}
        testNoteEnabled = false


        playerTargetMobId = mobId
        storeEncounteredMob(mobId)
    elseif inCombat and guid and unitType ~= "Player" then
        playerTargetMobId = tonumber(unitId)
    end

    DD:RenderOmniNote()
end

eventFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_DISABLED" then
        -- Reset encountered mobs at start of combat
        -- This caused nothing to render, skipping
        Log(">>> COMBAT BEGIN")
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- Reset encountered mobs at end of combat
        ddidsToRender = {}
        ddidToDungeon = {}
        testNoteEnabled = false
        ensureTarget()
        Log(">>> COMBAT END")
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local inCombat = UnitAffectingCombat("player")
        if not inCombat then
            return
        end

        local _, subEvent, _, sourceGUID, _, _, _, destGUID, destName = CombatLogGetCurrentEventInfo()

        -- Ignore deaths
        if subEvent == "UNIT_DIED" or subEvent == "UNIT_DESTROYED" then
            return
        end

        local sourceMobId = tonumber((sourceGUID):match("-(%d+)-%x+$"))
        local sourceGuidType = sourceGUID:match("^(.-)-")

        local destMobId = tonumber((destGUID):match("-(%d+)-%x+$"))
        local destGuidType = destGUID:match("^(.-)-")

        local isValidEvent = function(sourceMobId, sourceGuidType, destMobId, destGuidType)
            if sourceGuidType == "Player" and destGuidType == "Player" then
                return false
            end

            if IsFollowerNPC(sourceMobId) or IsFollowerNPC(destMobId) then
                return true
            end

            if sourceGuidType == "Player" or destGuidType == "Player" then
                return true
            end
        end

        if isValidEvent(sourceMobId, sourceGuidType, destMobId, destGuidType) then
            if sourceGuidType ~= "Player" then
                storeEncounteredMob(sourceMobId)
            end
            if destGuidType ~= "Player" then
                storeEncounteredMob(destMobId)
            end
            DD:RenderOmniNote()
        end
    elseif event == "PLAYER_TARGET_CHANGED" then
        ensureTarget()
    end
end)

function DD:RenderTestNote(ddid, dungeonName)
    testNoteEnabled = true
    table.insert(ddidsToRender, ddid)
    ddidToDungeon[ddid] = dungeonName
    DD:RenderOmniNote()
end
