---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI

---@class ProfileUI
local M = {}

local allProfilesDropdowns = {} ---@type Dropdown[]

local profileDropdowns = {} ---@type Dropdown[]

local fallbackProfileDropdowns = {} ---@type Dropdown[]

---@param container AceGUIContainer
function M.TabRoot(container)
	container:SetLayout("Flow")

	local scrollFrame = AceGUI:Create("ScrollFrame") ---@type ScrollFrame
	scrollFrame:SetLayout("Flow")
	scrollFrame:SetFullWidth(true)
	scrollFrame:SetFullHeight(true)
	container:AddChild(scrollFrame)

	M.AddSelect(scrollFrame)
	M.AddClone(scrollFrame)
	M.AddDelete(scrollFrame)
	M.AddReset(scrollFrame)
	M.AddImport(scrollFrame)
	M.AddExport(scrollFrame)
end

---@param profileDropdown Dropdown
function M.PopulateAllProfilesDropdown(profileDropdown)
	local profiles = {} ---@type table<string, string>
	for _, profileName in ipairs(DD.db.database:GetProfiles()) do
		profiles[profileName] = profileName -- Use profile name as both key and display text
	end
	profileDropdown:SetList(profiles)
end

---@param profileDropdown Dropdown
function M.PopulatePrimaryProfileDropdown(profileDropdown)
	local profiles = {} ---@type table<string, string>
	for _, profileName in ipairs(DD.db.database:GetProfiles()) do
		if not DD.profiles.IsReservedProfile(profileName) then
			profiles[profileName] = profileName -- Use profile name as both key and display text
		end
	end
	profileDropdown:SetList(profiles)
end

---@param profileDropdown Dropdown
function M.PopulateFallbackProfileDropdown(profileDropdown)
	local fallbackProfiles = {
		["None*"] = "None*",
	}
	for _, profileName in ipairs(DD.db.database:GetProfiles()) do
		fallbackProfiles[profileName] = profileName -- Use profile name as both key and display text
	end
	profileDropdown:SetList(fallbackProfiles)
end

local function refreshProfileDropdowns()
	for _, dropdown in ipairs(allProfilesDropdowns) do
		M.PopulateAllProfilesDropdown(dropdown)
	end
	for _, dropdown in ipairs(profileDropdowns) do
		M.PopulatePrimaryProfileDropdown(dropdown)
	end
	for _, dropdown in ipairs(fallbackProfileDropdowns) do
		M.PopulateFallbackProfileDropdown(dropdown)
	end
end

---@param profileDropdown Dropdown
local function initAllProfilesDropdown(profileDropdown)
	table.insert(allProfilesDropdowns, profileDropdown)
	M.PopulateAllProfilesDropdown(profileDropdown)
end

---@param profileDropdown Dropdown
local function initPrimaryProfileDropdown(profileDropdown)
	table.insert(profileDropdowns, profileDropdown)
	M.PopulatePrimaryProfileDropdown(profileDropdown)
end

---@param profileDropdown Dropdown
local function initFallbackProfileDropdown(profileDropdown)
	table.insert(fallbackProfileDropdowns, profileDropdown)
	M.PopulateFallbackProfileDropdown(profileDropdown)
end

---@param container AceGUIContainer
function M.AddSelect(container)
	local profileSelect = DD.utils.AddSection(container, "Profile Select")
	M.AddPrimaryProfileSelect(profileSelect)
	M.AddFallbackProfileSelect(profileSelect)
end

---@param container AceGUIContainer
function M.AddPrimaryProfileSelect(container)
	local profileDropdown = AceGUI:Create("Dropdown") ---@type Dropdown
	profileDropdown:SetLabel("Primary")

	-- Populate the dropdown with profile names
	initPrimaryProfileDropdown(profileDropdown)

	-- Set the current profile as the selected value
	profileDropdown:SetValue(DD.db.database:GetCurrentProfile())

	-- Callback function to handle profile switching
	profileDropdown:SetCallback("OnValueChanged", function(_, _, profileName)
		DD.db.SelectProfile(profileName)
	end)

	container:AddChild(profileDropdown)
end

