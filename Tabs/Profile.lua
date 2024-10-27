local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

local profileDropdowns = {}

function DungeonDocs:Profile_TabRoot(wrapperContainer)
    wrapperContainer:SetLayout("Flow")

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)

    DungeonDocs:Profile_AddSelect(container)
    DungeonDocs:Profile_AddClone(container)
    DungeonDocs:Profile_AddDelete(container)
    DungeonDocs:Profile_AddReset(container)
    DungeonDocs:Profile_AddImport(container)
    DungeonDocs:Profile_AddExport(container)
end

function DungeonDocs:PopulateProfileDropdown(profileDropdown)
    local profiles = {}
    for _, profileName in ipairs(self.db:GetProfiles()) do
        profiles[profileName] = profileName     -- Use profile name as both key and display text
    end
    profileDropdown:SetList(profiles)
end

local function refreshProfileDropdowns()
    for _, dropdown in ipairs(profileDropdowns) do
        DungeonDocs:PopulateProfileDropdown(dropdown)
    end
end

local function initProfileDropdown(profileDropdown)
    table.insert(profileDropdowns, profileDropdown)
    DungeonDocs:PopulateProfileDropdown(profileDropdown)
end

function DungeonDocs:Profile_AddSelect(container)
    local profileSelect = AddSection(container, "Active")

    local profileDropdown = AceGUI:Create("Dropdown")
    profileDropdown:SetFullWidth(true)
    profileDropdown:SetLabel("Select Profile to Activate")


    -- Populate the dropdown with profile names
    initProfileDropdown(profileDropdown)

    -- Set the current profile as the selected value
    profileDropdown:SetValue(self.db:GetCurrentProfile())

    -- Callback function to handle profile switching
    profileDropdown:SetCallback("OnValueChanged", function(_, _, profileName)
        DungeonDocs:DB_SelectProfile(profileName)
    end)

    profileSelect:AddChild(profileDropdown)
end

function DungeonDocs:Profile_AddClone(container)
    local profileClone = AddSection(container, "Clone")

    -- Dropdown for selecting the source profile
    local sourceProfileDropdown = AceGUI:Create("Dropdown")
    sourceProfileDropdown:SetLabel("Select Profile to Clone")

    -- Populate the dropdown with available profiles
    initProfileDropdown(sourceProfileDropdown)
    sourceProfileDropdown:SetValue(self.db:GetCurrentProfile()) -- Set current profile as default
    profileClone:AddChild(sourceProfileDropdown)

    -- Text input for new profile name
    local newProfileInput = AceGUI:Create("EditBox")
    newProfileInput:SetLabel("New Profile Name")
    -- newProfileInput:SetFullWidth(true)
    newProfileInput:DisableButton(true)
    profileClone:AddChild(newProfileInput)

    -- Clone button
    local cloneButton = AceGUI:Create("Button")
    cloneButton:SetText("Clone")
    cloneButton:SetWidth(100)
    profileClone:AddChild(cloneButton)

    -- Clone button click handler
    cloneButton:SetCallback("OnClick", function()
        local sourceProfileName = sourceProfileDropdown:GetValue()
        local destProfileName = newProfileInput:GetText()

        newProfileInput:SetText("")
        DungeonDocs:DB_CloneProfile(sourceProfileName, destProfileName)
        refreshProfileDropdowns()
    end)
end

function DungeonDocs:Profile_AddDelete(container)
    local profileDelete = AddSection(container, "Delete")

    -- Dropdown for selecting the profile to delete
    local profileDropdown = AceGUI:Create("Dropdown")
    profileDropdown:SetLabel("Select Profile to Delete")


    -- Populate the dropdown with available profiles
    initProfileDropdown(profileDropdown)

    profileDelete:AddChild(profileDropdown)

    -- Delete button to reveal confirm option
    local deleteButton = AceGUI:Create("Button")
    deleteButton:SetText("Delete")
    deleteButton:SetWidth(100)

    -- Confirm button (initially hidden)
    local confirmButton = AceGUI:Create("Button")
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
        DungeonDocs:DB_DeleteProfile(profileDropdown:GetValue())
        profileDropdown:SetValue()
        confirmButton:SetDisabled(true)
        refreshProfileDropdowns()
    end)

    profileDropdown:SetCallback("OnValueChanged", function()
        confirmButton:SetDisabled(true)
    end)
