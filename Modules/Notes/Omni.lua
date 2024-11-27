local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local omniAnchorFrame

DD:SubscribeToDBChange(function()
    DD:RenderOmniNote()
end)

function DD:InitOmniNote()
    omniAnchorFrame = DD:Movers_GetOmni()
end

local encounteredMobs = {}
local testNoteEnabled = false

local function storeEncounteredMob(mobId)
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

    local note = DD:DB_DeriveFullNote(dungeonName, tonumber(mobId))
    if not note then
        return
    end

    return {
        id = mobId,
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

frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_DISABLED" then
        encounteredMobs = {} -- Reset encountered mobs at start of combat
        testNoteEnabled = false
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- this event means the player has left combat
   elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local inCombat = UnitAffectingCombat("player")
        if not inCombat then
            return
        end

        local _, subEvent, _, sourceGUID, _, _, _, destGUID, destName = CombatLogGetCurrentEventInfo()

        if subEvent == "UNIT_DIED" or subEvent == "UNIT_DESTROYED" then return end -- Ignore deaths

        local sourceMobId = tonumber((sourceGUID):match("-(%d+)-%x+$"))
        local sourceGuidType = sourceGUID:match("^(.-)-")

        local destMobId = tonumber((destGUID):match("-(%d+)-%x+$"))
        local destGuidType = destGUID:match("^(.-)-")

        -- Exclude players, check both the source and dest GUIDs of the event
        if sourceMobId and sourceGuidType ~= "Player" then
            storeEncounteredMob(sourceMobId)
            DD:RenderOmniNote()
        end
        if destMobId and destGuidType ~= "Player" then
            storeEncounteredMob(destMobId)
            DD:RenderOmniNote()
        end

    elseif event == "PLAYER_TARGET_CHANGED" then
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
end)

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

    for i, mobId in ipairs(encounteredMobs) do
        -- Build the note card
        local mob = renderEncounteredMob(mobId)
        if mob then
            local isTargeted = mobId == playerTargetMobId
            local noteCard = BuildNoteCard(i, mob.noteName, mob.note, state, isTargeted)
            noteCard:SetParent(cardContainer)
            noteCard:Show()

            -- Position the note card
            if state.noteGrowDirection == "UP" then
                if i == 1 then
                    noteCard:SetPoint("BOTTOM", cardContainer, "BOTTOM", 0, 0)
                else
                    noteCard:SetPoint("BOTTOM", lastNoteCard, "TOP", 0, 0)
                end
            else
                if i == 1 then
                    noteCard:SetPoint("TOP", cardContainer, "TOP", 0, 0)
                else
                    noteCard:SetPoint("TOP", lastNoteCard, "BOTTOM", 0, 0)
                end
            end

            recordHeight(noteCard)
            lastNoteCard = noteCard

            if i < #encounteredMobs and noteCard:GetHeight() > 0 then
                local spacer = CreateFrame("Frame", "Spacer" .. i, cardContainer)
                spacer:SetWidth(cardContainer:GetWidth())
                spacer:SetHeight(state.noteSpacing)
                spacer:Show()
                spacer.bg = spacer:CreateTexture(nil, "BACKGROUND")
                spacer.bg:SetAllPoints(spacer)
                spacer.bg:SetColorTexture(0, 0, 0, state.backgroundOpacity)

                if state.noteGrowDirection == "UP" then
                    spacer:SetPoint("BOTTOM", lastNoteCard, "TOP", 0, 0)
                else
                    spacer:SetPoint("TOP", lastNoteCard, "BOTTOM", 0, 0)
                end

                recordHeight(spacer)
                lastNoteCard = spacer
            end
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

function BuildNoteCard(noteIndex, noteName, note, state, isTargeted)
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

    if state.showMobName then
        local mobNameFrame = BuildNoteCardLine(
            "MobName" .. noteIndex,
            previousFrame,
            noteName,
            state,
            ResolveTextStyle(state, "mobName", "defaultText"),
            getIndex(),
            defaultIndent,
            withPadding(linePadding),
            isTargeted
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
            isTargeted
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
                state.roleHeaderIndent,
                withPadding(linePadding),
                isTargeted
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
            state.roleNoteIndent,
            withPadding(linePadding),
            isTargeted
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
                state.roleHeaderIndent,
                withPadding(linePadding),
                isTargeted
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
            state.roleNoteIndent,
            withPadding(linePadding),
            isTargeted
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
                state.roleHeaderIndent,
                withPadding(linePadding),
                isTargeted
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
            state.roleNoteIndent,
            withPadding(linePadding),
            isTargeted
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

function BuildNoteCardLine(frameName, parentFrame, noteText, state, textStyle, index, indent, linePadding, isTargeted)
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
