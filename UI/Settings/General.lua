local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

function DD:SettingsGeneral_View(rightGroup)
    DD:SettingsGeneral_AddDefaultFontSelect(rightGroup)
    Utils_AddSpacer(rightGroup)
    DD:SettingsGeneral_AddSeasonSelect(rightGroup)
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
