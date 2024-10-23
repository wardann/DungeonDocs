local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local notePanels = {}

local notePanelPlaceholders = {
    primary = "PRIMARY NOTE",
    role = "ROLE NOTE",
}

DungeonDocs:SubscribeToDBChange(function()
    DungeonDocs:RenderNotePanels()
end)

-- Create the text panel frame
function DungeonDocs:InitNotePanels()
    local notesPositions = self.db.profile.notes.positions

    -- Primary note panel
    InitNotePanel("primary", notesPositions.primary, "TOP")

    -- Role note panel
    InitNotePanel("role", notesPositions.secondary, "TOPLEFT")

    -- Initial render
    DungeonDocs:RenderNotePanels()
end

function InitNotePanel(noteName, framePosition, defaultPosition)
    -- Create a frame to display the text
    local textFrame = CreateFrame("Frame", "TextPanel", UIParent)
    textFrame:SetSize(300, 100)  -- Set the size of the panel
    textFrame:EnableMouse(false) -- Disable mouse interactions initially
    textFrame:SetMovable(false)  -- Initially immovable

    -- Create a background for the frame
    textFrame.bg = textFrame:CreateTexture(nil, "BACKGROUND")
    textFrame.bg:SetAllPoints(textFrame)
    textFrame.bg:SetColorTexture(0, 0, 0, 0) -- Fully transparent initially

    -- Create a font string for the text
    textFrame.text = textFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    textFrame.text:SetPoint("CENTER")
    textFrame.text:SetText("") -- Initially blank text

    -- Use the position from the user, else use the default
    if framePosition then
        local f = framePosition
        textFrame:SetPoint(f[1], UIParent, f[2], f[3], f[4])
    else
        textFrame:SetPoint(defaultPosition, UIParent, defaultPosition, 0, -50) -- Center at the top of the screen
    end

    notePanels[noteName] = textFrame
end

-- Function to print and store frame coordinates
function DungeonDocs:Notes_SaveFrameCoordinates(noteName)
    local notesPositions = self.db.profile.notes.positions
    local textFrame = notePanels[noteName]

    -- Get the anchor point and position (relative to parent)
    local point, relativeTo, relativePoint, xOffset, yOffset = textFrame:GetPoint()

    -- Print the coordinates in the chat window
    notesPositions[noteName] = { point, relativePoint, xOffset, yOffset }
end

function DungeonDocs:RenderNotePanels()
    local moversEnabled = self.db.profile.settings.internal.movers

    if moversEnabled then
        RenderNotePanelMovers("primary")
        RenderNotePanelMovers("role")
    else
        RenderNotePanelNotes("primary")
        RenderNotePanelNotes("role")
    end
end

function RenderNotePanelMovers(noteName)
    local textFrame = notePanels[noteName]

    textFrame:EnableMouse(true)             -- Enable mouse interactions
    textFrame:SetMovable(true)              -- Allow movement
    textFrame:RegisterForDrag("LeftButton") -- Enable dragging
    textFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    textFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        DungeonDocs:Notes_SaveFrameCoordinates(noteName)
    end)

    -- Set placeholder text
    textFrame.text:SetText(notePanelPlaceholders[noteName])

    -- Set a transparent gray background
    textFrame.bg:SetColorTexture(0, 0, 0, 0.5) -- 50% transparent gray
end

function RenderNotePanelNotes(noteName)
    local textFrame = notePanels[noteName]
    -- Switch to the blank, immovable state
    textFrame:EnableMouse(false)             -- Disable mouse interactions
    textFrame:SetMovable(false)              -- Make it immovable
    textFrame.text:SetText("")               -- Clear the text
    textFrame.bg:SetColorTexture(0, 0, 0, 0) -- Make the background fully transparent
end
