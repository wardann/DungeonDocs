local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local omniAnchorFrame

DD:SubscribeToDBChange(function()
    DD:RenderOmniNote()
end)

function DD:OmniNote_Init()
    omniAnchorFrame = DD:Movers_GetOmni()
end

local encounteredMobs = {}
local testNoteEnabled = false

local function storeEncounteredMob(mobId)
    if IsFollowerNPC(mobId) then return end

    -- Only store the mob if it's not already stored
    for _, v in ipairs(encounteredMobs) do
        if v == mobId then
            return
        end
    end

    table.insert(encounteredMobs, mobId)
end

local function renderEncounteredMob(mobId)
    mobId = tostring(mobId)

    local dungeonName
    if testNoteEnabled then
        dungeonName = DD:Dungeons_MobIdToDungeonName(mobId)
    else
        dungeonName = DD:Dungeons_GetCurrentDungeon()
    end

    if not dungeonName then
        return
    end

    local noteName = DD:Dungeons_MobIdToNoteName(mobId, dungeonName)
    if not noteName then
        return
    end

    local ddid = DD:Dungeons_MobIDToDDID(mobId, dungeonName)
    if not ddid then
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
        ddid = ddid,
        noteName = noteName,
        note = note,
    }
end

function DD:RenderTestNote(mobId)
    storeEncounteredMob(mobId)
    testNoteEnabled = true
    DD:RenderOmniNote()
end

local playerTargetMobId

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")

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
        encounteredMobs = {}
        testNoteEnabled = false
    elseif not inCombat and guid and unitType == "Player" then
        playerTargetMobId = nil
    elseif not inCombat and guid and unitType ~= "Player" then
        encounteredMobs = {}
        testNoteEnabled = false


        playerTargetMobId = mobId
        storeEncounteredMob(mobId)
    elseif inCombat and guid and unitType ~= "Player" then
        playerTargetMobId = tonumber(unitId)
    end

    DD:RenderOmniNote()
end

frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_DISABLED" then
        -- Reset encountered mobs at start of combat
        -- This caused nothing to render, skipping
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- Reset encountered mobs at end of combat
        encounteredMobs = {}
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


local debounceTimer = nil -- Timer for debouncing

function DD:RenderOmniNoteWithDebounce()
    -- If a timer is already active, do nothing
    if debounceTimer then return end

    -- Set up the timer
    debounceTimer = C_Timer.NewTimer(0.25, function()
        -- Call the actual function
        DD:RenderOmniNote()

        -- Clear the timer after the function is executed
        debounceTimer = nil
    end)
end

local cardContainer