---@param container AceGUIContainer
function M.AddFallbackProfileSelect(container)
	local profileDropdown = AceGUI:Create("Dropdown") ---@type Dropdown
	-- profileDropdown:SetFullWidth(true)
	profileDropdown:SetLabel("Fallback")

	-- Populate the dropdown with profile names
	initFallbackProfileDropdown(profileDropdown)

	-- Set the current profile as the selected value
	profileDropdown:SetValue(DD.db.database.profile.internal.fallbackProfile)

	-- Callback function to handle profile switching
	profileDropdown:SetCallback("OnValueChanged", function(_, _, profileName)
		DD.db.SelectFallbackProfile(profileName)
	end)

	container:AddChild(profileDropdown)
end

---@param container AceGUIContainer
function M.AddClone(container)
	local profileClone = DD.utils.AddSection(container, "Clone")

	-- Dropdown for selecting the source profile
	local sourceProfileDropdown = AceGUI:Create("Dropdown") ---@type Dropdown
	sourceProfileDropdown:SetLabel("Select Profile to Clone")

	-- Populate the dropdown with available profiles
	initAllProfilesDropdown(sourceProfileDropdown)
	sourceProfileDropdown:SetValue(DD.db.database:GetCurrentProfile()) -- Set current profile as default
	profileClone:AddChild(sourceProfileDropdown)

	-- Text input for new profile name
	local newProfileInput = AceGUI:Create("EditBox") ---@type EditBox
	newProfileInput:SetLabel("New Profile Name")
	-- newProfileInput:SetFullWidth(true)
	newProfileInput:DisableButton(true)
	profileClone:AddChild(newProfileInput)

	-- Clone button
	local cloneButton = AceGUI:Create("Button") ---@type Button
	cloneButton:SetText("Clone")
	cloneButton:SetWidth(100)
	profileClone:AddChild(cloneButton)

	-- Clone button click handler
	cloneButton:SetCallback("OnClick", function()
		local sourceProfileName = sourceProfileDropdown:GetValue()
		local destProfileName = newProfileInput:GetText()

		newProfileInput:SetText("")
		DD.db.CloneProfile(sourceProfileName, destProfileName)
		refreshProfileDropdowns()
	end)
end

---@param container AceGUIContainer
function M.AddDelete(container)
	local profileDelete = DD.utils.AddSection(container, "Delete")

	-- Dropdown for selecting the profile to delete
	local profileDropdown = AceGUI:Create("Dropdown") ---@type Dropdown
	profileDropdown:SetLabel("Select Profile to Delete")

	-- Populate the dropdown with available profiles
	initPrimaryProfileDropdown(profileDropdown)

	profileDelete:AddChild(profileDropdown)

	-- Delete button to reveal confirm option
	local deleteButton = AceGUI:Create("Button") ---@type Button
	deleteButton:SetText("Delete")
	deleteButton:SetWidth(100)

	-- Confirm button (initially hidden)
	local confirmButton = AceGUI:Create("Button") ---@type Button
	confirmButton:SetText("Confirm")
	confirmButton:SetWidth(100)
	confirmButton:SetDisabled(true) -- Hide initially by disabling it

	-- Delete button click handler to reveal Confirm button
	deleteButton:SetCallback("OnClick", function()
		confirmButton:SetDisabled(false) -- Enable confirm button to show it
	end)

	profileDelete:AddChild(deleteButton)
	profileDelete:AddChild(confirmButton)

	-- Confirm button click handler to delete the profile
	confirmButton:SetCallback("OnClick", function()
		DD.db.DeleteProfile(profileDropdown:GetValue())
		profileDropdown:SetValue("")
		confirmButton:SetDisabled(true)
		refreshProfileDropdowns()
	end)

	profileDropdown:SetCallback("OnValueChanged", function()
		confirmButton:SetDisabled(true)
	end)
end

