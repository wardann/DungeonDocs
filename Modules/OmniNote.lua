local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local omniAnchorFrame

local frame = CreateFrame("Frame")

frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")

-- Gold Color: Hex code for gold color in WoW (usually a rich yellow)
local function wrapInGold(text)
    return "|cFFFFD700" .. text .. "|r"
end

-- Off-White Color: A soft white/gray color
local function wrapInOffWhite(text)
    return "|cFFF5F5DC" .. text .. "|r"
end

local encounteredMobs = {}
local function setEncounteredMob(mobId)
    mobId = tostring(mobId)
    local noteName = DD:Dungeons_MobIdToNoteName(mobId)
    if not noteName then
        return
    end

    local dungeonName = DD:Dungeons_GetCurrentDungeon()
    if not dungeonName then
        return
    end


    local note = DD:DB_DeriveFullNote(dungeonName, tonumber(mobId))
    if not note then
        return
    end

    for _, encounteredMob in ipairs(encounteredMobs) do
        if encounteredMob.noteName == noteName then
            encounteredMob.note = note
            return
        end
    end

    table.insert(encounteredMobs, {
        id = mobId,
        noteName = noteName,
        note = note,
    })
end

local playerTargetMobId

frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_DISABLED" then
        encounteredMobs = {} -- Reset encountered mobs at start of combat
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- this event means the player has left combat
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, subEvent, _, _, _, _, _, destGUID, destName = CombatLogGetCurrentEventInfo()

        if subEvent == "UNIT_DIED" or subEvent == "UNIT_DESTROYED" then return end -- Ignore deaths

        -- Check if destination is an NPC we are encountering in combat
        if subEvent == "SPELL_DAMAGE" or subEvent == "SWING_DAMAGE" then
            local mobId = tonumber((destGUID):match("-(%d+)-%x+$"))
            setEncounteredMob(mobId)
            RenderOmniNote()
        end
    elseif event == "PLAYER_TARGET_CHANGED" then
        local inCombat = UnitAffectingCombat("player")
        local guid = UnitGUID("target")
        local unitType, unitId

        if guid then
            unitType, _, _, _, _, unitId = strsplit("-", guid)
        end

        if inCombat and not guid then
            playerTargetMobId = nil
        elseif not inCombat and not guid then
            playerTargetMobId = nil
            encounteredMobs = {}
        elseif not inCombat and guid and unitType == "Player" then
            playerTargetMobId = nil
        elseif not inCombat and guid and unitType ~= "Player" then
            encounteredMobs = {}
            playerTargetMobId = tonumber(unitId)
            setEncounteredMob(tonumber(unitId))
        elseif inCombat and guid and unitType ~= "Player" then
            playerTargetMobId = tonumber(unitId)
        end

        RenderOmniNote()
    end
end)


-- Define a table to hold the frames for easy access
local textFrames = {}

-- Starting position for the first frame
local startX = 0
local startY
local maxWidth = 200 -- Set a maximum width for the text frame

-- Function to create and position each text frame dynamically
local function ensureTextFrame(index, text, alpha)
    -- Create a new frame
    local frame = CreateFrame("Frame", "TextFrame" .. index, UIParent)

    frame:SetSize(maxWidth, 30) -- Set the frame width and base height

    -- Determine the position for the current frame based on the previous frame
    if index == 1 then
        frame:SetPoint("CENTER", omniAnchorFrame, "TOP", startX, startY)
    else
        -- Position this frame above the previous frame
        local previousFrame = textFrames[index - 1]
        local previousHeight = previousFrame:GetHeight()
        frame:SetPoint("BOTTOM", previousFrame, "TOP", 0, 5) -- 5 is the gap between frames
    end

    -- Create a FontString within the frame
    local fontString = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fontString:SetPoint("CENTER")
    fontString:SetWidth(omniAnchorFrame:GetWidth()) -- Set maximum width for text wrapping
    fontString:SetWordWrap(true)                    -- Enable word wrap
    fontString:SetText(text)                        -- Set the text
    fontString:SetAlpha(alpha)                      -- Set the opacity

    fontString:SetJustifyH("LEFT")                  -- Horizontal alignment (options: "LEFT", "CENTER", "RIGHT")

    -- Adjust the frame height based on the wrapped FontString content
    frame:SetHeight(fontString:GetStringHeight())

    -- Store the frame in our table for future reference
    textFrames[index] = frame
