local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

function DD:SettingsStyleRoleHealer_View(wrapperContainer)
    local refresh = function()
        wrapperContainer:ReleaseChildren()
        DD:SettingsStyleRoleHealer_View(wrapperContainer)
    end
    wrapperContainer:SetLayout("Flow")

    local state = self.db.profile.settings.omniNote
    local internal = self.db.profile.internal

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)

    SettingsStyleRoleHealer_AddDescription(container)

    --
    --
    -- Healer role note section
    --
    --
    local healerRoleNoteSection = AddSection(container, "")
    local healerHeaderInput = AceGUI:Create("EditBox")
    healerHeaderInput:SetLabel("Header")
    healerHeaderInput:DisableButton(true)
    healerHeaderInput:SetText(state.healerHeader)
    healerHeaderInput:SetCallback("OnTextChanged", function(widget, event, value)
        DD:DB_Update(function()
            state.healerHeader = value
        end)
    end)
    healerRoleNoteSection:AddChild(healerHeaderInput)

    Utils_AddSpacer(healerRoleNoteSection)

    -- Use default role header
    SettingsShared_AddCheckBox(
        healerRoleNoteSection,
        "Use Default Role Header",
        state.style.healerHeader,
        "useDefaultRoleHeaderStyle",
        refresh
    )

    -- Use default text style
    SettingsShared_AddCheckBox(
        healerRoleNoteSection,
        "Use Default Text Style",
        state.style.healerNote,
        "useDefaultTextStyle",
        refresh
    )

    if not state.style.healerHeader.useDefaultRoleHeaderStyle then
        local healerHeaderStyleSection = AddSection(container, "Healer Header Style")
        SettingsShared_AddFontSettings(healerHeaderStyleSection, state.style.healerHeader.text)
    end

    if not state.style.healerNote.useDefaultTextStyle then
        local healerNoteStyleSection = AddSection(container, "Healer Note Style")
        SettingsShared_AddFontSettings(healerNoteStyleSection, state.style.healerNote.text)
    end

end

function SettingsStyleRoleHealer_AddDescription(frame)
    -- Create a title label
    local title = AceGUI:Create("Label")
    title:SetText("|cffffd700Healer Notes Style|r")    -- Gold-colored text for the title
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