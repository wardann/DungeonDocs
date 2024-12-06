local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

function DD:SettingsStyleRoleTank_View(wrapperContainer)
    local refresh = function()
        wrapperContainer:ReleaseChildren()
        DD:SettingsStyleRoleTank_View(wrapperContainer)
    end
    wrapperContainer:SetLayout("Flow")

    local state = self.db.profile.settings.omniNote

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)

    SettingsStyleRoleTank_AddDescription(container)

    --
    --
    -- Tank role note section
    --
    --
    local tankRoleNoteSection = AddSection(container, "")
    local tankHeaderInput = AceGUI:Create("EditBox")
    tankHeaderInput:SetLabel("Header")
    tankHeaderInput:SetText(state.tankHeader)
    tankHeaderInput:DisableButton(true)
    tankHeaderInput:SetCallback("OnTextChanged", function(widget, event, value)
        DD:DB_Update(function()
            state.tankHeader = value
        end)
    end)
    tankRoleNoteSection:AddChild(tankHeaderInput)

    Utils_AddSpacer(tankRoleNoteSection)

    -- Use default role header
    SettingsShared_AddCheckBox(
        tankRoleNoteSection,
        "Use Default Role Header",
        state.style.tankHeader,
        "useDefaultRoleHeaderStyle",
        refresh
    )

    -- Use default text style
    SettingsShared_AddCheckBox(
        tankRoleNoteSection,
        "Use Default Text Style",
        state.style.tankNote,
        "useDefaultTextStyle",
        refresh
    )

    if not state.style.tankHeader.useDefaultRoleHeaderStyle then
        local tankHeaderStyleSection = AddSection(container, "Tank Header Style")
        SettingsShared_AddFontSettings(tankHeaderStyleSection, state.style.tankHeader.text)
    end

    if not state.style.tankNote.useDefaultTextStyle then
        local tankNoteStyleSection = AddSection(container, "Tank Note Style")
        SettingsShared_AddFontSettings(tankNoteStyleSection, state.style.tankNote.text)
    end

end

function SettingsStyleRoleTank_AddDescription(frame)
    -- Create a title label
    local title = AceGUI:Create("Label")
    title:SetText("|cffffd700Tank Notes Style|r")    -- Gold-colored text for the title
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