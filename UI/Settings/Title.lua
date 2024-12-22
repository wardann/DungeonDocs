--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

--- @class UI
DD.ui = DD.ui or {}

--- @class SettingsUI
DD.ui.settings = DD.ui.settings or {}

function DD.ui.settings.Title_View(wrapperContainer)
    local refresh = function()
        wrapperContainer:ReleaseChildren()
        DD.ui.settings.Title_View(wrapperContainer)
    end


    wrapperContainer:SetLayout("Flow")

    local state = DD.db.database.profile.settings.omniNote

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)

    DD.ui.settings.Title_AddDescription(container)

    -- Add mob name settings
    local mobNameSection = DD.utils.AddSection(container, "")
    DD.ui.shared.AddCheckBox(mobNameSection, "Show note title", state, "showNoteTitle", refresh)

    if state.showNoteTitle then
        if not state.style.mobName.useDefaultTextStyle then
            DD.utils.AddSpacer(mobNameSection)
            DD.utils.shared.AddFontSettings(mobNameSection, state.style.mobName.text)
        end
        DD.utils.shared.AddCheckBox(mobNameSection, "Use default text style", state.style.mobName, "useDefaultTextStyle",
            refresh)
    end
end

function DD.ui.settings.Title_AddDescription(frame)
    -- Create a title label
    local title = AceGUI:Create("Label")
    title:SetText("|cffffd700Note Title|r")
    title:SetFont(GameFontNormalLarge:GetFont())
    title:SetFullWidth(true)
    frame:AddChild(title)
end
