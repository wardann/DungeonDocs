local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

function DD:SettingsStylePrimary_View(wrapperContainer)
    local refresh = function()
        wrapperContainer:ReleaseChildren()
        DD:SettingsStylePrimary_View(wrapperContainer)
    end


    wrapperContainer:SetLayout("Flow")

    local state = self.db.profile.settings.omniNote
    local internal = self.db.profile.internal

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)


    SettingsStylePrimary_AddDescription(container)
    Utils_AddSpacer(container)


    local baseSection = AddSection(container, "Basic")

    SettingsShared_AddMovers(baseSection, internal.movers, "omniNote")
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

    -- Add text overflow checkbox
    SettingsShared_AddCheckBox(baseSection, "Text overflow", state, "textOverflow")

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
end

function SettingsStylePrimary_AddDescription(frame)
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