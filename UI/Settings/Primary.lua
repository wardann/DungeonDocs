--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

--- @class UI
DD.ui = DD.ui or {}

--- @class SettingsUI
DD.ui.settings = DD.ui.settings or {}

function DD.ui.settings.StylePrimary_View(wrapperContainer)
    local refresh = function()
        wrapperContainer:ReleaseChildren()
        DD.ui.settings.StylePrimary_View(wrapperContainer)
    end

    wrapperContainer:SetLayout("Flow")

    local state = DD.db.profile.settings.omniNote

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)


    DD.ui.settings.StylePrimary_AddDescription(container)

    -- Add primary note settings
    local primaryNoteSection = DD.utils.AddSection(container, "")
    if not state.style.primaryNote.useDefaultTextStyle then
        DD.ui.shared.AddFontSettings(primaryNoteSection, state.style.primaryNote.text)
    end
    DD.ui.shared.AddCheckBox(
        primaryNoteSection,
        "Use default text style",
        state.style.primaryNote,
        "useDefaultTextStyle",
        refresh
    )
end

function DD.ui.settings.StylePrimary_AddDescription(frame)
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
