local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

function DD:SettingsGeneral_View(wrapperContainer)
    local state = self.db.profile.settings.omniNote
    local internal = self.db.profile.internal

    wrapperContainer:SetLayout("Flow")

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)

    SettingsGeneral_AddDescription(container)

    local baseSection = AddSection(container, "")
    SettingsShared_AddMovers(baseSection, internal.movers, "omniNote")
    SettingsShared_AddNoteWidth(baseSection, state)

    -- Add note grow direction
    local growDirections = {
        UP = "UP",
        DOWN = "DOWN",
    }
    SettingsShared_AddDropdown(baseSection, "Note Grow Direction", growDirections, state, "noteGrowDirection")

    SettingsShared_AddTextAlignment(baseSection, state, "textAlign")


    -- Add line padding
    SettingsShared_AddLinePadding(baseSection, state)

    -- Add backdrop opacity
    SettingsShared_AddBackgroundOpacity(baseSection, state)

    -- Untargeted note opacity
    SettingsShared_AddUntargetedNoteOpacity(baseSection, state)

    -- Note spacing
    SettingsShared_AddNoteSpacing(baseSection, state)

    -- Add text outline checkbox
    SettingsShared_AddCheckBox(baseSection, "Text outline", state, "textOutline")

    -- Add default font selection
    local defaultFontSection = AddSection(container, "Default Text Style")
    SettingsShared_AddFontSettings(defaultFontSection, state.style.defaultText)



    local seasonSection = AddSection(container, "Season")
    DD:SettingsGeneral_AddSeasonSelect(seasonSection)
end

function DD:SettingsGeneral_AddSeasonSelect(container)
    local db = self.db

    -- Dropdown menu for season selection
    local seasonDropdown = AceGUI:Create("Dropdown")
    seasonDropdown:SetLabel("Select a Season")
    seasonDropdown:SetList(db.profile.internal.seasons)
    seasonDropdown:SetValue(db.profile.internal.selectedSeason)
    seasonDropdown:SetCallback("OnValueChanged", function(_, _, key)
        DD:DB_Update(function()
            db.profile.internal.selectedSeason = key
        end)
    end)

    container:AddChild(seasonDropdown)
end

function DD:SettingsGeneral_AddDefaultFontSelect(container)
    local db = self.db
    local currentSelection = db.profile.defaultFont

    AddFontSelect(
        container,
        "Default Font",
        FontPathToName(currentSelection),
        function(selection)
            DD:DB_Update(function()
                db.profile.defaultFont = FontNameToPath(selection)
            end)
        end
    )
end

function SettingsGeneral_AddDescription(frame)
    -- Create a title label
    local title = AceGUI:Create("Label")
    title:SetText("|cffffd700General|r")    -- Gold-colored text for the title
    title:SetFont(GameFontNormalLarge:GetFont()) -- Use a larger font for the title
    title:SetFullWidth(true)                     -- Stretch across the frame
    frame:AddChild(title)
end