local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

function DD:SettingsStylePrimary_View(wrapperContainer)
    local refresh = function()
        wrapperContainer:ReleaseChildren()
        DD:SettingsStylePrimary_View(wrapperContainer)
    end

    wrapperContainer:SetLayout("Flow")

    local state = self.db.profile.settings.omniNote

    local container = AceGUI:Create("ScrollFrame")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    wrapperContainer:AddChild(container)


    SettingsStylePrimary_AddDescription(container)
    
    -- Add primary note settings
    local primaryNoteSection = AddSection(container, "")
    if not state.style.primaryNote.useDefaultTextStyle then
        SettingsShared_AddFontSettings(primaryNoteSection, state.style.primaryNote.text)
    end
    SettingsShared_AddCheckBox(
        primaryNoteSection,
        "Use default text style",
        state.style.primaryNote,
        "useDefaultTextStyle",
        refresh
    )
end

function SettingsStylePrimary_AddDescription(frame)
    -- Create a title label
    local title = AceGUI:Create("Label")
    title:SetText("|cffffd700Primary Note|r")    -- Gold-colored text for the title
    title:SetFont(GameFontNormalLarge:GetFont()) -- Use a larger font for the title
    title:SetFullWidth(true)                     -- Stretch across the frame
    frame:AddChild(title)

    -- Create an explanation label
    -- local explanation = AceGUI:Create("Label")
    -- explanation:SetText(
    -- "Displays a note on a per-target basis.")
    -- explanation:SetFullWidth(true)            -- Stretch across the frame
    -- explanation:SetFont(GameFontNormal:GetFont()) -- Standard font for the explanation
    -- frame:AddChild(explanation)
end