function DD:RenderOmniNote()
    local state = self.db.profile.settings.omniNote
    local internal = self.db.profile.internal

    if cardContainer then
        cardContainer:Hide()
        cardContainer = nil
    end

    -- Create the card container
    cardContainer = CreateFrame("Frame", "CardContainer", omniAnchorFrame)
    cardContainer:SetWidth(omniAnchorFrame:GetWidth()) -- Match the width of the anchor frame

    local lastNoteCard
    local totalHeight = 0

    local recordHeight = function(frame)
        totalHeight = totalHeight + frame:GetHeight()
    end

    local renderedNoteDDIDs = {}

    for i, mobId in ipairs(encounteredMobs) do
        -- Build the note card

        local mob = renderEncounteredMob(mobId)
        if mob and not IsInArray(renderedNoteDDIDs, mob.ddid) then
            local isTargeted = mobId == playerTargetMobId
            local isBoss = DD:Dungeons_IsBossInCurrentDungeon(mobId)
            local noteCard = BuildNoteCard(i, mob.noteName, mob.note, state, isTargeted, isBoss)
            noteCard:SetParent(cardContainer)
            noteCard:Show()

            local spacer = CreateFrame("Frame", "Spacer" .. i, cardContainer)
            spacer:SetWidth(cardContainer:GetWidth())
            spacer:SetHeight(state.noteSpacing)
            spacer:Show()
            spacer.bg = spacer:CreateTexture(nil, "BACKGROUND")
            spacer.bg:SetAllPoints(spacer)
            spacer.bg:SetColorTexture(0, 0, 0, state.backgroundOpacity)

            -- Position the note card
            if state.noteGrowDirection == "UP" then
                if i == 1 then
                    noteCard:SetPoint("BOTTOM", cardContainer, "BOTTOM", 0, 0)
                else
                    spacer:SetPoint("BOTTOM", lastNoteCard, "TOP", 0, 0)
                    noteCard:SetPoint("BOTTOM", spacer, "TOP", 0, 0)
                end
            else
                if i == 1 then
                    noteCard:SetPoint("TOP", cardContainer, "TOP", 0, 0)
                else
                    spacer:SetPoint("TOP", lastNoteCard, "BOTTOM", 0, 0)
                    noteCard:SetPoint("TOP", spacer, "BOTTOM", 0, 0)
                end
            end

            recordHeight(noteCard)
            lastNoteCard = noteCard
            table.insert(renderedNoteDDIDs, mob.ddid)
        end
    end

    -- Set the container height to fit all cards
    cardContainer:SetHeight(totalHeight)

    -- Here we account for two things:
    --  1) if the cards should be growing up or down
    --  2) if the movers are turned on, then the card container should be positioned
    --     adjacent to the anchor frame. else, it's positioned inside

    if state.noteGrowDirection == "UP" then
        if internal.movers.omniNote then
            cardContainer:SetPoint("BOTTOM", omniAnchorFrame, "TOP", 0, 0)
        else
            cardContainer:SetPoint("BOTTOM", omniAnchorFrame, "BOTTOM", 0, 0)
        end
    else
        if internal.movers.omniNote then
            cardContainer:SetPoint("TOP", omniAnchorFrame, "BOTTOM", 0, 0)
        else
            cardContainer:SetPoint("TOP", omniAnchorFrame, "TOP", 0, 0)
        end
    end

    cardContainer:Show()
end

