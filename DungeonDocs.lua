---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):NewAddon("DungeonDocs", "AceConsole-3.0", "AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI

local addonName = ... ---@type string
local Version = ""

-- luacheck: ignore
function DD:OnInitialize()
	Version = C_AddOns.GetAddOnMetadata(addonName, "Version") or ""

	DD.db.Init()

	DD.profiles.Init()

	DD.dungeons.Init()

	DD.movers.Init()

	DD.omniNote.Init()
end

---@diagnostic disable
-- Register slash command
DD:RegisterChatCommand("dungeondocs", "OpenUI")
DD:RegisterChatCommand("dd", "OpenUI")
---@diagnostic enable

local dungeonDocsFrame = nil
local dungeonDocsWindowPosition = {
	X = nil,
	Y = nil,
}
local dungeonDocsWindowSize = {
	width = nil,
	height = nil,
}

---@param msg string
function DD:OpenUI(msg)
	-- Split the input into the first argument and the rest
	local arg1 = msg:match("^(%S*)%s*(.-)$")

	if arg1 == "debug:db:profiles" then
		DD.utils.LogTableToBugSack("db.profiles", self.db.database.profiles)
		return
	end

	if arg1 == "report" then
		DD.HandleReport()
		return
	end

	-- if arg1 == "reset-profiles" then
	-- 	for profileName in pairs(DD.db.database.profiles) do
	-- 		DD.db.ResetProfile(profileName)
	-- 	end
	-- 	DD.utils.Log("All profiles have been reset")
	-- 	return
	-- end

	if dungeonDocsFrame and dungeonDocsFrame:IsShown() then
		dungeonDocsFrame:Hide() -- Toggle the UI closed if it's open and return
		return
	end

	-- Create the main frame
	local aceFrame = AceGUI:Create("Frame") ---@type AceGUIFrame
	aceFrame:SetCallback("OnClose", function(widget)
		-- Store size and position for future runs
		dungeonDocsWindowSize.height = aceFrame.frame:GetHeight()
		dungeonDocsWindowSize.width = aceFrame.frame:GetWidth()
		dungeonDocsWindowPosition.X = aceFrame.frame:GetLeft()
		dungeonDocsWindowPosition.Y = aceFrame.frame:GetTop()

		dungeonDocsFrame = nil -- Reset the reference when the window is closed
		widget:Release() -- Clean up the frame resources
	end)
	dungeonDocsFrame = aceFrame

	aceFrame:SetStatusText(Version)
	aceFrame:SetTitle("DungeonDocs")
	aceFrame:SetLayout("Fill") -- Important for TabGroup to fill the frame

	-- -- Define max size based on 95% of screen dimensions
	local maxWidth = UIParent:GetWidth() * 0.95
	local maxHeight = UIParent:GetHeight() * 0.95

	local initWidth = math.min(850, maxWidth)
	local initHeight = math.min(850, maxHeight)

	local storedWidth = dungeonDocsWindowSize.width
	local storedHeight = dungeonDocsWindowSize.height

	aceFrame:SetAutoAdjustHeight(false)
	aceFrame:SetWidth(storedWidth and storedWidth or initWidth)
	aceFrame:SetHeight(storedHeight and storedHeight or initHeight)

	-- Function to enforce max size on resize
	local function EnforceMaxSizeAndStore()
		local currentWidth = aceFrame.frame:GetWidth()
		local currentHeight = aceFrame.frame:GetHeight()

		-- Cap the width and height to the max size
		if currentWidth > maxWidth then
			aceFrame:SetWidth(maxWidth)
		end
		if currentHeight > maxHeight then
			aceFrame:SetHeight(maxHeight)
		end
	end

	-- Hook to resize events and enforce max size
	aceFrame.frame:SetScript("OnSizeChanged", EnforceMaxSizeAndStore)

	local frame = aceFrame.frame
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")

	-- Load saved window position
	if dungeonDocsWindowPosition.X and dungeonDocsWindowPosition.Y then
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", dungeonDocsWindowPosition.X, dungeonDocsWindowPosition.Y)
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
		{ text = "Docs", value = "docs" },
		{ text = "Settings", value = "settings" },
		{ text = "Profiles", value = "profiles" },
		{ text = "Help", value = "help" },
		{ text = "Changelog", value = "changelog" },
	})
	tab:SetCallback("OnGroupSelected", function(container, _, group)
		container:ReleaseChildren()

		-- Remove character model display to prevent accidental rendering when in a different tab
		DD.ui.docs.ClearModels()

		if group == "docs" then
			DD.ui.docs.TabRoot(container)
		elseif group == "settings" then
			DD.ui.settings.TabRoot(container)
		elseif group == "profiles" then
			DD.ui.profile.TabRoot(container)
		elseif group == "changelog" then
			DD.ui.changelog.TabRoot(container)
		elseif group == "help" then
			DD.ui.help.TabRoot(container)
		end
	end)
	tab:SelectTab("docs") -- Default tab to display
	aceFrame:AddChild(tab)
end

function DD.HandleReport()
	local targetId = DD.utils.GetMobIDFromGUID("target")
	if not targetId then
		return
	end

	local currentInstanceName, currentInstanceType = GetInstanceInfo()
	if currentInstanceType ~= "party" then
		return
	end

	local dungeonName = DD.dungeons.GetCurrentDungeon()
	if not dungeonName then
		return
	end
	local ddid = DD.dungeons.MobIDToDDID(targetId, dungeonName)

	if not ddid then
		return
	end

	local primaryNote = DD.db.GetActiveNoteWithFallback(currentInstanceName, ddid, "primaryNote")

	if not primaryNote or primaryNote == "" then
		return
	end

	local targetName = UnitName("target")

	local message = "{rt8} " .. targetName .. " {rt8}\n" .. primaryNote
	DD.utils.LogToGroup(message)
end
