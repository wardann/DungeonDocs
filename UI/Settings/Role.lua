local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

function DD:SettingsStyleRole_View(wrapperContainer)
    local refresh = function()
        wrapperContainer:ReleaseChildren()
        DD:SettingsStyleRole_View(wrapperContainer)
    end
    wrapperContainer:SetLayout("Flow")

    local state = self.db.profile.settings.omniNote

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)

    SettingsStyleRole_AddDescription(container)

    -- Add role notes settings
    local roleNotesSection = AddSection(container, "")
    -- Add role display dropdown
    local roleDisplays = {
        None = "None",
        Current = "Current",
        All = "All",
    }
    SettingsShared_AddDropdown(roleNotesSection, "Role Display", roleDisplays, state, "roleDisplay", refresh)

    if state.roleDisplay == "None" then return end

    -- Display role header
    SettingsShared_AddCheckBox(
        roleNotesSection,
        "Display role header",
        state,
        "displayRoleHeader",
        refresh
    )

    -- Add role header indent slider
    SettingsShared_AddSlider(
        roleNotesSection,
        "Role Header Indent",
        state,
        "roleHeaderIndent",
        0,
        15,
        1
    )

    -- Add role note indent slider
    SettingsShared_AddSlider(
        roleNotesSection,
        "Role Note Indent",
        state,
        "roleNoteIndent",
        0,
        15,
        1
    )

    local defaultRoleHeaderStyle = AddSection(container, "Default Role Header Style")
    SettingsShared_AddFontSettings(defaultRoleHeaderStyle, state.style.defaultRoleHeader)
end

function SettingsStyleRole_AddDescription(frame)
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