function BuildNoteCard(noteIndex, noteName, note, state, isTargeted, isBoss)
    -- Create the main card frame
    local card = CreateFrame("Frame", "CardFrame" .. noteIndex, omniAnchorFrame)

    if note.primaryNote == "" and note.tankNote == "" and note.healerNote == "" and note.damageNote == "" then
        card:SetSize(0, 0)
        return card
    end

    card:SetWidth(state.noteWidth, 30)
    card.bg = card:CreateTexture(nil, "BACKGROUND")
    card.bg:SetAllPoints(card)
    card.bg:SetColorTexture(0, 0, 0, state.backgroundOpacity)
    card:Show()


    local previousFrame = card
    local totalHeight = 0
    local recordHeight = function(frame)
        totalHeight = totalHeight + frame:GetHeight()
        previousFrame = frame
    end

    local withPadding = function(padding)
        totalHeight = totalHeight + math.abs(padding)
        return padding
    end

    local index = 0
    local getIndex = function()
        index = index + 1
        return index
    end

    local defaultIndent = 5
    local linePadding = state.linePadding * -1

    if state.showNoteTitle then
        local mobNameFrame = BuildNoteCardLine(
            "MobName" .. noteIndex,
            previousFrame,
            noteName,
            state,
            ResolveTextStyle(state, "mobName", "defaultText"),
            getIndex(),
            defaultIndent,
            withPadding(linePadding),
            isTargeted,
            isBoss
        )
        recordHeight(mobNameFrame)
    end


    if note.primaryNote ~= "" then
        local primaryNoteFrame = BuildNoteCardLine(
            "PrimaryNote" .. noteIndex,
            previousFrame,
            note.primaryNote,
            state,
            ResolveTextStyle(state, "primaryNote", "defaultText"),
            getIndex(),
            defaultIndent,
            withPadding(linePadding),
            isTargeted,
            isBoss
        )
        recordHeight(primaryNoteFrame)
    end

    if DD:ShouldDisplayRole(note.tankNote, "Tank") then
        if state.displayRoleHeader then
            local tankHeaderFrame = BuildNoteCardLine(
                "TankHeader" .. noteIndex,
                previousFrame,
                state.tankHeader,
                state,
                ResolveTextStyle(state, "tankHeader", "defaultRoleHeader"),
                getIndex(),
                state.roleHeaderIndent + defaultIndent,
                withPadding(linePadding),
                isTargeted,
                isBoss
            )
            recordHeight(tankHeaderFrame)
        end


        local tankNoteFrame = BuildNoteCardLine(
            "TankNote" .. noteIndex,
            previousFrame,
            note.tankNote,
            state,
            ResolveTextStyle(state, "tankNote", "defaultText"),
            getIndex(),
            state.roleNoteIndent + defaultIndent,
            withPadding(linePadding),
            isTargeted,
            isBoss
        )
        recordHeight(tankNoteFrame)
    end

    if DD:ShouldDisplayRole(note.healerNote, "Healer") then
        if state.displayRoleHeader then
            local healerHeaderFrame = BuildNoteCardLine(
                "HealerHeader" .. noteIndex,
                previousFrame,
                state.healerHeader,
                state,
                ResolveTextStyle(state, "healerHeader", "defaultRoleHeader"),
                getIndex(),
                state.roleHeaderIndent + defaultIndent,
                withPadding(linePadding),
                isTargeted,
                isBoss
            )
            recordHeight(healerHeaderFrame)
        end


        local healerNoteFrame = BuildNoteCardLine(
            "HealerNote" .. noteIndex,
            previousFrame,
            note.healerNote,
            state,
            ResolveTextStyle(state, "healerNote", "defaultText"),
            getIndex(),
            state.roleNoteIndent + defaultIndent,
            withPadding(linePadding),
            isTargeted,
            isBoss
        )
        recordHeight(healerNoteFrame)
    end

    if DD:ShouldDisplayRole(note.damageNote, "Damage") then
        if state.displayRoleHeader then
            local damageHeaderFrame = BuildNoteCardLine(
                "DamageHeader" .. noteIndex,
                previousFrame,
                state.damageHeader,
                state,
                ResolveTextStyle(state, "damageHeader", "defaultRoleHeader"),
                getIndex(),
                state.roleHeaderIndent + defaultIndent,
                withPadding(linePadding),
                isTargeted,
                isBoss
            )
            recordHeight(damageHeaderFrame)
        end


        local damageNoteFrame = BuildNoteCardLine(
            "DamageNote" .. noteIndex,
            previousFrame,
            note.damageNote,
            state,
            ResolveTextStyle(state, "damageNote", "defaultText"),
            getIndex(),
            state.roleNoteIndent + defaultIndent,
            withPadding(linePadding),
            isTargeted,
            isBoss
        )
        recordHeight(damageNoteFrame)
    end

    card:SetHeight(totalHeight)

    return card
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

function ResolveTextStyle(state, targetKey, defaultKey)
    local target = state.style[targetKey]
    local default = state.style[defaultKey]

    local textStyle = target.text
    if target.useDefaultTextStyle or target.useDefaultRoleHeaderStyle then
        textStyle = default
    end
    return textStyle
end

function BuildNoteCardLine(frameName, parentFrame, noteText, state, textStyle, index, indent, linePadding, isTargeted,
                           isBoss)
    local fontFlags
    if state.textOutline then
        fontFlags = "OUTLINE"
    end

    local anchorPoint = "BOTTOM"
    if index == 1 then
        anchorPoint = "TOP"
    end

    local alpha = 1.0
    if not isTargeted then
        alpha = state.untargetedNoteOpacity
    end

    if testNoteEnabled then
        alpha = 1.0
    end

    if isBoss then
        alpha = 1.0
    end

    local lineFrame = CreateFrame("Frame", frameName, parentFrame)
    lineFrame:SetPoint("TOP", parentFrame, anchorPoint, 0, linePadding)
    lineFrame:SetWidth(parentFrame:GetWidth())

    local line = lineFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    line:SetFont(textStyle.font, textStyle.fontSize, fontFlags)
    line:SetTextColor(textStyle.color.r, textStyle.color.g, textStyle.color.b, 1)
    line:SetPoint("LEFT", lineFrame, "LEFT", indent, 0)
    line:SetWidth(lineFrame:GetWidth() - indent)
    line:SetWordWrap(true)
    line:SetText(noteText)
    line:SetAlpha(alpha)
    line:SetJustifyH(state.textAlign)
    lineFrame:SetHeight(line:GetStringHeight())

    return lineFrame
end
