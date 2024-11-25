local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local omniAnchorFrame

local omniAnchorFrame2


-- Gold Color: Hex code for gold color in WoW (usually a rich yellow)
local function wrapInGold(text)
    return "|cFFFFD700" .. text .. "|r"
end

-- Off-White Color: A soft white/gray color
local function wrapInOffWhite(text)
    return "|cFFF5F5DC" .. text .. "|r"
end





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

-- local function buildNoteText(encounteredMob)
--     local prepNote = function(note)
--         note = "  " .. note
--         local parts = Split(note, "\n")
--         return Join(parts, "  \n")
--     end

--     -- local prepRoleNote = function(roleNote)
--     --     roleNote = "    " .. roleNote
--     --     local parts = Split(roleNote, "\n")
--     --     return Join(parts, "    \n")
--     -- end

--     local e = encounteredMob
--     local text = wrapInGold(e.noteName) .. "\n"
--     text = text .. prepNote(wrapInOffWhite(e.note.primaryNote)) .. "\n"

--     if e.note.tankNote ~= "" then
--         text = text .. prepNote(wrapInGold("[Tank]\n"))
--         text = text .. prepNote(wrapInOffWhite(e.note.tankNote)) .. "\n"
--     end

--     if e.note.healerNote ~= "" then
--         text = text .. prepNote(wrapInGold("[Healer]\n"))
--         text = text .. prepNote(wrapInOffWhite(e.note.healerNote)) .. "\n"
--     end

--     if e.note.damageNote ~= "" then
--         text = text .. prepNote(wrapInGold("[Damage]\n"))
--         text = text .. prepNote(wrapInOffWhite(e.note.damageNote)) .. "\n"
--     end


--     return text
-- end

-- function RenderOmniNote()
--     for _, textFrame in ipairs(textFrames) do
--         textFrame:Hide()
--         textFrame = nil
--     end

--     for i, encounteredMob in ipairs(encounteredMobs) do
--         local text = buildNoteText(encounteredMob)
--         local opacity = 0.75
--         if tostring(encounteredMob.id) == tostring(playerTargetMobId) then
--             opacity = 1.00
--         end

--         ensureTextFrame(i, text, opacity)
--     end

--     RenderOmniNote2()
-- end


function BuildMobCard(index, encounteredMob)
    -- Create the main card frame
    local card = CreateFrame("Frame", "CardFrame" .. index, omniAnchorFrame2)
    local e = encounteredMob

    if e.note.primaryNote == "" and e.note.tankNote == "" and e.note.healerNote == "" and e.note.damageNote then
        card:SetSize(0, 0)
        return card
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
    primaryNote:SetPoint("LEFT", primaryNoteFrame, "LEFT", 5, 0) -- Align to left with padding
    primaryNote:SetWidth(primaryNoteFrame:GetWidth() - 10)       -- Account for padding
    primaryNote:SetWordWrap(true)
    primaryNote:SetText("Some other text")                       -- Placeholder text for debugging
    primaryNote:SetAlpha(1.0)
    primaryNote:SetJustifyH("LEFT")
    primaryNoteFrame:SetHeight(primaryNote:GetStringHeight())


    -- Store the card in the textFrames2 table for future reference
    textFrames2[index] = card

    -- Set the total height of the card based on content
    card:SetHeight(nameFrame:GetHeight() + primaryNoteFrame:GetHeight() + 15) -- Add padding as needed

    return card
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