---@param container AceGUIContainer
function M.AddReset(container)
	local profileReset = DD.utils.AddSection(container, "Reset")

	-- Dropdown for selecting the profile to delete
	local profileDropdown = AceGUI:Create("Dropdown") ---@type Dropdown
	profileDropdown:SetLabel("Select Profile to Reset to Defaults")

	-- Populate the dropdown with available profiles
	initPrimaryProfileDropdown(profileDropdown)
	profileReset:AddChild(profileDropdown)

	-- Reset button to reveal confirm option
	local resetButton = AceGUI:Create("Button") ---@type Button
	resetButton:SetText("Reset")
	resetButton:SetWidth(100)

	-- Confirm button (initially hidden)
	local confirmButton = AceGUI:Create("Button") ---@type Button
	confirmButton:SetText("Confirm")
	confirmButton:SetWidth(100)
	confirmButton:SetDisabled(true) -- Hide initially by disabling it

	-- Reset button click handler to reveal Confirm button
	resetButton:SetCallback("OnClick", function()
		confirmButton:SetDisabled(false) -- Enable confirm button to show it
	end)

	profileReset:AddChild(resetButton)
	profileReset:AddChild(confirmButton)

	-- Confirm button click handler to delete the profile
	confirmButton:SetCallback("OnClick", function()
		DD.db.ResetProfile(profileDropdown:GetValue())
		profileDropdown:SetValue("")
		confirmButton:SetDisabled(true)
		refreshProfileDropdowns()
	end)

	profileDropdown:SetCallback("OnValueChanged", function()
		confirmButton:SetDisabled(true)
	end)
end

---@param container AceGUIContainer
function M.AddExport(container)
	local db = DD.db.database
	local profileExport = DD.utils.AddSection(container, "Export")

	-- Dropdown for selecting the profile to export
	local profileDropdown = AceGUI:Create("Dropdown") ---@type Dropdown
	profileDropdown:SetLabel("Select Profile to Export")

	-- Populate the dropdown with available profiles
	initAllProfilesDropdown(profileDropdown)

	profileDropdown:SetValue(db:GetCurrentProfile())
	profileExport:AddChild(profileDropdown)

	-- Multi-line edit box to display the export string
	local exportTextBox = AceGUI:Create("MultiLineEditBox") ---@type MultiLineEditBox
	exportTextBox:SetLabel("Exported Profile String")
	exportTextBox:SetFullWidth(true)
	exportTextBox:SetNumLines(4)
	exportTextBox:SetText("") -- Initially empty
	exportTextBox:DisableButton(true) -- Remove the "Okay" button

	-- Export button
	local exportButton = AceGUI:Create("Button") ---@type Button
	exportButton:SetText("Export")
	exportButton:SetWidth(100)

	local checkbox = AceGUI:Create("CheckBox") ---@type CheckBox
	checkbox:SetLabel("Include fallback profile notes")
	checkbox:SetValue(true) -- Default to unchecked

	-- Export button click handler
	exportButton:SetCallback("OnClick", function()
		exportTextBox:SetText("")
		local profileName = profileDropdown:GetValue()
		local includeFallbackProfile = checkbox:GetValue()
		local encoded = DD.db.ExportProfile(profileName, includeFallbackProfile)
		exportTextBox:SetText(encoded or "")
	end)

	profileExport:AddChild(exportButton)
	profileExport:AddChild(checkbox)
	profileExport:AddChild(exportTextBox)
end

---@param container AceGUIContainer
function M.AddImport(container)
	local profileImport = DD.utils.AddSection(container, "Import")

	-- Text input for the new profile name
	local profileNameInput = AceGUI:Create("EditBox") ---@type EditBox
	profileNameInput:SetLabel("New Profile Name")
	-- profileNameInput:SetFullWidth(true)
	profileNameInput:DisableButton(true) -- Remove the "Okay" button
	profileImport:AddChild(profileNameInput)

	-- Multi-line edit box to paste the import string
	local importTextBox = AceGUI:Create("MultiLineEditBox") ---@type MultiLineEditBox
	importTextBox:SetLabel("Paste Profile String Here")
	importTextBox:SetFullWidth(true)
	importTextBox:SetNumLines(4)
	importTextBox:SetText("") -- Initially empty
	importTextBox:DisableButton(true) -- Remove the "Okay" button

	-- Import button
	local importButton = AceGUI:Create("Button") ---@type Button
	importButton:SetText("Import")
	importButton:SetWidth(100)

	-- Import button click handler
	importButton:SetCallback("OnClick", function()
		local profileName = profileNameInput:GetText()
		local encoded = importTextBox:GetText()
		local success = DD.db.ImportProfile(profileName, encoded)
		if success then
			importTextBox:SetText("")
			refreshProfileDropdowns()
		end
	end)
	profileImport:AddChild(importButton)
	profileImport:AddChild(importTextBox)
end

---@class UI
DD.ui = DD.ui or {}
DD.ui.profile = M