end

function DungeonDocs:Profile_AddReset(container)
    local db = self.db

    local profileReset = AddSection(container, "Reset")

    -- Dropdown for selecting the profile to delete
    local profileDropdown = AceGUI:Create("Dropdown")
    profileDropdown:SetLabel("Select Profile to Reset to Defaults")


    -- Populate the dropdown with available profiles
    initProfileDropdown(profileDropdown)
    profileReset:AddChild(profileDropdown)

    -- Reset button to reveal confirm option
    local resetButton = AceGUI:Create("Button")
    resetButton:SetText("Reset")
    resetButton:SetWidth(100)

    -- Confirm button (initially hidden)
    local confirmButton = AceGUI:Create("Button")
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
        DungeonDocs:DB_ResetProfile(profileDropdown:GetValue())
        profileDropdown:SetValue()
        confirmButton:SetDisabled(true)
        refreshProfileDropdowns()
    end)

    profileDropdown:SetCallback("OnValueChanged", function()
        confirmButton:SetDisabled(true)
    end)
end

function DungeonDocs:Profile_AddExport(container)
    local db = self.db
    local profileExport = AddSection(container, "Export")

    -- Dropdown for selecting the profile to export
    local profileDropdown = AceGUI:Create("Dropdown")
    profileDropdown:SetLabel("Select Profile to Export")

    -- Populate the dropdown with available profiles
    initProfileDropdown(profileDropdown)

    profileDropdown:SetValue(db:GetCurrentProfile())
    profileExport:AddChild(profileDropdown)

    -- Multi-line edit box to display the export string
    local exportTextBox = AceGUI:Create("MultiLineEditBox")
    exportTextBox:SetLabel("Exported Profile String")
    exportTextBox:SetFullWidth(true)
    exportTextBox:SetNumLines(4)
    exportTextBox:SetText("")         -- Initially empty
    exportTextBox:DisableButton(true) -- Remove the "Okay" button

    -- Export button
    local exportButton = AceGUI:Create("Button")
    exportButton:SetText("Export")
    exportButton:SetWidth(100)

    -- Export button click handler
    exportButton:SetCallback("OnClick", function()
        local profileName = profileDropdown:GetValue()
        local encoded = DungeonDocs:DB_ExportProfile(profileName)
        exportTextBox:SetText(encoded)
    end)
    profileExport:AddChild(exportButton)
    profileExport:AddChild(exportTextBox)
end

function DungeonDocs:Profile_AddImport(container)
    local profileImport = AddSection(container, "Import")

    -- Text input for the new profile name
    local profileNameInput = AceGUI:Create("EditBox")
    profileNameInput:SetLabel("New Profile Name")
    -- profileNameInput:SetFullWidth(true)
    profileNameInput:DisableButton(true) -- Remove the "Okay" button
    profileImport:AddChild(profileNameInput)

    -- Multi-line edit box to paste the import string
    local importTextBox = AceGUI:Create("MultiLineEditBox")
    importTextBox:SetLabel("Paste Profile String Here")
    importTextBox:SetFullWidth(true)
    importTextBox:SetNumLines(4)
    importTextBox:SetText("")         -- Initially empty
    importTextBox:DisableButton(true) -- Remove the "Okay" button

    -- Import button
    local importButton = AceGUI:Create("Button")
    importButton:SetText("Import")
    importButton:SetWidth(100)

    -- Import button click handler
    importButton:SetCallback("OnClick", function()
        local profileName = profileNameInput:GetText()
        local encoded = importTextBox:GetText()
        local success = DungeonDocs:DB_ImportProfile(profileName, encoded)
        if success then
            importTextBox:SetText()
            refreshProfileDropdowns()
        end
    end)
    profileImport:AddChild(importButton)
    profileImport:AddChild(importTextBox)
end
