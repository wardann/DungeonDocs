---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI

---@class SharedUI
local M = {}

---@param container AceGUIContainer
---@param label string
---@param state table<string, any>
---@param stateKey string
---@param callback fun(boolean)|nil
function M.AddCheckBox(container, label, state, stateKey, callback)
	local checkBox = AceGUI:Create("CheckBox") ---@type CheckBox
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

	container:AddChild(checkBox)
end

---@param container AceGUIContainer
---@param state table<string, any>
---@param callback fun(boolean)
function M.AddEnabled(container, state, callback)
	local checkBox = AceGUI:Create("CheckBox") ---@type CheckBox
	checkBox:SetLabel("Primary Note Enabled")
	checkBox:SetValue(state.enabled)
	checkBox:SetCallback("OnValueChanged", function(_, _, value)
		DD.db.UpdateDB(function()
			state.enabled = value
			callback(value)
		end)
	end)

	container:AddChild(checkBox)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddDisplayNoteTitle(container, state)
	M.AddCheckBox(container, "Display Note Title", state, "displayNoteTitle")
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddRoleDisplaySelect(container, state)
	local options = {
		None = "None",
		Current = "Current role",
		All = "All roles",
	}
	local dropdown = AceGUI:Create("Dropdown") ---@type Dropdown

	dropdown:SetLabel("Role Display")
	dropdown:SetList(options)
	dropdown:SetValue(options[state.roleDisplay])

	dropdown:SetCallback("OnValueChanged", function(_, _, key)
		DD.db.UpdateDB(function()
			state.roleDisplay = key
		end)
	end)

	container:AddChild(dropdown)
end

---@param container AceGUIContainer
---@param state table<string, any>
---@param stateKey string
function M.AddMovers(container, state, stateKey)
	local toggleButton = AceGUI:Create("Button") ---@type Button

	local function setMoverText()
		toggleButton:SetText(state[stateKey] and "Turn Movers Off" or "Turn Movers On")
	end
	setMoverText()

	toggleButton:SetWidth(200) -- Set a fixed width for the button
	toggleButton:SetCallback("OnClick", function()
		DD.db.UpdateDB(function()
			state[stateKey] = not state[stateKey]
			setMoverText()
		end)
	end)
	container:AddChild(toggleButton)
end

---@param container AceGUIContainer
---@param state table<string, any>
---@param stateKey string
function M.AddTestNoteToggle(container, state, stateKey)
	local toggleButton = AceGUI:Create("Button") ---@type Button

	local function setMoverText()
		toggleButton:SetText(state[stateKey] and "Turn Test Note Off" or "Turn Test Note On")
	end
	setMoverText()

	toggleButton:SetWidth(200) -- Set a fixed width for the button
	toggleButton:SetCallback("OnClick", function()
		DD.db.UpdateDB(function()
			state[stateKey] = not state[stateKey]
			setMoverText()
		end)
	end)
	container:AddChild(toggleButton)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddRoleNoteIndent(container, state)
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

	-- Add the slider to the container
	container:AddChild(slider)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddNoteWidth(container, state)
	local slider = AceGUI:Create("Slider") ---@type Slider
	slider:SetLabel("Note width")
	slider:SetSliderValues(200, 750, 5) -- Min: 0, Max: 100, Step: 5
	slider:SetValue(state.noteWidth) -- Set the initial value
	slider:SetFullWidth(true) -- Make it stretch across the container

	-- Callback for when the slider value changes
	slider:SetCallback("OnValueChanged", function(_, _, value)
		DD.db.UpdateDB(function()
			state.noteWidth = value
		end)
	end)

	-- Add the slider to the container
	container:AddChild(slider)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddLinePadding(container, state)
	local slider = AceGUI:Create("Slider") ---@type Slider
	slider:SetLabel("Line padding")
	slider:SetSliderValues(0, 25, 1) -- Min: 0, Max: 100, Step: 5
	slider:SetValue(state.linePadding) -- Set the initial value

	-- Callback for when the slider value changes
	slider:SetCallback("OnValueChanged", function(_, _, value)
		DD.db.UpdateDB(function()
			state.linePadding = value
		end)
	end)

	-- Add the slider to the container
	container:AddChild(slider)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddBackgroundOpacity(container, state)
	local slider = AceGUI:Create("Slider") ---@type Slider
	slider:SetLabel("Background opacity")
	slider:SetSliderValues(0, 1, 0.1)
	slider:SetValue(state.backgroundOpacity)

	-- Callback for when the slider value changes
	slider:SetCallback("OnValueChanged", function(_, _, value)
		DD.db.UpdateDB(function()
			state.backgroundOpacity = value
		end)
	end)

	-- Add the slider to the container
	container:AddChild(slider)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddUntargetedNoteOpacity(container, state)
	local slider = AceGUI:Create("Slider") ---@type Slider
	slider:SetLabel("Untargeted note opacity")
	slider:SetSliderValues(0, 1, 0.1)
	slider:SetValue(state.untargetedNoteOpacity)

	-- Callback for when the slider value changes
	slider:SetCallback("OnValueChanged", function(_, _, value)
		DD.db.UpdateDB(function()
			state.untargetedNoteOpacity = value
		end)
	end)

	-- Add the slider to the container
	container:AddChild(slider)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddNoteSpacing(container, state)
	local slider = AceGUI:Create("Slider") ---@type Slider
	slider:SetLabel("Note spacing")
	slider:SetSliderValues(1, 50, 1)
	slider:SetValue(state.noteSpacing)

	-- Callback for when the slider value changes
	slider:SetCallback("OnValueChanged", function(_, _, value)
		DD.db.UpdateDB(function()
			state.noteSpacing = value
		end)
	end)

	-- Add the slider to the container
	container:AddChild(slider)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddRoleNameIndent(container, state)
	local slider = AceGUI:Create("Slider") ---@type Slider
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

	-- Add the slider to the container
	container:AddChild(slider)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddFontSelect(container, state)
	DD.utils.AddFontSelect(container, "Font", DD.utils.FontPathToName(state.font), function(selection)
		DD.db.UpdateDB(function()
			state.font = DD.utils.FontNameToPath(selection)
		end)
	end)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddNoteColor(container, state)
	-- Create the color picker widget
	local colorPicker = AceGUI:Create("ColorPicker") ---@type ColorPicker
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

	-- Add the color picker to the container
	container:AddChild(colorPicker)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddFontSlider(container, state)
	local fontSizeSlider = AceGUI:Create("Slider") ---@type Slider
	fontSizeSlider:SetLabel("Font Size")
	fontSizeSlider:SetSliderValues(8, 32, 1) -- Min, max, and step for font size
	fontSizeSlider:SetValue(state.fontSize) -- Default font size
	fontSizeSlider:SetCallback("OnValueChanged", function(_, _, value)
		DD.db.UpdateDB(function()
			state.fontSize = value
		end)
	end)
	container:AddChild(fontSizeSlider)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddFontSettings(container, state)
	M.AddFontSelect(container, state)
	M.AddNoteColor(container, state)
	M.AddFontSlider(container, state)
