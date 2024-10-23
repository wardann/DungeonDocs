local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")
local LSM = LibStub("LibSharedMedia-3.0")

-- Get available fonts from LSM
local fontList = LSM:HashTable("font")


function DungeonDocs:ShowSettingsTab(container)
    container:SetLayout("Flow")

    -- Movers settings
    DungeonDocs:AddSettingsTabMovers(container)

    -- Add spacer
    DungeonDocs:AddSpacer(container)

    --Font settings
    DungeonDocs:AddSettingsTabFont(container)
end

function DungeonDocs:AddSpacer(container)
    -- Add a spacer (or line break)
    local spacer = AceGUI:Create("Label")
    spacer:SetFullWidth(true)
    container:AddChild(spacer)
end

function DungeonDocs:AddSettingsTabMovers(container)
    local db = self.db

    -- Create a label for the section title
    local titleLabel = AceGUI:Create("Label")
    titleLabel:SetText("Toggle Movers")
    titleLabel:SetFullWidth(true)
    container:AddChild(titleLabel)

    -- Create a button to toggle movers
    local toggleButton = AceGUI:Create("Button")

    local function SetMoversText()
        toggleButton:SetText(db.profile.settings.internal.movers and "Turn Movers Off" or "Turn Movers On")
    end
    SetMoversText()

    toggleButton:SetWidth(200)  -- Set a fixed width for the button
    toggleButton:SetCallback("OnClick", function()
        local dbInternal = db.profile.settings.internal

        dbInternal.movers = not dbInternal.movers
        DungeonDocs:NotifyDBChange()
        SetMoversText()
    end)
    container:AddChild(toggleButton)
end

function DungeonDocs:AddSettingsTabFont(container)
    local db = self.db

    -- Dropdown menu for font selection
    local fontDropdown = AceGUI:Create("Dropdown")
    fontDropdown:SetLabel("Select a Font")


    local fontNameToPath = fontList
    local fontPathToName = {}
    for fontName, fontPath in pairs(fontList) do
        fontPathToName[fontPath] = fontName  -- Use font names as display text
    end

    local fontNames = {}
    for fontName, _ in pairs(fontList) do
        fontNames[fontName] = fontName  -- Use font names as display text
    end


    -- Create a list with font-specific labels
    fontDropdown:SetList(fontNames)

    -- Set initial font
    fontDropdown:SetValue(fontPathToName[db.profile.settings.font])

    -- Set callback to apply the selected font and preview it
    fontDropdown:SetCallback("OnValueChanged", function(_, _, key)
        db.profile.settings.font = fontNameToPath[key]
        print(db.profile.settings.font)
    end)

    container:AddChild(fontDropdown)
end

