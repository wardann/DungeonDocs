local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local movers = {}

local moverFontStrings = {}

local moverTitles = {
    primaryNote = "PRIMARY NOTE",
    roleNote = "ROLE NOTE",
    omniNote = "OMNI NOTE",
}


DD:SubscribeToDBChange(function()
    DD:Movers_Render()
end)

function DD:Movers_GetPrimary()
    return movers["primaryNote"]
end

function DD:Movers_GetRole()
    return movers["roleNote"]
end

function DD:Movers_GetOmni()
    return movers["omniNote"]
end

-- Create the text panel frame
function DD:Movers_Init()
    local notesPositions = self.db.profile.notes.positions

    -- Primary mover
    InitMover("primaryNote", notesPositions.primary, "TOP")

    -- Role mover
    InitMover("roleNote", notesPositions.secondary, "TOPLEFT")

    -- Omni mover
    InitMover("omniNote", notesPositions.secondary, "LEFT")

    -- Initial render
    DD:Movers_Render()
end

function InitMover(noteName, framePosition, defaultPosition)
    -- Create a frame to display the text
    local mover = CreateFrame("Frame", "TextPanel", UIParent)
    mover:SetSize(100, 20)  -- Set the size of the panel
    mover:EnableMouse(false) -- Disable mouse interactions initially
    mover:SetMovable(false)  -- Initially immovable

    -- Create a background for the frame
    mover.bg = mover:CreateTexture(nil, "BACKGROUND")
    mover.bg:SetAllPoints(mover)
    mover.bg:SetColorTexture(0, 0, 0, 0) -- Fully transparent initially

    -- Create a font string for the text
    mover.text = mover:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    mover.text:SetPoint("CENTER")
    mover.text:SetText("") -- Initially blank text

    -- Use the position from the user, else use the default
    if framePosition then
        local f = framePosition
        mover:SetPoint(f[1], UIParent, f[2], f[3], f[4])
    else
        mover:SetPoint(defaultPosition, UIParent, defaultPosition, 0, -50) -- Center at the top of the screen
    end

    movers[noteName] = mover

    local fontString = mover:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    moverFontStrings[noteName] = fontString
end

function DD:Movers_SaveFrameCoordinates(noteName)
    local state = self.db.profile.settings
    local mover = movers[noteName]

    -- Get the anchor point and position (relative to parent)
    local point, relativeTo, relativePoint, xOffset, yOffset = mover:GetPoint()

    -- Print the coordinates in the chat window
    state[noteName].position = { point, relativePoint, xOffset, yOffset }
end

function DD:Movers_Render()
    local state = self.db.profile.settings
    local internal = self.db.profile.internal

    -- Primary
    if internal.movers.primaryNote then
        RenderMover("primaryNote", state.primaryNote)
    else
        HideMover("primaryNote")
    end

    -- Role
    if internal.movers.roleNote then
        RenderMover("roleNote", state.roleNote)
    else
        HideMover("roleNote")
    end

    -- Omni
    if internal.movers.omniNote then
        RenderMover("omniNote", state.omniNote)
    else
        HideMover("omniNote")
    end
end

function HideMover(noteName)
    local fontString = moverFontStrings[noteName]
    fontString:SetText("")

    local mover = movers[noteName]
    mover.bg:SetColorTexture(0, 0, 0, 0)
end

function RenderMover(noteName, state)
    local mover = movers[noteName]


    mover:SetWidth(state.noteWidth)
    mover:EnableMouse(true)             -- Enable mouse interactions
    mover:SetMovable(true)              -- Allow movement
    mover:RegisterForDrag("LeftButton") -- Enable dragging
    mover:SetScript("OnDragStart", function(self) self:StartMoving() end)
    mover:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        DD:Movers_SaveFrameCoordinates(noteName)
    end)

    -- Set placeholder text
    local fontString = moverFontStrings[noteName]
    fontString:SetText(moverTitles[noteName])
    fontString:SetPoint("CENTER")    -- Center the text in the frame
    fontString:SetJustifyH("CENTER") -- Horizontal alignment (options: "LEFT", "CENTER", "RIGHT")

    -- Set a transparent gray background
    mover.bg:SetColorTexture(0, 0, 0, 0.5) -- 50% transparent gray
end