end

---@param container AceGUIContainer
---@param label string
---@param state table<string, any>
---@param stateKey string
---@param min number
---@param max number
---@param step number
function M.AddSlider(container, label, state, stateKey, min, max, step)
	local fontSizeSlider = AceGUI:Create("Slider") ---@type Slider
	fontSizeSlider:SetLabel(label)
	fontSizeSlider:SetSliderValues(min, max, step)
	fontSizeSlider:SetValue(state[stateKey])
	fontSizeSlider:SetCallback("OnValueChanged", function(_, _, value)
		DD.db.UpdateDB(function()
			state[stateKey] = value
		end)
	end)
	container:AddChild(fontSizeSlider)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddOutlineToggle(container, state)
	local checkBox = AceGUI:Create("CheckBox") ---@type CheckBox
	checkBox:SetLabel("Font Outline")
	checkBox:SetValue(state.outline) -- Set initial value
	checkBox:SetCallback("OnValueChanged", function(_, _, value)
		DD.db.UpdateDB(function()
			state.outline = value
		end)
	end)
	container:AddChild(checkBox)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddHorizontalFontAlignment(container, state)
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

	container:AddChild(dropdown)
end

---@param container AceGUIContainer
---@param state table<string, any>
function M.AddOverflow(container, state)
	M.AddCheckBox(container, "Text overflow", state, "overflow")
end

---@param container AceGUIContainer
---@param state table<string, any>
---@param stateKey string
function M.AddTextAlignment(container, state, stateKey)
	local alignments = {
		LEFT = "LEFT",
		CENTER = "CENTER",
		RIGHT = "RIGHT",
	}
	local dropdown = AceGUI:Create("Dropdown")

	dropdown:SetLabel("Text Alignment")
	dropdown:SetList(alignments)
	dropdown:SetValue(alignments[state[stateKey]])

	dropdown:SetCallback("OnValueChanged", function(_, _, value)
		DD.db.UpdateDB(function()
			state[stateKey] = value
		end)
	end)

	container:AddChild(dropdown)
end

---@param container AceGUIContainer
---@param label string
---@param options table<string, any>
---@param state table<string, any>
---@param stateKey string
---@param callback fun()|nil
function M.AddDropdown(container, label, options, state, stateKey, callback)
	local dropdown = AceGUI:Create("Dropdown") ---@type Dropdown

	dropdown:SetLabel(label)
	dropdown:SetList(options)
	dropdown:SetValue(options[state[stateKey]])

	dropdown:SetCallback("OnValueChanged", function(_, _, optionsKey)
		DD.db.UpdateDB(function()
			state[stateKey] = optionsKey
			if callback then
				callback()
			end
		end)
	end)

	container:AddChild(dropdown)
end

---@class UI
DD.ui = DD.ui or {}
DD.ui.shared = M
