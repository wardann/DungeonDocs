--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

--- @class SharedUI
local M = {}


function M.AddCheckBox(frame, label, state, stateKey, callback)
    local checkBox = AceGUI:Create("CheckBox")
    checkBox:SetLabel(label)
    checkBox:SetValue(state[stateKey])
    checkBox:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state[stateKey] = value
            if callback then
                callback(value)
            end
        end)
    end)

    frame:AddChild(checkBox)
end

function M.AddEnabled(frame, state, callback)
    local checkBox = AceGUI:Create("CheckBox")
    checkBox:SetLabel("Primary Note Enabled")
    checkBox:SetValue(state.enabled)
    checkBox:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state.enabled = value
            callback(value)
        end)
    end)

    frame:AddChild(checkBox)
end

function M.AddDisplayMobName(frame, state)
    M.AddCheckBox(
        frame,
        "Display Mob Name",
        state,
        "displayMobName"
    )
end

function M.AddRoleDisplaySelect(frame, state)
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
        DD.db.UpdateDB(function()
            state.roleDisplay = key
        end)
    end)

    frame:AddChild(dropdown)
end

function M.AddMovers(frame, state, key)
    local toggleButton = AceGUI:Create("Button")

    local function setMoverText()
        toggleButton:SetText(state[key] and "Turn Movers Off" or "Turn Movers On")
    end
    setMoverText()

    toggleButton:SetWidth(200) -- Set a fixed width for the button
    toggleButton:SetCallback("OnClick", function()
        DD.db.UpdateDB(function()
            state[key] = not state[key]
            setMoverText()
        end)
    end)
    frame:AddChild(toggleButton)
end

function M.AddTestNoteToggle(frame, state, key)
    local toggleButton = AceGUI:Create("Button")

    local function setMoverText()
        toggleButton:SetText(state[key] and "Turn Test Note Off" or "Turn Test Note On")
    end
    setMoverText()

    toggleButton:SetWidth(200) -- Set a fixed width for the button
    toggleButton:SetCallback("OnClick", function()
        DD.db.UpdateDB(function()
            state[key] = not state[key]
            setMoverText()
        end)
    end)
    frame:AddChild(toggleButton)
end

function M.AddRoleNoteIndent(frame, state)
    local slider = AceGUI:Create("Slider")
    slider:SetLabel("Role note indent")
    slider:SetSliderValues(0, 15, 1)
    slider:SetValue(state.roleNoteIndent)
    slider:SetFullWidth(false)

    -- Callback for when the slider value changes
    slider:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state.roleNoteIndent = value
        end)
    end)

    -- Add the slider to the frame
    frame:AddChild(slider)
end

function M.AddNoteWidth(frame, state)
    local slider = AceGUI:Create("Slider")
    slider:SetLabel("Note width")
    slider:SetSliderValues(200, 750, 5) -- Min: 0, Max: 100, Step: 5
    slider:SetValue(state.noteWidth)    -- Set the initial value
    slider:SetFullWidth(true)           -- Make it stretch across the frame

    -- Callback for when the slider value changes
    slider:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state.noteWidth = value
        end)
    end)

    -- Add the slider to the frame
    frame:AddChild(slider)
end

function M.AddLinePadding(frame, state)
    local slider = AceGUI:Create("Slider")
    slider:SetLabel("Line padding")
    slider:SetSliderValues(0, 25, 1)   -- Min: 0, Max: 100, Step: 5
    slider:SetValue(state.linePadding) -- Set the initial value

    -- Callback for when the slider value changes
    slider:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state.linePadding = value
        end)
    end)

    -- Add the slider to the frame
    frame:AddChild(slider)
end

function M.AddBackgroundOpacity(frame, state)
    local slider = AceGUI:Create("Slider")
    slider:SetLabel("Background opacity")
    slider:SetSliderValues(0, 1, 0.1)
    slider:SetValue(state.backgroundOpacity)

    -- Callback for when the slider value changes
    slider:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state.backgroundOpacity = value
        end)
    end)

    -- Add the slider to the frame
    frame:AddChild(slider)
end

function M.AddUntargetedNoteOpacity(frame, state)
    local slider = AceGUI:Create("Slider")
    slider:SetLabel("Untargeted note opacity")
    slider:SetSliderValues(0, 1, 0.1)
    slider:SetValue(state.untargetedNoteOpacity)

    -- Callback for when the slider value changes
    slider:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state.untargetedNoteOpacity = value
        end)
    end)

    -- Add the slider to the frame
    frame:AddChild(slider)
end

