local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

function DD:SettingsTitle_View(wrapperContainer)
    local refresh = function()
        wrapperContainer:ReleaseChildren()
        DD:SettingsTitle_View(wrapperContainer)
    end


    wrapperContainer:SetLayout("Flow")

    local state = self.db.profile.settings.omniNote

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)

    SettingsTitle_AddDescription(container)

    -- Add mob name settings
    local mobNameSection = AddSection(container, "")
    SettingsShared_AddCheckBox(mobNameSection, "Show note title", state, "showNoteTitle", refresh)

    if state.showNoteTitle then
        if not state.style.mobName.useDefaultTextStyle then
            Utils_AddSpacer(mobNameSection)
            SettingsShared_AddFontSettings(mobNameSection, state.style.mobName.text)
        end
        SettingsShared_AddCheckBox(mobNameSection, "Use default text style", state.style.mobName, "useDefaultTextStyle",
            refresh)
    end
end

function SettingsTitle_AddDescription(frame)
    -- Create a title label
    local title = AceGUI:Create("Label")
    title:SetText("|cffffd700Note Title|r")
    title:SetFont(GameFontNormalLarge:GetFont())
    title:SetFullWidth(true)
    frame:AddChild(title)
end
