local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

function DD:SettingsStyleRoleDamage_View(wrapperContainer)
    local refresh = function()
        wrapperContainer:ReleaseChildren()
        DD:SettingsStyleRoleDamage_View(wrapperContainer)
    end
    wrapperContainer:SetLayout("Flow")

    local state = self.db.profile.settings.omniNote
    local internal = self.db.profile.internal

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)

    SettingsStyleRoleDamage_AddDescription(container)

    --
    --
    -- Damage role note section
    --
    --
    local damageRoleNoteSection = AddSection(container, "")
    local damageHeaderInput = AceGUI:Create("EditBox")
    damageHeaderInput:SetLabel("Header")
    damageHeaderInput:SetText(state.damageHeader)
    damageHeaderInput:DisableButton(true)
    damageHeaderInput:SetCallback("OnTextChanged", function(widget, event, value)
        DD:DB_Update(function()
            state.damageHeader = value
        end)
    end)
    damageRoleNoteSection:AddChild(damageHeaderInput)

    Utils_AddSpacer(damageRoleNoteSection)

    -- Use default role header
    SettingsShared_AddCheckBox(
        damageRoleNoteSection,
        "Use Default Role Header",
        state.style.damageHeader,
        "useDefaultRoleHeaderStyle",
        refresh
    )

    -- Use default text style
    SettingsShared_AddCheckBox(
        damageRoleNoteSection,
        "Use Default Text Style",
        state.style.damageNote,
        "useDefaultTextStyle",
        refresh
    )

    if not state.style.damageHeader.useDefaultRoleHeaderStyle then
        local damageHeaderStyleSection = AddSection(container, "Damage Header Style")
        SettingsShared_AddFontSettings(damageHeaderStyleSection, state.style.damageHeader.text)
    end

    if not state.style.damageNote.useDefaultTextStyle then
        local damageNoteStyleSection = AddSection(container, "Damage Note Style")
        SettingsShared_AddFontSettings(damageNoteStyleSection, state.style.damageNote.text)
    end


end

function SettingsStyleRoleDamage_AddDescription(frame)
    -- Create a title label
    local title = AceGUI:Create("Label")
    title:SetText("|cffffd700Damage Notes Style|r")    -- Gold-colored text for the title
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