function M.AddNoteSpacing(frame, state)
    local slider = AceGUI:Create("Slider")
    slider:SetLabel("Note spacing")
    slider:SetSliderValues(0, 50, 1)
    slider:SetValue(state.noteSpacing)

    -- Callback for when the slider value changes
    slider:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state.noteSpacing = value
        end)
    end)

    -- Add the slider to the frame
    frame:AddChild(slider)
end

function M.AddRoleNameIndent(frame, state)
    local slider = AceGUI:Create("Slider")
    slider:SetLabel("Role name indent")
    slider:SetSliderValues(0, 15, 1)
    slider:SetValue(state.roleNameIndent)
    slider:SetFullWidth(false)

    -- Callback for when the slider value changes
    slider:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state.roleNameIndent = value
        end)
    end)

    -- Add the slider to the frame
    frame:AddChild(slider)
end

function M.AddFontSelect(frame, state)
    DD.utils.AddFontSelect(
        frame,
        "Font",
        DD.utils.FontPathToName(state.font),
        function(selection)
            DD.db.UpdateDB(function()
                state.font = DD.utils.FontNameToPath(selection)
            end)
        end
    )
end

function M.AddNoteColor(frame, state)
    -- Create the color picker widget
    local colorPicker = AceGUI:Create("ColorPicker")
    colorPicker:SetLabel("Color")
    colorPicker:SetColor(state.color.r, state.color.g, state.color.b) -- Default to red (RGB)

    -- Callback function when the color is changed
    colorPicker:SetCallback("OnValueChanged", function(_, _, r, g, b, _)
        DD.db.UpdateDB(function()
            state.color.r = r
            state.color.g = g
            state.color.b = b
        end)
    end)

    -- Add the color picker to the frame
    frame:AddChild(colorPicker)
end

function M.AddFontSlider(frame, state)
    local fontSizeSlider = AceGUI:Create("Slider")
    fontSizeSlider:SetLabel("Font Size")
    fontSizeSlider:SetSliderValues(8, 32, 1) -- Min, max, and step for font size
    fontSizeSlider:SetValue(state.fontSize)  -- Default font size
    fontSizeSlider:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state.fontSize = value
        end)
    end)
    frame:AddChild(fontSizeSlider)
end

function M.AddFontSettings(frame, state)
    M.AddFontSelect(frame, state)
    M.AddNoteColor(frame, state)
    M.AddFontSlider(frame, state)
end

function M.AddSlider(frame, label, state, stateKey, min, max, step)
    local fontSizeSlider = AceGUI:Create("Slider")
    fontSizeSlider:SetLabel(label)
    fontSizeSlider:SetSliderValues(min, max, step)
    fontSizeSlider:SetValue(state[stateKey])
    fontSizeSlider:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state[stateKey] = value
        end)
    end)
    frame:AddChild(fontSizeSlider)
end

function M.AddOutlineToggle(frame, state)
    local checkBox = AceGUI:Create("CheckBox")
    checkBox:SetLabel("Font Outline")
    checkBox:SetValue(state.outline) -- Set initial value
    checkBox:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state.outline = value
        end)
    end)
    frame:AddChild(checkBox)
end

function M.AddHorizontalFontAlignment(frame, state)
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
        DD.db.UpdateDB(function()
            state.align = key
        end)
    end)

    frame:AddChild(dropdown)
end

function M.AddOverflow(frame, state)
    M.AddCheckBox(
        frame,
        "Text overflow",
        state,
        "overflow"
    )
end

function M.AddTextAlignment(frame, state, key)
    local alignments = {
        LEFT = "LEFT",
        CENTER = "CENTER",
        RIGHT = "RIGHT",
    }
    local dropdown = AceGUI:Create("Dropdown")

    dropdown:SetLabel("Text Alignment")
    dropdown:SetList(alignments)
    dropdown:SetValue(alignments[state[key]])

    dropdown:SetCallback("OnValueChanged", function(_, _, value)
        DD.db.UpdateDB(function()
            state[key] = value
        end)
    end)

    frame:AddChild(dropdown)
end

function M.AddDropdown(frame, label, options, state, stateKey, callback)
    local dropdown = AceGUI:Create("Dropdown")

    dropdown:SetLabel(label)
    dropdown:SetList(options)
    dropdown:SetValue(options[state[stateKey]])

    dropdown:SetCallback("OnValueChanged", function(_, _, optionsKey)
        DD.db.UpdateDB(function()
            state[stateKey] = optionsKey
            if callback then callback() end
        end)
    end)

    frame:AddChild(dropdown)
end

--- @class UI
DD.ui = DD.ui or {}
DD.ui.shared = M
