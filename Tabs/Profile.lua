local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

local allProfilesDropdowns = {}

local profileDropdowns = {}

local fallbackProfileDropdowns = {}

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

function DungeonDocs:PopulateAllProfilesDropdown(profileDropdown)
    local profiles = {}
    for _, profileName in ipairs(self.db:GetProfiles()) do
        profiles[profileName] = profileName -- Use profile name as both key and display text
    end
    profileDropdown:SetList(profiles)
end

function DungeonDocs:PopulatePrimaryProfileDropdown(profileDropdown)
    local profiles = {}
    for _, profileName in ipairs(self.db:GetProfiles()) do
        if not Profiles_IsReservedProfile(profileName) then
            profiles[profileName] = profileName -- Use profile name as both key and display text
        end
    end
    profileDropdown:SetList(profiles)
end

function DungeonDocs:PopulateFallbackProfileDropdown(profileDropdown)
    local fallbackProfiles = {
        ["None*"] = "None*",
    }
    for _, profileName in ipairs(self.db:GetProfiles()) do
        fallbackProfiles[profileName] = profileName -- Use profile name as both key and display text
    end
    profileDropdown:SetList(fallbackProfiles)
end

local function refreshProfileDropdowns()
    for _, dropdown in ipairs(allProfilesDropdowns) do
        DungeonDocs:PopulateAllProfilesDropdown(dropdown)
    end
    for _, dropdown in ipairs(profileDropdowns) do
        DungeonDocs:PopulatePrimaryProfileDropdown(dropdown)
    end
    for _, dropdown in ipairs(fallbackProfileDropdowns) do
        DungeonDocs:PopulateFallbackProfileDropdown(dropdown)
    end
end

local function initAllProfilesDropdown(profileDropdown)
    table.insert(allProfilesDropdowns, profileDropdown)
    DungeonDocs:PopulateAllProfilesDropdown(profileDropdown)
end

local function initPrimaryProfileDropdown(profileDropdown)
    table.insert(profileDropdowns, profileDropdown)
    DungeonDocs:PopulatePrimaryProfileDropdown(profileDropdown)
end

local function initFallbackProfileDropdown(profileDropdown)
    table.insert(fallbackProfileDropdowns, profileDropdown)
    DungeonDocs:PopulateFallbackProfileDropdown(profileDropdown)
end

function DungeonDocs:Profile_AddSelect(container)
    local profileSelect = AddSection(container, "Profile Select")
    DungeonDocs:Profile_AddPrimaryProfileSelect(profileSelect)
    DungeonDocs:Profile_AddFallbackProfileSelect(profileSelect)
end

function DungeonDocs:Profile_AddPrimaryProfileSelect(container)
    local profileDropdown = AceGUI:Create("Dropdown")
    -- profileDropdown:SetFullWidth(true)
    profileDropdown:SetLabel("Primary")


    -- Populate the dropdown with profile names
    initPrimaryProfileDropdown(profileDropdown)

    -- Set the current profile as the selected value
    profileDropdown:SetValue(self.db:GetCurrentProfile())

    -- Callback function to handle profile switching
    profileDropdown:SetCallback("OnValueChanged", function(_, _, profileName)
        DungeonDocs:DB_SelectProfile(profileName)
    end)

    container:AddChild(profileDropdown)
end

function DungeonDocs:Profile_AddFallbackProfileSelect(container)
    local profileDropdown = AceGUI:Create("Dropdown")
    -- profileDropdown:SetFullWidth(true)
    profileDropdown:SetLabel("Fallback")


    -- Populate the dropdown with profile names
    initFallbackProfileDropdown(profileDropdown)

    -- Set the current profile as the selected value
    profileDropdown:SetValue(self.db.profile.internal.fallbackProfile)

    -- Callback function to handle profile switching
    profileDropdown:SetCallback("OnValueChanged", function(_, _, profileName)
        DungeonDocs:DB_SelectFallbackProfile(profileName)
    end)

    container:AddChild(profileDropdown)
end

function DungeonDocs:Profile_AddClone(container)
    local profileClone = AddSection(container, "Clone")

    -- Dropdown for selecting the source profile
    local sourceProfileDropdown = AceGUI:Create("Dropdown")
    sourceProfileDropdown:SetLabel("Select Profile to Clone")

    -- Populate the dropdown with available profiles
    initAllProfilesDropdown(sourceProfileDropdown)
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
    initPrimaryProfileDropdown(profileDropdown)

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
    initPrimaryProfileDropdown(profileDropdown)
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
    initAllProfilesDropdown(profileDropdown)

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

    local checkbox = AceGUI:Create("CheckBox")
    checkbox:SetLabel("Include fallback profile notes")
    checkbox:SetValue(true) -- Default to unchecked

    -- Export button click handler
    exportButton:SetCallback("OnClick", function()
        exportTextBox:SetText("")
        local profileName = profileDropdown:GetValue()
        local includeFallbackProfile = checkbox:GetValue()
        local encoded = DungeonDocs:DB_ExportProfile(profileName, includeFallbackProfile)
        exportTextBox:SetText(encoded)
    end)


    profileExport:AddChild(exportButton)
    profileExport:AddChild(checkbox)
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
            importTextBox:SetText("")
            refreshProfileDropdowns()
        end
    end)
    profileImport:AddChild(importButton)
    profileImport:AddChild(importTextBox)
end
