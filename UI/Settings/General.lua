--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") --- @type AceGUI

--- @class UI
DD.ui = DD.ui or {}

--- @class SettingsUI
DD.ui.settings = DD.ui.settings or {}

---@param container AceGUIContainer
function DD.ui.settings.General_View(container)
    local db = DD.db.database
    local state = db.profile.settings.omniNote
    local internal = db.profile.internal

    container:SetLayout("Flow")

    local scrollFrame = AceGUI:Create("ScrollFrame") ---@type ScrollFrame
    scrollFrame:SetLayout("Flow")
    scrollFrame:SetFullWidth(true)
    scrollFrame:SetFullHeight(true)
    container:AddChild(scrollFrame)

    DD.ui.settings.General_AddDescription(scrollFrame)

    local baseSection = DD.utils.AddSection(scrollFrame, "")
    DD.ui.shared.AddMovers(baseSection, internal.movers, "omniNote")
    DD.ui.shared.AddNoteWidth(baseSection, state)

    -- Add note grow direction
    local growDirections = {
        UP = "UP",
        DOWN = "DOWN",
    }
    DD.ui.shared.AddDropdown(baseSection, "Note Grow Direction", growDirections, state, "noteGrowDirection")

    DD.ui.shared.AddTextAlignment(baseSection, state, "textAlign")


    -- Add line padding
    DD.ui.shared.AddLinePadding(baseSection, state)

    -- Add backdrop opacity
    DD.ui.shared.AddBackgroundOpacity(baseSection, state)

    -- Untargeted note opacity
    DD.ui.shared.AddUntargetedNoteOpacity(baseSection, state)

    -- Note spacing
    DD.ui.shared.AddNoteSpacing(baseSection, state)

    -- Add text outline checkbox
    DD.ui.shared.AddCheckBox(baseSection, "Text outline", state, "textOutline")

    -- Add default font selection
    local defaultFontSection = DD.utils.AddSection(scrollFrame, "Default Text Style")
    DD.ui.shared.AddFontSettings(defaultFontSection, state.style.defaultText)



    local seasonSection = DD.utils.AddSection(scrollFrame, "Season")
    DD.ui.settings.General_AddSeasonSelect(seasonSection)
end

---@param container AceGUIContainer
function DD.ui.settings.General_AddSeasonSelect(container)
    local db = DD.db.database

    -- Dropdown menu for season selection
    local seasonDropdown = AceGUI:Create("Dropdown") ---@type Dropdown
    seasonDropdown:SetLabel("Select a Season")
    seasonDropdown:SetList(db.profile.internal.seasons)
    seasonDropdown:SetValue(db.profile.internal.selectedSeason)
    seasonDropdown:SetCallback("OnValueChanged", function(_, _, key)
        DD.db.UpdateDB(function()
            db.profile.internal.selectedSeason = key
        end)
    end)

    container:AddChild(seasonDropdown)
end

---@param container AceGUIContainer
function DD.ui.settings.General_AddDescription(container)
    -- Create a title label
    local title = AceGUI:Create("Label") ---@type Label
    title:SetText("|cffffd700General|r")    -- Gold-colored text for the title
    title:SetFont(GameFontNormalLarge:GetFont()) -- Use a larger font for the title
    title:SetFullWidth(true)                     -- Stretch across the frame
    container:AddChild(title)
end