end

-- Split function: Splits a string by a given delimiter
function Split(input, delimiter)
    local result = {}
    for match in (input .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end

function Join(parts, separator)
    return table.concat(parts, separator)
end

local function buildNoteText(encounteredMob)
    local prepNote = function(note)
        note = "  " .. note
        local parts = Split(note, "\n")
        return Join(parts, "  \n")
    end

    -- local prepRoleNote = function(roleNote)
    --     roleNote = "    " .. roleNote
    --     local parts = Split(roleNote, "\n")
    --     return Join(parts, "    \n")
    -- end

    local e = encounteredMob
    local text = wrapInGold(e.noteName) .. "\n"
    text = text .. prepNote(wrapInOffWhite(e.note.primaryNote)) .. "\n"

    if e.note.tankNote ~= "" then
        text = text .. prepNote(wrapInGold("[Tank]\n"))
        text = text .. prepNote(wrapInOffWhite(e.note.tankNote)) .. "\n"
    end

    if e.note.healerNote ~= "" then
        text = text .. prepNote(wrapInGold("[Healer]\n"))
        text = text .. prepNote(wrapInOffWhite(e.note.healerNote)) .. "\n"
    end

    if e.note.damageNote ~= "" then
        text = text .. prepNote(wrapInGold("[Damage]\n"))
        text = text .. prepNote(wrapInOffWhite(e.note.damageNote)) .. "\n"
    end


    return text
end

function RenderOmniNote()
    for _, textFrame in ipairs(textFrames) do
        textFrame:Hide()
        textFrame = nil
    end

    for i, encounteredMob in ipairs(encounteredMobs) do
        local text = buildNoteText(encounteredMob)
        local opacity = 0.75
        if tostring(encounteredMob.id) == tostring(playerTargetMobId) then
            opacity = 1.00
        end

        ensureTextFrame(i, text, opacity)
    end
end

local function createTextFrames(index, text, alpha)
    -- Create 4 text frames with different texts and opacities, stacking upwards
    createTextFrame(1, "This is a longer line of text that should wrap if it exceeds the maximum width.", 1.0)
    createTextFrame(2, "Another line of text with wrapping enabled to fit within the max width.", 0.75)
    createTextFrame(3, "Text that wraps when it reaches the frame's width.", 0.5)
    createTextFrame(4, "Final line with wrapping and opacity applied.", 0.25)
end


-- -- Register the /temp command
-- SLASH_TEMP1 = "/temp"
-- SlashCmdList["TEMP"] = function()
--     createTextFrames()
-- end



function DD:InitOmniNote()
    -- Create the frame
    omniAnchorFrame = CreateFrame("Frame", "TextPanel", UIParent)
    omniAnchorFrame:SetSize(300, 25)                       -- Set the size of the panel
    omniAnchorFrame:SetPoint("CENTER", UIParent, "CENTER") -- Center it on the screen
    omniAnchorFrame:EnableMouse(true)                      -- Enable mouse interactions if needed
    omniAnchorFrame:SetMovable(true)                       -- Allow the frame to be movable if needed

    -- Create a background for the frame
    omniAnchorFrame.bg = omniAnchorFrame:CreateTexture(nil, "BACKGROUND")
    omniAnchorFrame.bg:SetAllPoints(omniAnchorFrame)
    omniAnchorFrame.bg:SetColorTexture(0, 0, 0, 0.5) -- 50% transparent gray

    -- Create a font string for the title text
    omniAnchorFrame.text = omniAnchorFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    omniAnchorFrame.text:SetPoint("CENTER")
    omniAnchorFrame.text:SetText("Omni Note Anchor")

    omniAnchorFrame:RegisterForDrag("LeftButton") -- Enable dragging
    omniAnchorFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    omniAnchorFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    startY = omniAnchorFrame:GetHeight()
end
