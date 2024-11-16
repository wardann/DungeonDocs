local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local omniAnchorFrame

local omniAnchorFrame2

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
local textFrames2 = {}

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

    RenderOmniNote2()
end

function RenderOmniNote2()
    for _, textFrame in ipairs(textFrames2) do
        textFrame:Hide()
        textFrame = nil
    end

    for i, encounteredMob in ipairs(encounteredMobs) do
        -- local text = buildNoteText(encounteredMob)
        -- local opacity = 0.75
        -- if tostring(encounteredMob.id) == tostring(playerTargetMobId) then
        --     opacity = 1.00
        -- end

        BuildMobCard(i, encounteredMob)
    end
end

function BuildMobCard(index, encounteredMob)
    -- Create the main card frame
    local card = CreateFrame("Frame", "CardFrame" .. index, omniAnchorFrame2)
    local e = encounteredMob

    if e.note.primaryNote == "" and e.note.tankNote == "" and e.note.healerNote == "" and e.note.damageNote then
        card:SetSize(0, 0)
        return
    end

    card:SetSize(omniAnchorFrame2:GetWidth(), 30) -- Set a base width and height
    card.bg = card:CreateTexture(nil, "BACKGROUND")
    card.bg:SetAllPoints(card)                    -- Ensure background fills the entire card
    card.bg:SetColorTexture(0, 0, 0, 0.5)         -- Semi-transparent for visibility

    -- Ensure the card is visible
    card:Show()

    -- Position the card
    if index == 1 then
        card:SetPoint("CENTER", omniAnchorFrame2, "TOP", startX, omniAnchorFrame2:GetHeight())
    else
        local previousFrame = textFrames2[index - 1]
        card:SetPoint("BOTTOM", previousFrame, "TOP", 0, 5) -- 5-pixel gap between cards
    end

    -- Create the first line frame and font string
    local nameFrame = CreateFrame("Frame", "Line1" .. index, card)
    nameFrame:SetPoint("TOP", card, "TOP", 0, -5) -- Offset from top of the card
    nameFrame:SetWidth(card:GetWidth())

    local nameLine = nameFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    local fontPath, _, fontFlags = nameLine:GetFont()  -- Retrieve the current font path and flags
    nameLine:SetFont(fontPath, 20, fontFlags)          -- Set font with new size (e.g., 14)
    nameLine:SetPoint("LEFT", nameFrame, "LEFT", 5, 0) -- Align to left of lineFrame with padding
    nameLine:SetWidth(nameFrame:GetWidth() - 10)       -- Account for padding
    nameLine:SetWordWrap(true)
    nameLine:SetText(encounteredMob.noteName)          -- Set the text to display
    nameLine:SetAlpha(1.0)
    nameLine:SetJustifyH("LEFT")
    nameFrame:SetHeight(nameLine:GetStringHeight())


    -- Create the second line frame and font string
    local primaryNoteFrame = CreateFrame("Frame", "PrimaryNoteFrame" .. index, card)
    primaryNoteFrame:SetPoint("TOP", nameFrame, "BOTTOM", 0, -5) -- Position below the first line
    primaryNoteFrame:SetWidth(card:GetWidth())

    local primaryNote = primaryNoteFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    primaryNote:SetPoint("LEFT", lineFrame2, "LEFT", 5, 0) -- Align to left with padding
    primaryNote:SetWidth(lineFrame2:GetWidth() - 10)       -- Account for padding
    primaryNote:SetWordWrap(true)
    primaryNote:SetText("Some other text")                 -- Placeholder text for debugging
    primaryNote:SetAlpha(1.0)
    primaryNote:SetJustifyH("LEFT")
    primaryNoteFrame:SetHeight(primaryNote:GetStringHeight())


    -- Store the card in the textFrames2 table for future reference
    textFrames2[index] = card

    -- Set the total height of the card based on content
    card:SetHeight(lineFrame:GetHeight() + lineFrame2:GetHeight() + 15) -- Add padding as needed

    -- Debugging print statements
    -- print(">>> hello world, build mob card!")
    -- print("Card frame size:", card:GetWidth(), card:GetHeight())
    -- print("Encountered mob name:", encounteredMob.name)
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

    -- Create the frame
    omniAnchorFrame2 = CreateFrame("Frame", "TextPanel", UIParent)
    omniAnchorFrame2:SetSize(300, 25)                       -- Set the size of the panel
    omniAnchorFrame2:SetPoint("CENTER", UIParent, "CENTER") -- Center it on the screen
    omniAnchorFrame2:EnableMouse(true)                      -- Enable mouse interactions if needed
    omniAnchorFrame2:SetMovable(true)                       -- Allow the frame to be movable if needed

    -- Create a background for the frame
    omniAnchorFrame2.bg = omniAnchorFrame2:CreateTexture(nil, "BACKGROUND")
    omniAnchorFrame2.bg:SetAllPoints(omniAnchorFrame2)
    omniAnchorFrame2.bg:SetColorTexture(0, 0, 0, 0.5) -- 50% transparent gray

    -- Create a font string for the title text
    omniAnchorFrame2.text = omniAnchorFrame2:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    omniAnchorFrame2.text:SetPoint("CENTER")
    omniAnchorFrame2.text:SetText("Omni Note Anchor 2")

    omniAnchorFrame2:RegisterForDrag("LeftButton") -- Enable dragging
    omniAnchorFrame2:SetScript("OnDragStart", function(self) self:StartMoving() end)
    omniAnchorFrame2:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)
end
