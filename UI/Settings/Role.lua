--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI

--- @class UI
DD.ui = DD.ui or {}

--- @class SettingsUI
DD.ui.settings = DD.ui.settings or {}

---@param container AceGUIContainer
function DD.ui.settings.StyleRole_View(container)
    local refresh = function()
        container:ReleaseChildren()
        DD.ui.settings.StyleRole_View(container)
    end
    container:SetLayout("Flow")

    local state = DD.db.database.profile.settings.omniNote

    local scrollFrame = AceGUI:Create("ScrollFrame") ---@type ScrollFrame
    scrollFrame:SetLayout("Flow")
    scrollFrame:SetFullWidth(true)
    scrollFrame:SetFullHeight(true)
    container:AddChild(scrollFrame)

    DD.ui.settings.StyleRole_AddDescription(scrollFrame)

    -- Add role notes settings
    local roleNotesSection = DD.utils.AddSection(scrollFrame, "")
    -- Add role display dropdown
    local roleDisplays = {
        None = "None",
        Current = "Current",
        All = "All",
    }
    DD.ui.shared.AddDropdown(roleNotesSection, "Role Display", roleDisplays, state, "roleDisplay", refresh)

    if state.roleDisplay == "None" then return end

    -- Display role header
    DD.ui.shared.AddCheckBox(
        roleNotesSection,
        "Display role header",
        state,
        "displayRoleHeader",
        refresh
    )

    -- Add role header indent slider
    DD.ui.shared.AddSlider(
        roleNotesSection,
        "Role Header Indent",
        state,
        "roleHeaderIndent",
        0,
        15,
        1
    )

    -- Add role note indent slider
    DD.ui.shared.AddSlider(
        roleNotesSection,
        "Role Note Indent",
        state,
        "roleNoteIndent",
        0,
        15,
        1
    )

    local defaultRoleHeaderStyle = DD.utils.AddSection(scrollFrame, "Default Role Header Style")
    DD.ui.shared.AddFontSettings(defaultRoleHeaderStyle, state.style.defaultRoleHeader)
end

function DD.ui.settings.StyleRole_AddDescription(frame)
    -- Create a title label
    local title = AceGUI:Create("Label")
    title:SetText("|cffffd700Role Notes|r")    -- Gold-colored text for the title
    title:SetFont(GameFontNormalLarge:GetFont()) -- Use a larger font for the title
    title:SetFullWidth(true)                     -- Stretch across the frame
    frame:AddChild(title)

    -- Create an explanation label
    -- local explanation = AceGUI:Create("Label")
    -- explanation:SetText(
    -- "Displays a note on a per-target basis.")
    -- explanation:SetFullWidth(true)            -- Stretch across the frame
    -- explanation:SetFont(GameFontNormal:GetFont()) -- Standard font for the explanation
    -- frame:AddChild(explanation)
end