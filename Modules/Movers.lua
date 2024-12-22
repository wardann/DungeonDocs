--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

--- @class Movers
local M = {}

--- @type table<string, Frame>
local moverFrames = {}

--- @type table<string, FontString>
local moverFontStrings = {}

local moverTitles = {
    primaryNote = "PRIMARY NOTE",
    roleNote = "ROLE NOTE",
    omniNote = "DungeonDocs Anchor",
}


DD.db.SubscribeToDBChange(function()
    M.Render()
end)

function M.GetPrimary()
    return moverFrames["primaryNote"]
end

function M.GetRole()
    return moverFrames["roleNote"]
end

function M.GetOmni()
    return moverFrames["omniNote"]
end

-- Create the text panel frame
function M.Init()
    local state = DD.db.database.profile

    -- Primary mover
    -- InitMover("primaryNote", notesPositions.primary, "TOP")

    -- Role mover
    -- InitMover("roleNote", notesPositions.secondary, "TOPLEFT")

    -- Omni mover
    M.InitMover("omniNote", state.settings.omniNote.position, "LEFT")

    -- Render and hide the note so the frame actually gets created
    M.RenderMover("omniNote", state.settings.omniNote)
    M.HideMover("omniNote")


    -- Initial render
    M.Render()
end

--- @param noteName string
--- @param framePosition Position
--- @param defaultPosition string
function M.InitMover(noteName, framePosition, defaultPosition)
    -- Create a frame to display the text
    local frame = CreateFrame("Frame", "TextPanel", UIParent)
    frame:SetSize(100, 20)   -- Set the size of the panel
    frame:EnableMouse(false) -- Disable mouse interactions initially
    frame:SetMovable(false)  -- Initially immovable

    -- Create a background for the frame
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints(frame)
    frame.bg:SetColorTexture(0, 0, 0, 0) -- Fully transparent initially

    -- Create a font string for the text
    frame.fontString = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    frame.fontString:SetPoint("CENTER")
    frame.fontString:SetText("") -- Initially blank text

    -- Use the position from the user, else use the default
    if framePosition then
        local f = framePosition
        frame:SetPoint(f[1], UIParent, f[2], f[3], f[4])
    else
        frame:SetPoint(defaultPosition, UIParent, defaultPosition, 0, -50) -- Center at the top of the screen
    end

    moverFrames[noteName] = frame

    local fontString = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    moverFontStrings[noteName] = fontString
end

--- @param noteName string
function M.SaveFrameCoordinates(noteName)
    local state = DD.db.database.profile.settings
    local mover = moverFrames[noteName]

    -- Get the anchor point and position (relative to parent)
    local point, _, relativePoint, xOffset, yOffset = mover:GetPoint()

    -- Print the coordinates in the chat window
    state[noteName].position = { point, relativePoint, xOffset, yOffset }
end

function M.Render()
    local state = DD.db.database.profile.settings
    local internal = DD.db.database.profile.internal

    -- Primary
    -- if internal.moverFrames.primaryNote then
    --     RenderMover("primaryNote", state.primaryNote)
    -- else
    --     HideMover("primaryNote")
    -- end

    -- Role
    -- if internal.moverFrames.roleNote then
    --     RenderMover("roleNote", state.roleNote)
    -- else
    --     HideMover("roleNote")
    -- end

    -- Omni
    if internal.moverFrames.omniNote then
        M.RenderMover("omniNote", state.omniNote)
    else
        M.HideMover("omniNote", state.omniNote)
    end
end

function M.HideMover(noteName, state)
    local fontString = moverFontStrings[noteName]
    fontString:SetText("")

    local mover = moverFrames[noteName]
    mover.bg:SetColorTexture(0, 0, 0, 0)
    mover:SetMovable(false)

    if state then
        mover:SetWidth(state.noteWidth)
    end
end

function M.RenderMover(noteName, state)
    local frame = moverFrames[noteName]

    frame:SetWidth(state.noteWidth)
    frame:EnableMouse(true)             -- Enable mouse interactions
    frame:SetMovable(true)              -- Allow movement
    frame:RegisterForDrag("LeftButton") -- Enable dragging
    frame:SetScript("OnDragStart", function(self)
        if frame:IsMovable() then
            self:StartMoving()
        end
    end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        M.SaveFrameCoordinates(noteName)
    end)

    -- Set placeholder text
    local fontString = moverFontStrings[noteName]
    fontString:SetText(moverTitles[noteName])
    fontString:SetPoint("CENTER")    -- Center the text in the frame
    fontString:SetJustifyH("CENTER") -- Horizontal alignment (options: "LEFT", "CENTER", "RIGHT")

    -- Set a transparent gray background
    frame.bg:SetColorTexture(0, 0, 0, 0.5) -- 50% transparent gray
end

DD.movers = M