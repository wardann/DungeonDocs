local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")


local function createCheckBox(state, key, label, frame)
    local checkBox = AceGUI:Create("CheckBox")
    checkBox:SetLabel(label)
    checkBox:SetValue(state[key])
    checkBox:SetCallback("OnValueChanged", function(widget, event, value)
        DD:DB_Update(function()
            state[key] = value
        end)
    end)

    frame:AddChild(checkBox)
end


function SettingsShared_AddEnabled(frame, state, callback)
    local checkBox = AceGUI:Create("CheckBox")
    checkBox:SetLabel("Primary Note Enabled")
    checkBox:SetValue(state.enabled)
    checkBox:SetCallback("OnValueChanged", function(widget, event, value)
        DD:DB_Update(function()
            state.enabled = value
            callback(value)
        end)
    end)

    frame:AddChild(checkBox)
end

function SettingsShared_AddDisplayMobName(frame, state)
    createCheckBox(
        state,
        "displayMobName",
        "Display Mob Name",
        frame
    )
end

function SettingsShared_AddRoleDisplaySelect(frame, state)
    local options = {
        None = "None",
        Current = "Current role",
        All = "All roles",
    }
    local dropdown = AceGUI:Create("Dropdown")

    dropdown:SetLabel("Role Display")
    dropdown:SetList(options)
    dropdown:SetValue(options[state.roleDisplay])

    dropdown:SetCallback("OnValueChanged", function(_, _, key)
        DD:DB_Update(function()
            state.roleDisplay = key
        end)
    end)

    frame:AddChild(dropdown)
end

function SettingsShared_AddMovers(frame, state, key)
    local toggleButton = AceGUI:Create("Button")

    local function setMoverText()
        toggleButton:SetText(state[key] and "Turn Movers Off" or "Turn Movers On")
    end
    setMoverText()

    toggleButton:SetWidth(200) -- Set a fixed width for the button
    toggleButton:SetCallback("OnClick", function()
        DD:DB_Update(function()
            print(">>> movers enabled", key, state[key])
            state[key] = not state[key]
            setMoverText()
        end)
    end)
    frame:AddChild(toggleButton)
end

function SettingsShared_AddRoleNoteIndent(frame, state)
    local slider = AceGUI:Create("Slider")
    slider:SetLabel("Role note indent")
    slider:SetSliderValues(0, 15, 1)
    slider:SetValue(state.roleNoteIndent)
    slider:SetFullWidth(false)

    -- Callback for when the slider value changes
    slider:SetCallback("OnValueChanged", function(_, _, value)
        DD:DB_Update(function()
            state.roleNoteIndent = value
        end)
    end)

    -- Add the slider to the frame
    frame:AddChild(slider)
end

function SettingsShared_AddNoteWidth(frame, state)
    local slider = AceGUI:Create("Slider")
    slider:SetLabel("Note width")
    slider:SetSliderValues(200, 750, 5) -- Min: 0, Max: 100, Step: 5
    slider:SetValue(state.noteWidth)    -- Set the initial value
    slider:SetFullWidth(true)           -- Make it stretch across the frame

    -- Callback for when the slider value changes
    slider:SetCallback("OnValueChanged", function(_, _, value)
        DD:DB_Update(function()
            state.noteWidth = value
        end)
    end)

    -- Add the slider to the frame
    frame:AddChild(slider)
end

function SettingsShared_AddRoleNameIndent(frame, state)
    local slider = AceGUI:Create("Slider")
    slider:SetLabel("Role name indent")
    slider:SetSliderValues(0, 15, 1)
    slider:SetValue(state.roleNameIndent)
    slider:SetFullWidth(false)

    -- Callback for when the slider value changes
    slider:SetCallback("OnValueChanged", function(_, _, value)
        DD:DB_Update(function()
            state.roleNameIndent = value
        end)
    end)

    -- Add the slider to the frame
    frame:AddChild(slider)
end

function SettingsShared_AddFontSelect(frame, state)
    AddFontSelect(
        frame,
        "Font",
        FontPathToName(state.font),
        function(selection)
            DD:DB_Update(function()
                state.font = FontNameToPath(selection)
            end)
        end
    )
end

function SettingsShared_AddNoteColor(frame, state)
    -- Create the color picker widget
    local colorPicker = AceGUI:Create("ColorPicker")
    colorPicker:SetLabel("Color")
    colorPicker:SetColor(state.color.r, state.color.g, state.color.b) -- Default to red (RGB)

    -- Callback function when the color is changed
    colorPicker:SetCallback("OnValueChanged", function(widget, event, r, g, b, a)
        DD:DB_Update(function()
            state.color.r = r
            state.color.g = g
            state.color.b = b
        end)
    end)

    -- Add the color picker to the frame
    frame:AddChild(colorPicker)
end

function SettingsShared_AddFontSlider(frame, state)
    local fontSizeSlider = AceGUI:Create("Slider")
    fontSizeSlider:SetLabel("Font Size")
    fontSizeSlider:SetSliderValues(8, 32, 1) -- Min, max, and step for font size
    fontSizeSlider:SetValue(state.fontSize)  -- Default font size
    fontSizeSlider:SetCallback("OnValueChanged", function(widget, event, value)
        DD:DB_Update(function()
            state.fontSize = value
        end)
    end)
    frame:AddChild(fontSizeSlider)
end

function SettingsShared_AddOutlineToggle(frame, state)
    local checkBox = AceGUI:Create("CheckBox")
    checkBox:SetLabel("Font Outline")
    checkBox:SetValue(state.outline) -- Set initial value
    checkBox:SetCallback("OnValueChanged", function(widget, event, value)
        DD:DB_Update(function()
            state.outline = value
        end)
    end)
    frame:AddChild(checkBox)
end

function SettingsShared_AddHorizontalFontAlignment(frame, state)
    local alignmentsH = {
        LEFT = "LEFT",
        CENTER = "CENTER",
        RIGHT = "RIGHT",
    }
    local dropdown = AceGUI:Create("Dropdown")

    dropdown:SetLabel("Alignment")
    dropdown:SetList(alignmentsH)
    dropdown:SetValue(alignmentsH[state.align])

    dropdown:SetCallback("OnValueChanged", function(_, _, key)
        DD:DB_Update(function()
            state.align = key
        end)
    end)

    frame:AddChild(dropdown)
end

function SettingsShared_AddOverflow(frame, state)
    createCheckBox(
        state,
        "overflow",
        "Text overflow",
        frame
    )
end
