local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")
local LSM = LibStub("LibSharedMedia-3.0")

-- Get available fonts from LSM
local fontList = LSM:HashTable("font")


function DungeonDocs:ShowSettingsTab(container)
    container:SetLayout("Flow")

    -- Movers settings
    DungeonDocs:Settings_AddMovers(container)

    -- Add spacer
    Utils_AddSpacer(container)

    -- Primary note config
    DungeonDocs:Settings_AddPrimaryNote(container)

    -- Role same as primary toggle
    DungeonDocs:Settings_AddRoleSameAsPrimaryToggle(container, function()
        container:ReleaseChildren()
        DungeonDocs:ShowSettingsTab(container)
    end)

    local roleUsesPrimaryStyle = self.db.profile.settings.noteStyle.roleUsesPrimaryStyle

    if not roleUsesPrimaryStyle then
        Utils_AddSpacer(container)
        DungeonDocs:Settings_AddRoleNote(container)
    end

    -- Add spacer
    Utils_AddSpacer(container)

    -- Test text
    DungeonDocs:Settings_AddTestText(container)

    -- Add spacer
    Utils_AddSpacer(container)

    -- Season select
    DungeonDocs:Settings_AddSeasonSelect(container)
end

function DungeonDocs:Settings_AddPrimaryNote(container)
    local primaryStyle = self.db.profile.settings.noteStyle.primary
    Settings_AddNote(container, primaryStyle)
end

function DungeonDocs:Settings_AddRoleNote(container)
    local roleStyle = self.db.profile.settings.noteStyle.role
    Settings_AddNote(container, roleStyle)
end

function Settings_AddNote(container, noteState)

    Settings_AddFontSelect(container, noteState)

    Settings_AddNoteColor(container, noteState)

    Settings_AddOutlineToggle(container, noteState)

    Settings_AddHorizontalFontAlignment(container, noteState)

    Settings_AddFontSlider(container, noteState)
end

function DungeonDocs:Settings_AddMovers(container)
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

    toggleButton:SetWidth(200) -- Set a fixed width for the button
    toggleButton:SetCallback("OnClick", function()
        DungeonDocs:DB_Update(function()
            local dbInternal = db.profile.settings.internal

            dbInternal.movers = not dbInternal.movers
            SetMoversText()
        end)
    end)
    container:AddChild(toggleButton)
end

function DungeonDocs:Settings_AddSeasonSelect(container)
    local db = self.db

    -- Dropdown menu for season selection
    local seasonDropdown = AceGUI:Create("Dropdown")
    seasonDropdown:SetLabel("Select a Season")
    seasonDropdown:SetList(db.profile.internal.seasons)
    seasonDropdown:SetValue(db.profile.internal.selectedSeason)
    seasonDropdown:SetCallback("OnValueChanged", function(_, _, key)
        DungeonDocs:DB_Update(function()
            db.profile.internal.selectedSeason = key
        end)
    end)

    container:AddChild(seasonDropdown)
end

function DungeonDocs:Settings_AddTestText(container)
    local internal = self.db.profile.internal

    --
    -- TEST TEXT TOGGLE
    --
    -- Create a button to toggle movers
    local toggleButton = AceGUI:Create("Button")
    local function setToggleButtonText()
        toggleButton:SetText(internal.showTestText and "Toggle Test Text: Off" or "Toggle Test Text: On")
    end
    setToggleButtonText()

    toggleButton:SetWidth(200) -- Set a fixed width for the button
    toggleButton:SetCallback("OnClick", function()
        DungeonDocs:DB_Update(function()
            internal.showTestText = not internal.showTestText
            setToggleButtonText()
        end)
    end)
    container:AddChild(toggleButton)

    --
    -- TEST TEXT
    --
    local testText = AceGUI:Create("MultiLineEditBox")
    testText:SetLabel("Test text")
    testText:SetFullWidth(true)         -- Make the edit box take up the full width of the container
    testText:SetText(internal.testText) -- You can prefill the edit box with text if needed
    testText:DisableButton(true)        -- Disable the "Okay" button
    testText:SetCallback("OnTextChanged", function(widget, event, text)
        DungeonDocs:DB_Update(function()
            internal.testText = text
        end)
    end)
    container:AddChild(testText)
