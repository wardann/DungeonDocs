local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local DD = DungeonDocs

local notePanels = {}

local noteFontStrings = {}

local primaryNoteFrame
local primaryNoteFontString
local primaryNoteContent

DD:SubscribeToDBChange(function()
    DD:PrimaryNote_Render()
end)

-- Create the text panel frame
function DD:PrimaryNote_Init()
    -- Primary note panel
    -- InitPrimaryNote("primary", notesPositions.primary, "TOP")
    InitPrimaryNote()

    -- Initial render
    DD:PrimaryNote_Render()
end

function InitPrimaryNote()
    -- Create a frame to display the text

    local primaryNoteMover = DD:Movers_GetPrimary()
    primaryNoteFrame = CreateFrame("Frame", "TextPanel", primaryNoteMover)
    primaryNoteFrame.bg = primaryNoteFrame:CreateTexture(nil, "BACKGROUND")
    primaryNoteFrame.bg:SetAllPoints(primaryNoteFrame)
    primaryNoteFrame.bg:SetColorTexture(0, 0, 0, 0.5) -- Fully transparent initially

    -- primaryNoteFrame:SetSize(300, 100)  -- Set the size of the panel
    -- textFrame:EnableMouse(false) -- Disable mouse interactions initially
    -- textFrame:SetMovable(false)  -- Initially immovable

    -- Create a background for the frame
    -- textFrame.bg = textFrame:CreateTexture(nil, "BACKGROUND")
    -- textFrame.bg:SetAllPoints(textFrame)
    -- textFrame.bg:SetColorTexture(0, 0, 0, 0) -- Fully transparent initially

    -- Create a font string for the text
    -- Are we creating this font string twice? Once here and another below? Is that the cause of the one bug?
    -- textFrame.text = textFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    -- textFrame.text:SetPoint("CENTER")
    -- textFrame.text:SetText("") -- Initially blank text

    -- Use the position from the user, else use the default
    -- if framePosition then
    --     local f = framePosition
    --     textFrame:SetPoint(f[1], UIParent, f[2], f[3], f[4])
    -- else
    --     textFrame:SetPoint(defaultPosition, UIParent, defaultPosition, 0, -50) -- Center at the top of the screen
    -- end

    -- notePanels[noteName] = textFrame

    primaryNoteFontString = primaryNoteFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")

    print(">>> primary note init done")
    print(">>> primary note init done")
    print(">>> primary note init done")
    print(">>> primary note init done")
    print(">>> primary note init done")
    print(">>> primary note init done")
end

function DD:PrimaryNote_Render()
    print(">>> primary note render!")
    local state = self.db.profile.settings.primaryNote

    -- if internal.showTestText then
    --     noteContent["primary"] = internal.testText
    --     noteContent["role"] = internal.testText
    --     DungeonDocs:RenderNotePanels()
    --     return
    -- else
    --     noteContent["primary"] = nil
    --     noteContent["role"] = nil
    --     DungeonDocs:RenderNotePanels()
    -- end

    -- Check if the player has a target
    local targetName = UnitName("target") -- Get the name of the current target

    -- If player does not have a target, clear out the notes
    if not targetName then
        primaryNoteContent = nil
        DungeonDocs:RenderNotePanelNotes(state.noteTextStyle)
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

    local doc = DD:DB_GetNotePrimary(currentInstanceName, targetId, "primaryNote")
    primaryNoteContent = doc
    print(">>> doc is", doc)
    print(">>> target id ", targetId)

    DungeonDocs:RenderNotePanelNotes(state.noteTextStyle)
end

function DungeonDocs:RenderNotePanels()
end

function DungeonDocs:RenderNotePanelNotes(style)
    print(">>> render note panel notes")
    print(">>> primaryNoteFontString", primaryNoteFontString)
    primaryNoteFontString:SetText(primaryNoteContent or "")
    print(">>> primaryNoteContent", primaryNoteContent)

    local setPoint = "TOP" -- Center
    if style.align == "LEFT" then
        setPoint = "TOPLEFT"
    elseif style.align == "RIGHT" then
        setPoint = "TOPRIGHT"
    end

    primaryNoteFontString:SetPoint(setPoint) -- Center the text in the frame

    -- Set custom properties
    local outline = style.outline and "OUTLINE" or ""
    primaryNoteFontString:SetFont(style.font, style.fontSize, outline)                 -- Custom font, size, and outline
    primaryNoteFontString:SetTextColor(style.color.r, style.color.g, style.color.b, 1) -- Set color (red) with full opacity
    primaryNoteFontString:SetJustifyH(style.align)                                     -- Horizontal alignment (options: "LEFT", "CENTER", "RIGHT")

    primaryNoteFrame:SetHeight(primaryNoteFontString:GetStringHeight())



end

-- local function deriveRoleNoteKey()
--     local specIndex = GetSpecialization()
--     local specRole
--     if specIndex then
--         specRole = GetSpecializationRole(specIndex)
--     end

--     if specRole == "TANK" then
--         return "tankNote"
--     elseif specRole == "HEALER" then
--         return "healerNote"
--     elseif specRole == "DAMAGER" then
--         return "damageNote"
--     else
--         print("DungeonDocs: error, could not determine spec role")
--     end
-- end
