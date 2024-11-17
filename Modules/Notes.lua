local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local DD = DungeonDocs

local notePanels = {}

local noteFontStrings = {}

local notePanelPlaceholders = {
    primary = "PRIMARY NOTE (old)",
    role = "ROLE NOTE (old)",
}

local noteContent = {
    primary = nil,
    role = nil,
}

DungeonDocs:SubscribeToDBChange(function()
    DungeonDocs:Notes_SyncNotesWithTarget()
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
    -- Are we creating this font string twice? Once here and another below? Is that the cause of the one bug?
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

    local fontString = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    noteFontStrings[noteName] = fontString
end

function DungeonDocs:Notes_SaveFrameCoordinates(noteName)
    local notesPositions = self.db.profile.notes.positions
    local textFrame = notePanels[noteName]

    -- Get the anchor point and position (relative to parent)
    local point, relativeTo, relativePoint, xOffset, yOffset = textFrame:GetPoint()

    -- Print the coordinates in the chat window
    notesPositions[noteName] = { point, relativePoint, xOffset, yOffset }
end

function DungeonDocs:RenderNotePanels()
    local moversEnabled = self.db.profile.internal.movers
    local noteStyle = self.db.profile.settings.noteStyle
    local primaryStyle = noteStyle.primary
    local roleStyle = noteStyle.role

    if noteStyle.roleUsesPrimaryStyle then
        roleStyle = noteStyle.primary
    end

    if moversEnabled then
        -- RenderNotePanelMovers("primary")
        -- RenderNotePanelMovers("role")
    else
        DungeonDocs:RenderNotePanelNotes("primary", primaryStyle)
        DungeonDocs:RenderNotePanelNotes("role", roleStyle)
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
    local fontString = noteFontStrings[noteName]
    fontString:SetText(notePanelPlaceholders[noteName])
    fontString:SetPoint("CENTER") -- Center the text in the frame
    fontString:SetJustifyH("CENTER")                                     -- Horizontal alignment (options: "LEFT", "CENTER", "RIGHT")

    -- Set a transparent gray background
    textFrame.bg:SetColorTexture(0, 0, 0, 0.5) -- 50% transparent gray
end

function DungeonDocs:RenderNotePanelNotes(noteName, style)
    local textFrame = notePanels[noteName]

    -- Switch to the blank, immovable state
    textFrame:EnableMouse(false)             -- Disable mouse interactions
    textFrame:SetMovable(false)              -- Make it immovable
    textFrame.bg:SetColorTexture(0, 0, 0, 0) -- Make the background fully transparent

    local fontString = noteFontStrings[noteName]
    fontString:SetText(noteContent[noteName])

    local setPoint = "TOP" -- Center
    if style.align == "LEFT" then
        setPoint = "TOPLEFT"
    elseif style.align == "RIGHT" then
        setPoint = "TOPRIGHT"
    end

    fontString:SetPoint(setPoint) -- Center the text in the frame

    -- Set custom properties
    local outline = style.outline and "OUTLINE" or ""
    fontString:SetFont(style.font, style.fontSize, outline)                 -- Custom font, size, and outline
    fontString:SetTextColor(style.color.r, style.color.g, style.color.b, 1) -- Set color (red) with full opacity
    fontString:SetJustifyH(style.align)                                     -- Horizontal alignment (options: "LEFT", "CENTER", "RIGHT")
end

local function deriveRoleNoteKey()
    local specIndex = GetSpecialization()
    local specRole
    if specIndex then
        specRole = GetSpecializationRole(specIndex)
    end

    if specRole == "TANK" then
        return "tankNote"
    elseif specRole == "HEALER" then
        return "healerNote"
    elseif specRole == "DAMAGER" then
        return "damageNote"
    else
        print("DungeonDocs: error, could not determine spec role")
    end
end

function DungeonDocs:Notes_SyncNotesWithTarget()
    local internal = self.db.profile.internal

    if internal.showTestText then
        noteContent["primary"] = internal.testText
        noteContent["role"] = internal.testText
        DungeonDocs:RenderNotePanels()
        return
    else
        noteContent["primary"] = nil
        noteContent["role"] = nil
        DungeonDocs:RenderNotePanels()
    end

    -- Check if the player has a target
    local targetName = UnitName("target") -- Get the name of the current target

    -- If player does not have a target, clear out the notes
    if not targetName then
        noteContent["primary"] = nil
        noteContent["role"] = nil
        DungeonDocs:RenderNotePanels()
        return
    end

    local targetId = GetMobIDFromGUID("target")
    if not targetId then
        return
    end

    local currentInstanceName, currentInstanceType = GetInstanceInfo()
    if currentInstanceType ~= "party" then
        return
    end

    local roleNoteKey = deriveRoleNoteKey()

    local primaryNote = DD:DB_GetNotePrimary(currentInstanceName, targetId, "primaryNote")
    local roleNote = DD:DB_GetNotePrimary(currentInstanceName, targetId, roleNoteKey)

    noteContent["primary"] = primaryNote
    noteContent["role"] = roleNote

    DungeonDocs:RenderNotePanels()
end
