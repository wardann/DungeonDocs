-- Initialize the addon using AceAddon-3.0
local DungeonDocs = LibStub("AceAddon-3.0"):NewAddon("DungeonDocs", "AceConsole-3.0", "AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0")



function DungeonDocs:OnInitialize()
    -- Initialize AceDB-3.0 with the defaults
    local dbDefaults = DungeonDocs:GetDBDefaults()
    -- The third argument 'true' indicates that profiles are enabled
    self.db = LibStub("AceDB-3.0"):New("DungeonDocsDB", dbDefaults, true)

    -- Init dungeons
    DungeonDocs:InitAraKara()
    DungeonDocs:InitNotePanels()
end

function DungeonDocs:OnEnable()
    -- Register for the event when the player changes target
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "Notes_SyncNotesWithTarget")
end

-- Register slash command
DungeonDocs:RegisterChatCommand("dungeondocs", "OpenUI")
DungeonDocs:RegisterChatCommand("dd", "OpenUI")


function DungeonDocs:OpenUI()
    -- Create the main frame
    local frame = AceGUI:Create("Frame")
    frame:SetStatusText("Status Bar")
    frame:SetLayout("Fill") -- Important for TabGroup to fill the frame
    frame:SetWidth(700)
    frame:SetHeight(800)

    -- Create the TabGroup
    local tab = AceGUI:Create("TabGroup")
    tab:SetLayout("Fill") -- Use 'Fill' since each tab will manage its own layout
    tab:SetTabs({
        { text = "Docs",  value = "docs" },
        { text = "Settings", value = "settings" },
    })
    tab:SetCallback("OnGroupSelected", function(container, event, group)
        container:ReleaseChildren()
        if group == "docs" then
            DungeonDocs:ShowDocsTab(container)
        elseif group == "settings" then
            DungeonDocs:ShowSettingsTab(container)
        end
    end)
    tab:SelectTab("docs") -- Default tab to display
    frame:AddChild(tab)
end


