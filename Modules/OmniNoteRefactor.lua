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
    omniNoteFrame:SetHeight(500)

    for i = 1, targetNoteCount do
        -- Init note card
        local noteCardName = buildNoteCardName(i)
        local noteCardFrame = initFrame(omniNoteFrame, true)
        noteCardFrame:SetHeight(200)

        -- Init note card lines
        initFrame(noteCardFrame, true, true) -- MobName
        initFrame(noteCardFrame, true, true) -- PrimaryNote
        initFrame(noteCardFrame, true, true) -- TankHeader
        initFrame(noteCardFrame, true, true) -- TankNote
        initFrame(noteCardFrame, true, true) -- HealerHeader
        initFrame(noteCardFrame, true, true) -- HealerNote
        initFrame(noteCardFrame, true, true) -- DamageHeader
        initFrame(noteCardFrame, true, true) -- DamageNote

        noteFrames[noteCardName] = noteCardFrame

        -- Init spacer
        local spacerName = buildSpacerName(i)
        local spacerFrame = initFrame(omniNoteFrame, true)
        noteFrames[spacerName] = spacerFrame

        Log(">>> initNoteFrames", i)
    end
end

local function storeEncounteredMob(mobId)
    Log(">>> storeEncounteredMob", mobId)
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

    Log(">>> storeEncounteredMob ddid", ddid)
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
    Log("Start RenderNote", index)
    local noteCardFrame = noteFrames[buildNoteCardName(index)]
    local spacerFrame = noteFrames[buildSpacerName(index)]

    local ddid = ddidsToRender[index]
    if not ddid then
        FrameHide(noteCardFrame)
        FrameHeight(noteCardFrame, 0)
        FrameHide(spacerFrame)
        FrameHeight(spacerFrame, 0)
        return spacerFrame
    end

    Log(">>> ddid", ddid)

    local dungeonName = ddidToDungeon[ddid]
    local noteInfo = renderEncounteredMob(ddid, dungeonName)

    if not noteInfo then
        FrameHide(noteCardFrame)
        FrameHeight(noteCardFrame, 0)
        FrameHide(spacerFrame)
        FrameHeight(spacerFrame, 0)
        return spacerFrame
    end

    Log(">>> noteName", noteInfo.noteName)
    Log(">>> noteCardFrame", noteCardFrame)
    Log(">>> noteCardName", buildNoteCardName(index))


    local state         = self.db.profile.settings.omniNote
    local internal      = self.db.profile.internal

    local width         = omniAnchorFrame:GetWidth()
    local noteCardLines = { noteCardFrame:GetChildren() }
    local previousFrame = noteCardFrame
    local totalHeight   = 0

    local function updateLine(lineName, lineIndex)
        local frame = noteCardLines[lineIndex]

        local anchorPoint = "BOTTOM"
        if lineIndex == 1 then
            anchorPoint = "TOP"
        end
        
        FrameShow(frame)
        FrameSetPoint(frame, "TOP", previousFrame, anchorPoint, 0, 0) -- TODO add line padding
        FontText(frame, lineName)

        local height = frame.fontString:GetStringHeight()
        FrameHeight(frame, height)
        totalHeight = totalHeight + height

        FrameWidth(frame, width)
        frame.fontString:SetPoint("LEFT", frame, "LEFT", 0, 0) -- TODO fix 


        frame.bg:SetColorTexture(1, 0, 0, 0.5) -- Green with 50% opacity
        

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
    FrameWidth(spacerFrame, width)

    -- TODO: revisit this logic
    if state.noteGrowDirection == "UP" then
        if index == 1 then
            Log(">>> hello world")
            noteCardFrame:SetPoint("BOTTOM", anchor, "BOTTOM", 0, 0)
        else
            spacerFrame:SetPoint("BOTTOM", anchor, "TOP", 0, 0)
            noteCardFrame:SetPoint("BOTTOM", spacerFrame, "TOP", 0, 0)
        end
    else
        if index == 1 then
            noteCardFrame:SetPoint("TOP", anchor, "TOP", 0, 0)
        else
            spacerFrame:SetPoint("TOP", anchor, "BOTTOM", 0, 0)
            noteCardFrame:SetPoint("TOP", spacerFrame, "BOTTOM", 0, 0)
        end
    end
    noteCardFrame.bg:SetAllPoints(noteCardFrame)   -- Make the texture cover the entire frame
    noteCardFrame.bg:SetColorTexture(0, 0, 1, 0.5) -- Green with 50% opacity

    Log("End RenderNote", index)
    return spacerFrame
end

function DD:RenderOmniNote()
    local anchor = omniNoteFrame
    for i = 1, targetNoteCount do
        anchor = DD:RenderNote(i, anchor)
    end

    -- omniNoteFrame.bg:SetAllPoints(omniNoteFrame) -- Make the texture cover the entire frame
    -- omniNoteFrame.bg:SetColorTexture(0, 1, 0, 0.5) -- Green with 50% opacity

    local state    = self.db.profile.settings.omniNote
    local internal = self.db.profile.internal

    if state.noteGrowDirection == "UP" then
        if internal.movers.omniNote then
            omniNoteFrame:SetPoint("BOTTOM", omniAnchorFrame, "TOP", 0, 0)
        else
            omniNoteFrame:SetPoint("BOTTOM", omniAnchorFrame, "BOTTOM", 0, 0)
        end
    else
        if internal.movers.omniNote then
            omniNoteFrame:SetPoint("TOP", omniAnchorFrame, "BOTTOM", 0, 0)
        else
            omniNoteFrame:SetPoint("TOP", omniAnchorFrame, "TOP", 0, 0)
        end
    end
end

function DD:OmniNote_Init()
    Log(">>> init note frames BEGIN!")
    omniAnchorFrame = DD:Movers_GetOmni()
    initNoteFrames()
    Log(">>> init note frames END!")
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
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- Reset encountered mobs at end of combat
        ddidsToRender = {}
        ddidToDungeon = {}
        testNoteEnabled = false
        ensureTarget()
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
            storeEncounteredMob(sourceMobId)
            DD:RenderOmniNoteWithDebounce()
        else
        end
    elseif event == "PLAYER_TARGET_CHANGED" then
        ensureTarget()
    end
end)