end

function Settings_AddNoteColor(container, state)
    -- Create the color picker widget
    local colorPicker = AceGUI:Create("ColorPicker")
    colorPicker:SetLabel("Pick a Color")
    colorPicker:SetColor(state.color.r, state.color.g, state.color.b) -- Default to red (RGB)

    -- Callback function when the color is changed
    colorPicker:SetCallback("OnValueChanged", function(widget, event, r, g, b, a)
        DungeonDocs:DB_Update(function()
            state.color.r = r
            state.color.g = g
            state.color.b = b
        end)
    end)

    -- Add the color picker to the frame
    container:AddChild(colorPicker)
end

function Settings_AddFontSelect(container, state)
    -- Dropdown menu for font selection
    local fontDropdown = AceGUI:Create("Dropdown")
    fontDropdown:SetLabel("Select a Font")


    local fontNameToPath = fontList
    local fontPathToName = {}
    for fontName, fontPath in pairs(fontList) do
        fontPathToName[fontPath] = fontName -- Use font names as display text
    end

    local fontNames = {}
    for fontName, _ in pairs(fontList) do
        fontNames[fontName] = fontName -- Use font names as display text
    end

    -- Create a list with font-specific labels
    fontDropdown:SetList(fontNames)

    -- Set initial font
    fontDropdown:SetValue(fontPathToName[state.font])

    -- Set callback to apply the selected font and preview it
    fontDropdown:SetCallback("OnValueChanged", function(_, _, key)
        DungeonDocs:DB_Update(function()
            state.font = fontNameToPath[key]
        end)
    end)

    container:AddChild(fontDropdown)
end

function Settings_AddOutlineToggle(container, noteState)
    local checkBox = AceGUI:Create("CheckBox")
    checkBox:SetLabel("Font Outline")
    checkBox:SetValue(noteState.outline) -- Set initial value
    checkBox:SetCallback("OnValueChanged", function(widget, event, value)
        DungeonDocs:DB_Update(function()
            noteState.outline = value
        end)
    end)
    container:AddChild(checkBox)
end

function Settings_AddHorizontalFontAlignment(container, noteState)
    local alignmentsH = {
        LEFT = "LEFT",
        CENTER = "CENTER",
        RIGHT = "RIGHT",
    }
    local dropdown = AceGUI:Create("Dropdown")

    dropdown:SetLabel("Alignment")
    dropdown:SetList(alignmentsH)
    dropdown:SetValue(alignmentsH[noteState.align])

    dropdown:SetCallback("OnValueChanged", function(_, _, key)
        DungeonDocs:DB_Update(function()
            noteState.align = key
        end)
    end)

    container:AddChild(dropdown)
end


function Settings_AddFontSlider(container, noteState)
    local fontSizeSlider = AceGUI:Create("Slider")
    fontSizeSlider:SetLabel("Font Size")
    fontSizeSlider:SetSliderValues(8, 32, 1) -- Min, max, and step for font size
    fontSizeSlider:SetValue(14)              -- Default font size
    fontSizeSlider:SetCallback("OnValueChanged", function(widget, event, value)
        DungeonDocs:DB_Update(function()
            noteState.fontSize = value
        end)
    end)
    container:AddChild(fontSizeSlider)
end

function DungeonDocs:Settings_AddRoleSameAsPrimaryToggle(container, callback)
    local state = self.db.profile.settings.noteStyle
    local checkBox = AceGUI:Create("CheckBox")

    checkBox:SetLabel("Role Uses Primary Style")
    checkBox:SetValue(state.roleUsesPrimaryStyle)
    checkBox:SetCallback("OnValueChanged", function(widget, event, value)
        DungeonDocs:DB_Update(function()
            state.roleUsesPrimaryStyle = value
        end)
        if callback ~= nil then
            callback()
        end
    end)
    container:AddChild(checkBox)
end
