---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI

---@class Developer
local M = {}

local devFrame = nil
local devFrameWindowPosition = {
	X = nil,
	Y = nil,
}
local devFrameWindowSize = {
	width = nil,
	height = nil,
}

function M.Init()
    if not DD.db.database.profile.internal.developerModeEnabled then
        return
    end

    DD.developer.db.Init()

    DD.utils.Log("Developer mode enabled")
end

function M.OpenUI()
	if devFrame and devFrame:IsShown() then
		devFrame:Hide() -- Toggle the UI closed if it's open and return
		return
	end

	-- Create the main frame
	local mainFrame = AceGUI:Create("Frame") ---@type AceGUIFrame
	mainFrame:SetCallback("OnClose", function(widget)
		-- Store size and position for future runs
		devFrameWindowSize.height = mainFrame.frame:GetHeight()
		devFrameWindowSize.width = mainFrame.frame:GetWidth()
		devFrameWindowPosition.X = mainFrame.frame:GetLeft()
		devFrameWindowPosition.Y = mainFrame.frame:GetTop()

		devFrame = nil -- Reset the reference when the window is closed
		widget:Release() -- Clean up the frame resources
	end)
	devFrame = mainFrame

	mainFrame:SetStatusText("Dev Mode")
	mainFrame:SetTitle("DungeonDocs")
	mainFrame:SetLayout("Fill") -- Important for TabGroup to fill the frame

	-- -- Define max size based on 95% of screen dimensions
	local maxWidth = UIParent:GetWidth() * 0.95
	local maxHeight = UIParent:GetHeight() * 0.95

	local initWidth = math.min(850, maxWidth)
	local initHeight = math.min(850, maxHeight)

	local storedWidth = devFrameWindowSize.width
	local storedHeight = devFrameWindowSize.height

	mainFrame:SetAutoAdjustHeight(false)
	mainFrame:SetWidth(storedWidth and storedWidth or initWidth)
	mainFrame:SetHeight(storedHeight and storedHeight or initHeight)

	-- Function to enforce max size on resize
	local function EnforceMaxSizeAndStore()
		local currentWidth = mainFrame.frame:GetWidth()
		local currentHeight = mainFrame.frame:GetHeight()

		-- Cap the width and height to the max size
		if currentWidth > maxWidth then
			mainFrame:SetWidth(maxWidth)
		end
		if currentHeight > maxHeight then
			mainFrame:SetHeight(maxHeight)
		end
	end

	-- Hook to resize events and enforce max size
	mainFrame.frame:SetScript("OnSizeChanged", EnforceMaxSizeAndStore)

	local frame = mainFrame.frame
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")

	-- Load saved window position
	if devFrameWindowPosition.X and devFrameWindowPosition.Y then
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", devFrameWindowPosition.X, devFrameWindowPosition.Y)
	end

	-- Set the drag scripts
	frame:SetScript("OnDragStart", function(s)
		s:StartMoving()
	end)

	frame:SetScript("OnDragStop", function(s)
		s:StopMovingOrSizing()
		-- Save the current position
	end)

	-- Create the TabGroup
	---@type AceGUITabGroup
	local tab = AceGUI:Create("TabGroup")
	tab:SetLayout("Fill") -- Use 'Fill' since each tab will manage its own layout
	tab:SetTabs({
		{ text = "State", value = "state" },
		{ text = "Capture", value = "capture" },
	})
	tab:SetCallback("OnGroupSelected", function(container, _, group)
		container:ReleaseChildren()

        DD.utils.Log("Selected group: " .. group)
	end)
	tab:SelectTab("state") -- Default tab to display
	mainFrame:AddChild(tab)

    DD.utils.Log("capture: " .. DD.developer.database.profile.capture)
    DD.developer.database.profile.capture = DD.developer.database.profile.capture + 1
end

DD.developer = M