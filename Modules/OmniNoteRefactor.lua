local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local omniAnchorFrame
local omniNoteFrame
local noteFrames = {}
local targetNoteCount = 10

local testNoteEnabled = false
local ddidsToRender = {}
local ddidToDungeon = {}

local playerTargetMobId

local testNoteOpacityEnabled = false


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

    return true
end

local function renderEncounteredMob(ddid, dungeonName)
    local noteStruct = DD:Dungeons_DDIDToNoteStruct(ddid, dungeonName)
    if not noteStruct then
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
        noteStruct = noteStruct,
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

    local note          = noteInfo.note
    local noteStruct    = noteInfo.noteStruct

    local state         = self.db.profile.settings.omniNote

    local noteCardLines = { noteCardFrame:GetChildren() }
    local width         = omniAnchorFrame:GetWidth()
    local previousFrame = noteCardFrame
    local totalHeight   = 0
    local linePadding   = state.linePadding * -1

    local withPadding   = function(padding)
        totalHeight = totalHeight + math.abs(padding)
        return padding
    end

    local function resolveText(lineName)
        if lineName == "mobName" then
            return noteStruct.noteName
        end

        if string.find(lineName, "Header") then
            return state[lineName]
        end

        return note[lineName]
    end

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


    local function updateLine(line)
        local frame = noteCardLines[line.index]

        local anchorPoint = "BOTTOM"
        if line.index == 1 then
            anchorPoint = "TOP"
        end

        if not line.displayed then
            FrameSetPoint(frame, "TOP", previousFrame, anchorPoint, 0, 0)
            FrameCollapse(frame)
            return
        end


        local textStyle = resolveTextStyle(line.name)

        local fontFlags
        if state.textOutline then
            fontFlags = "OUTLINE"
        end

        local alpha = 1.0
        local isTargeted = false
        for _, mob in ipairs(noteStruct.mobs) do
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

        if note.isBoss then
            alpha = 1.0
        end

        -- Update font string properties
        if textStyle then
            SafeSetFont(frame.fontString, textStyle.font, textStyle.fontSize, fontFlags)
            SafeSetTextColor(frame.fontString, textStyle.color.r, textStyle.color.g, textStyle.color.b, 1)
        end

        SafeSetAlpha(frame.fontString, alpha)
        SafeSetJustifyH(frame.fontString, state.textAlign)
        FrameWidth(frame.fontString, width)
        FrameSetPoint(frame.fontString, "LEFT", frame, "LEFT", line.indent, 0)

        -- Update frame properties
        FrameShow(frame)
        FrameSetPoint(frame, "TOP", previousFrame, anchorPoint, 0, withPadding(linePadding))
        FontText(frame, resolveText(line.name))
        FrameWidth(frame, width)

        local height = frame.fontString:GetStringHeight()
        FrameHeight(frame, height)
        totalHeight = totalHeight + height

        if testNoteOpacityEnabled then
            SafeSetAllPoints(frame.bg, frame)
            SafeSetColorTexture(frame.bg, 1, 0, 0, 0.5)
        end

        previousFrame = frame
    end

    local defaultIndent = 5
    local roleNoteIndent = defaultIndent + state.roleNoteIndent
    local roleHeaderIndent = defaultIndent + state.roleHeaderIndent

    -- Mob Name line
    updateLine({
        name = "mobName",
        index = 1,
        indent = defaultIndent,
        displayed = state.showNoteTitle,
    })

    -- Primary note line
    updateLine({
        name = "primaryNote",
        index = 2,
        indent = defaultIndent,
        displayed = note.primaryNote ~= "",
    })

    -- Tank header line
    local tankDisplayed = DD:ShouldDisplayRole(note.tankNote, "Tank")
    updateLine({
        name = "tankHeader",
        index = 3,
        indent = roleHeaderIndent,
        displayed = tankDisplayed,
    })

    -- Tank note line
    updateLine({
        name = "tankNote",
        index = 4,
        indent = roleNoteIndent,
        displayed = tankDisplayed,
    })

    -- Healer header line
    local healerDisplayed = DD:ShouldDisplayRole(note.healerNote, "Healer")
    updateLine({
        name = "healerHeader",
        index = 5,
        indent = roleHeaderIndent,
        displayed = healerDisplayed,
    })

    -- Healer note line
    updateLine({
        name = "healerNote",
        index = 6,
        indent = roleNoteIndent,
        displayed = healerDisplayed,
    })

    -- Damage header line
    local damageDisplayed = DD:ShouldDisplayRole(note.damageNote, "Damage")
    updateLine({
        name = "damageHeader",
        index = 7,
        indent = roleHeaderIndent,
        displayed = damageDisplayed,
    })

    -- Damage note line
    updateLine({
        name = "damageNote",
        index = 8,
        indent = roleNoteIndent,
        displayed = damageDisplayed,
    })


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

    if testNoteOpacityEnabled then
        SafeSetAllPoints(noteCardFrame.bg, noteCardFrame)
        SafeSetColorTexture(noteCardFrame.bg, 0, 0, 1, 0.5)

        SafeSetAllPoints(spacerFrame.bg, spacerFrame)
        SafeSetColorTexture(spacerFrame.bg, 0, 1, 0, 0.5)
    end

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

    -- Set opacity
    SafeSetAllPoints(omniNoteFrame.bg, omniNoteFrame)
    SafeSetColorTexture(omniNoteFrame.bg, 0, 0, 0, state.backgroundOpacity)
end

function DD:OmniNote_Init()
    omniAnchorFrame = DD:Movers_GetOmni()
    initNoteFrames()
end

DD:SubscribeToDBChange(function()
    DD:RenderOmniNote()
end)

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

function DD:ShouldDisplayRole(note, role)
    if note == "" then return false end

    local state = self.db.profile.settings.omniNote

    if state.roleDisplay == "All" then
        return true
    end

    if state.roleDisplay == "None" then
        return false
    end

    -- Handle state.roleDisplay == "Current"
    local specIndex = GetSpecialization()
    local specRole = GetSpecializationRole(specIndex)

    local normalizeRole = function(r)
        r = string.sub(r, 1, 1)
        return string.lower(r)
    end

    return normalizeRole(role) == normalizeRole(specRole)
end
