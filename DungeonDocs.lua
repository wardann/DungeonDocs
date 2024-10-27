-- Initialize the addon using AceAddon-3.0
local DungeonDocs = LibStub("AceAddon-3.0"):NewAddon("DungeonDocs", "AceConsole-3.0", "AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0")

Version = "v0.0.1 (alpha)"


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
    local internal = self.db.profile.internal

    -- Create the main frame
    local frame = AceGUI:Create("Frame")
    frame:SetStatusText("DungeonDocs - ".. Version)
    frame:SetLayout("Fill") -- Important for TabGroup to fill the frame

    -- -- Define max size based on 80% of screen dimensions
    local maxWidth = UIParent:GetWidth() * 0.8
    local maxHeight = UIParent:GetHeight() * 0.8

    -- Initial frame size within limits
    frame:SetWidth(math.min(700, maxWidth)) -- 700 is an initial width
    frame:SetHeight(math.min(800, maxHeight)) -- 800 is an initial height

    -- Function to enforce max size on resize
    local function EnforceMaxSize()
        local currentWidth = frame.frame:GetWidth()
        local currentHeight = frame.frame:GetHeight()

        -- Cap the width and height to the max size
        if currentWidth > maxWidth then
            frame:SetWidth(maxWidth)
        end
        if currentHeight > maxHeight then
            frame:SetHeight(maxHeight)
        end
    end

    -- Hook to resize events and enforce max size
    frame.frame:SetScript("OnSizeChanged", EnforceMaxSize)


    local underlyingFrame = frame.frame
    underlyingFrame:SetMovable(true)
    underlyingFrame:EnableMouse(true)
    underlyingFrame:RegisterForDrag("LeftButton")

    -- Load saved window position
    if internal.windowPositionX and internal.windowPositionY then
        underlyingFrame:ClearAllPoints()
        underlyingFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", internal.windowPositionX, internal.windowPositionY)
    end

    -- Set the drag scripts
    underlyingFrame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)

    underlyingFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        -- Save the current position
        internal.windowPositionX = self:GetLeft()
        internal.windowPositionY = self:GetTop()
    end)

    -- Create the TabGroup
    local tab = AceGUI:Create("TabGroup")
    tab:SetLayout("Fill") -- Use 'Fill' since each tab will manage its own layout
    tab:SetTabs({
        { text = "Docs",     value = "docs" },
        { text = "Settings", value = "settings" },
        { text = "Profiles", value = "profiles" },
    })
    tab:SetCallback("OnGroupSelected", function(container, event, group)
        container:ReleaseChildren()
        if group == "docs" then
            DungeonDocs:ShowDocsTab(container)
        elseif group == "settings" then
            DungeonDocs:ShowSettingsTab(container)
        elseif group == "profiles" then
            DungeonDocs:Profile_TabRoot(container)
        end
    end)
    tab:SelectTab("docs") -- Default tab to display
    frame:AddChild(tab)
end
