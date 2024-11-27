local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

function DD:SettingsOmni_View(wrapperContainer)
    local refresh = function()
        wrapperContainer:ReleaseChildren()
        DD:SettingsOmni_View(wrapperContainer)
    end


    wrapperContainer:SetLayout("Flow")

    local state = self.db.profile.settings.omniNote
    local internal = self.db.profile.internal

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)


    SettingsOmni_AddDescription(container)
    Utils_AddSpacer(container)


    local baseSection = AddSection(container, "Basic")

    SettingsShared_AddMovers(baseSection, internal.movers, "primaryNote")
    SettingsShared_AddTestNoteToggle(baseSection, internal, "showTestNote")
    SettingsShared_AddNoteWidth(baseSection, state)

    -- Add note grow direction
    local growDirections = {
        UP = "UP",
        DOWN = "DOWN",
    }
    SettingsShared_AddDropdown(baseSection, "Note Grow Direction", growDirections, state, "noteGrowDirection")

    SettingsShared_AddTextAlignment(baseSection, state, "textAlign")

    -- Add text outline checkbox
    SettingsShared_AddCheckBox(baseSection, "Text outline", state, "textOutline")

    -- Add default font selection
    local defaultFontSection = AddSection(container, "Default Text Style")
    SettingsShared_AddFontSettings(defaultFontSection, state.style.defaultText)

    -- Add mob name settings
    local mobNameSection = AddSection(container, "Mob Name")
    SettingsShared_AddCheckBox(mobNameSection, "Show mob name", state, "showMobName", refresh)

    if state.showMobName then
        if not state.style.mobName.useDefaultTextStyle then
            Utils_AddSpacer(mobNameSection)
            SettingsShared_AddFontSettings(mobNameSection, state.style.mobName.text)
        end
        SettingsShared_AddCheckBox(mobNameSection, "Use default text style", state.style.mobName, "useDefaultTextStyle",
            refresh)
    end

    -- Add primary note settings
    local primaryNoteSection = AddSection(container, "Primary Note")
    if not state.style.primaryNote.useDefaultTextStyle then
        SettingsShared_AddFontSettings(primaryNoteSection, state.style.primaryNote.text)
    end
    SettingsShared_AddCheckBox(
        primaryNoteSection,
        "Use default text style",
        state.style.primaryNote,
        "useDefaultTextStyle",
        refresh
    )


    -- Add role notes settings
    local roleNotesSection = AddSection(container, "Role Notes")
    -- Add role display dropdown
    local roleDisplays = {
        None = "None",
        Current = "Current",
        All = "All",
    }
    SettingsShared_AddDropdown(roleNotesSection, "Role Display", roleDisplays, state, "roleDisplay", refresh)

    if state.roleDisplay == "None" then return end

    -- to the role display, add header indent and role note indent

    -- make this its own section. add the header names to it. add the default style
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

    -- TODO: add deafult header config
    local defaultRoleHeaderStyle = AddSection(container, "Default Role Header Style")
    SettingsShared_AddFontSettings(defaultRoleHeaderStyle, state.style.defaultRoleHeader)
end

function SettingsOmni_AddDescription(frame)
    -- Create a title label
    local title = AceGUI:Create("Label")
    title:SetText("|cffffd700Primary Note|r")    -- Gold-colored text for the title
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
