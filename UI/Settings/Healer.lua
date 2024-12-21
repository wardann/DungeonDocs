--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

--- @class UI
DD.ui = DD.ui or {}

--- @class SettingsUI
DD.ui.settings = DD.ui.settings or {}

function DD.ui.settings.StyleRoleHealer_View(wrapperContainer)
    local refresh = function()
        wrapperContainer:ReleaseChildren()
        DD.ui.settings.StyleRoleHealer_View(wrapperContainer)
    end
    wrapperContainer:SetLayout("Flow")

    local state = DD.db.database.profile.settings.omniNote

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)

    DD.ui.settings.StyleRoleHealer_AddDescription(container)

    --
    --
    -- Healer role note section
    --
    --
    local healerRoleNoteSection = DD.utils.AddSection(container, "")
    local healerHeaderInput = AceGUI:Create("EditBox")
    healerHeaderInput:SetLabel("Header")
    healerHeaderInput:DisableButton(true)
    healerHeaderInput:SetText(state.healerHeader)
    healerHeaderInput:SetCallback("OnTextChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state.healerHeader = value
        end)
    end)
    healerRoleNoteSection:AddChild(healerHeaderInput)

    DD.utils.AddSpacer(healerRoleNoteSection)

    -- Use default role header
    DD.ui.shared.AddCheckBox(
        healerRoleNoteSection,
        "Use Default Role Header",
        state.style.healerHeader,
        "useDefaultRoleHeaderStyle",
        refresh
    )

    -- Use default text style
    DD.ui.shared.AddCheckBox(
        healerRoleNoteSection,
        "Use Default Text Style",
        state.style.healerNote,
        "useDefaultTextStyle",
        refresh
    )

    if not state.style.healerHeader.useDefaultRoleHeaderStyle then
        local healerHeaderStyleSection = DD.utils.AddSection(container, "Healer Header Style")
        DD.ui.shared.AddFontSettings(healerHeaderStyleSection, state.style.healerHeader.text)
    end

    if not state.style.healerNote.useDefaultTextStyle then
        local healerNoteStyleSection = DD.utils.AddSection(container, "Healer Note Style")
        DD.ui.shared.AddFontSettings(healerNoteStyleSection, state.style.healerNote.text)
    end

end

function DD.ui.settings.StyleRoleHealer_AddDescription(frame)
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