-- Initialize the addon using AceAddon-3.0
local addonName = ...
local DungeonDocs = LibStub("AceAddon-3.0"):NewAddon("DungeonDocs", "AceConsole-3.0", "AceEvent-3.0")
local DD = DungeonDocs
local AceGUI = LibStub("AceGUI-3.0")

Version = ""

function DungeonDocs:OnInitialize()
    Version = C_AddOns.GetAddOnMetadata(addonName, "Version")

    -- Create DB
    self.db = LibStub("AceDB-3.0"):New("DungeonDocsDB")

    -- Init default profiles
    DD:Profiles_Init()

    -- Init DB
    DD:DB_Init()

    -- Init dungeons
    DD:Dungeons_InitAll()

    DD:Movers_Init()

    DD:OmniNote_Init()
end

-- Register slash command
DungeonDocs:RegisterChatCommand("dungeondocs", "OpenUI")
DungeonDocs:RegisterChatCommand("dd", "OpenUI")


local dungeonDocsFrame = nil
local dungeonDocsWindowPosition = {
    X = nil,
    Y = nil,
}
local dungeonDocsWindowSize = {
    width = nil,
    height = nil,
}

function DungeonDocs:OpenUI(msg)
    -- Split the input into the first argument and the rest
    local arg1 = msg:match("^(%S*)%s*(.-)$")

    if arg1 == "debug:db:profiles" then
        LogTableToBugSack("db.profiles", self.db.profiles)
        return
    end

    if arg1 == "report" then
        DungeonDocs:HandleReport()
        return
    end

    if arg1 == "reset-database" then
        for profileName in pairs(self.db.profiles) do
            self.db.profiles[profileName] = nil
        end
        Log("Database has been reset")
        return
    end

    if dungeonDocsFrame and dungeonDocsFrame:IsShown() then
        dungeonDocsFrame:Hide() -- Toggle the UI closed if it's open and return
        return
    end

    -- Create the main frame
    local frame = AceGUI:Create("Frame")
    frame:SetCallback("OnClose", function(widget)
        -- Store size and position for future runs
        dungeonDocsWindowSize.height = frame.frame:GetHeight()
        dungeonDocsWindowSize.width = frame.frame:GetWidth()
        dungeonDocsWindowPosition.X = frame.frame:GetLeft()
        dungeonDocsWindowPosition.Y = frame.frame:GetTop()

        dungeonDocsFrame = nil -- Reset the reference when the window is closed
        widget:Release()       -- Clean up the frame resources
    end)
    dungeonDocsFrame = frame

    frame:SetStatusText("DungeonDocs - " .. Version)
    frame:SetLayout("Fill") -- Important for TabGroup to fill the frame

    -- -- Define max size based on 80% of screen dimensions
    local maxWidth = UIParent:GetWidth() * 0.8
    local maxHeight = UIParent:GetHeight() * 0.8

    local initWidth = math.min(850, maxWidth)
    local initHeight = math.min(850, maxHeight)

    local storedWidth = dungeonDocsWindowSize.width
    local storedHeight = dungeonDocsWindowSize.height

    frame:SetAutoAdjustHeight(false)
    frame:SetWidth(storedWidth and storedWidth or initWidth)
    frame:SetHeight(storedHeight and storedHeight or initHeight)

    -- Function to enforce max size on resize
    local function EnforceMaxSizeAndStore()
        local currentWidth = frame.frame:GetWidth()
        local currentHeight = frame.frame:GetHeight()

        -- Cap the width and height to the max size
        if currentWidth > maxWidth then
            frame:SetWidth(maxWidth)
            currentWidth = maxWidth
        end
        if currentHeight > maxHeight then
            frame:SetHeight(maxHeight)
            currentHeight = maxHeight
        end
    end

    -- Hook to resize events and enforce max size
    frame.frame:SetScript("OnSizeChanged", EnforceMaxSizeAndStore)

    local underlyingFrame = frame.frame
    underlyingFrame:SetMovable(true)
    underlyingFrame:EnableMouse(true)
    underlyingFrame:RegisterForDrag("LeftButton")

    -- Load saved window position
    if dungeonDocsWindowPosition.X and dungeonDocsWindowPosition.Y then
        underlyingFrame:ClearAllPoints()
        underlyingFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", dungeonDocsWindowPosition.X,
            dungeonDocsWindowPosition.Y)
    end

    -- Set the drag scripts
    underlyingFrame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)

    underlyingFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        -- Save the current position
    end)

    -- Create the TabGroup
    local tab = AceGUI:Create("TabGroup")
    tab:SetLayout("Fill") -- Use 'Fill' since each tab will manage its own layout
    tab:SetTabs({
        { text = "Docs",     value = "docs" },
        { text = "Settings", value = "settings" },
        { text = "Profiles", value = "profiles" },
        { text = "Help",     value = "help" },
    })
    tab:SetCallback("OnGroupSelected", function(container, event, group)
        container:ReleaseChildren()

        -- Remove character model display to prevent accidental rendering when in a different tab
        DungeonDocs:ClearModels()

        if group == "docs" then
            DungeonDocs:ShowDocsTab(container)
        elseif group == "settings" then
            DungeonDocs:Settings_Tab(container)
        elseif group == "profiles" then
            DungeonDocs:Profile_TabRoot(container)
        elseif group == "help" then
            DungeonDocs:Help_Tab(container)
        end
    end)
    tab:SelectTab("docs") -- Default tab to display
    frame:AddChild(tab)
end

function DungeonDocs:HandleReport()
    local targetId = GetMobIDFromGUID("target")
    if not targetId then
        return
    end

    local currentInstanceName, currentInstanceType = GetInstanceInfo()
    if currentInstanceType ~= "party" then
        return
    end

    local dungeonName = DD:Dungeons_GetCurrentDungeon()
    local ddid = DD:Dungeons_MobIDToDDID(targetId, dungeonName)

    if not ddid then
        return
    end

    local primaryNote = DD:DB_GetNotePrimary(currentInstanceName, ddid, "primaryNote")

    if not primaryNote or primaryNote == "" then
        return
    end

    local targetName = UnitName("target")

    local message = "{rt8} " .. targetName .. " {rt8}\n" .. primaryNote
    LogToGroup(message)
end

function LogToGroup(message)
    local function sendMultiLineMsg(message, channel)
        for line in message:gmatch("[^\n]+") do
            SendChatMessage(line, channel)
        end
    end

    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        -- Player is in an instance group (e.g., dungeon finder or raid finder)
        sendMultiLineMsg(message, "INSTANCE_CHAT")
    elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
        -- Player is in a regular party or raid group
        sendMultiLineMsg(message, "PARTY")
    else
        sendMultiLineMsg(message, "SAY")
    end
end
