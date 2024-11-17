local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

function DD:SettingsPrimary_View(wrapperContainer)
    wrapperContainer:SetLayout("Flow")

    local state = self.db.profile.settings.primaryNote
    local internal = self.db.profile.internal

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)

    SettingsPrimary_AddDescription(container)
    Utils_AddSpacer(container)

    local baseSection = AddSection(container, "Basic")
    SettingsShared_AddEnabled(baseSection, state, function(enabled)
        wrapperContainer:ReleaseChildren()
        DD:SettingsPrimary_View(wrapperContainer)
    end)

    if not state.enabled then
        return
    end


    SettingsShared_AddMovers(baseSection, internal.movers, "primaryNote")
    SettingsShared_AddNoteWidth(baseSection, state)

    -- Note style
    local noteStyleSection = AddSection(container, "Note Style")
    SettingsShared_AddFontSelect(noteStyleSection, state.noteTextStyle)
    SettingsShared_AddFontSlider(noteStyleSection, state.noteTextStyle)
    SettingsShared_AddNoteColor(noteStyleSection, state.noteTextStyle)
    SettingsShared_AddOutlineToggle(noteStyleSection, state.noteTextStyle)
    SettingsShared_AddOverflow(noteStyleSection, state.noteTextStyle)

    -- Mob name style
    local mobNameStyleSection = AddSection(container, "Mob Name Style")
    SettingsShared_AddDisplayMobName(mobNameStyleSection, state)
    Utils_AddSpacer(mobNameStyleSection)
    SettingsShared_AddFontSelect(mobNameStyleSection, state.mobNameStyle)
    SettingsShared_AddFontSlider(mobNameStyleSection, state.mobNameStyle)
    SettingsShared_AddNoteColor(mobNameStyleSection, state.mobNameStyle)
    SettingsShared_AddOutlineToggle(mobNameStyleSection, state.mobNameStyle)
    SettingsShared_AddOverflow(mobNameStyleSection, state.mobNameStyle)

    local roleSection = AddSection(container, "Role")
    SettingsShared_AddRoleDisplaySelect(roleSection, state)
    Utils_AddSpacer(roleSection)
    SettingsShared_AddRoleNameIndent(roleSection, state)
    SettingsShared_AddRoleNoteIndent(roleSection, state)
end

function SettingsPrimary_AddDescription(frame)
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
