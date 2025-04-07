---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI

local versions = {
	"v0.3.0",
	"v0.3.1",
	"v0.3.2",
	"v0.3.3",
	"v0.3.4",
	"v0.3.5",
	"v0.4.0",
	"v0.5.0",
}

local changelog = {
	["v0.3.0"] = {
		"Stable release",
	},
	["v0.3.1"] = {
		"Fixed a bug that prevented all fonts from loading",
	},
	["v0.3.2"] = {
		"Fixed note typos",
	},
	["v0.3.3"] = {
		"Added a log when rendering a test note",
	},
	["v0.3.4"] = {
		"Fixed Mordretha in Theater of Pain",
	},
	["v0.3.5"] = {
		"Fixed a bug that prevented notes from being displayed",
	},
	["v0.4.0"] = {
		"Added a Changelog tab",
		"Fixed Anub'zekt in Ara-Kara",
	},
	["v0.5.0"] = {
		"Added a 'Clear Test Notes' button",
		"Fixed a bug that prevented target note from being displayed on combat enter",
	},
}

local function tableLength(t)
	local count = 0
	---@diagnostic disable-next-line
	for _ in pairs(t) do
		count = count + 1
	end
	return count
end

if #versions ~= tableLength(changelog) then
	error("Changelog versions and entries do not match")
end

--- Make sure all the versions have a changelog
for _, version in ipairs(versions) do
	if not changelog[version] then
		error("Changelog entry missing for version: " .. version)
	end
end

---@class ChangelogUI
local M = {}

---@param container AceGUIContainer
function M.TabRoot(container)
	container:SetLayout("Flow")

	local scrollFrame = AceGUI:Create("ScrollFrame") ---@type ScrollFrame
	scrollFrame:SetLayout("Flow")
	scrollFrame:SetFullWidth(true)
	scrollFrame:SetFullHeight(true)
	container:AddChild(scrollFrame)

	local state = DD.db.database.profile.settings.omniNote
	local defaultFont = state.style.defaultText.font
	local defaultTitleFont = state.style.noteTitle.text.font

	-- Iterate backwards through the versions so the newest is at the top
	for i = #versions, 1, -1 do
		local version = versions[i]
		local changes = changelog[version]
		local versionLabel = AceGUI:Create("Label") ---@type Label
		versionLabel:SetText("|cffffd700" .. version .. "|r")
		versionLabel:SetFullWidth(true)
		versionLabel.label:SetFont(defaultTitleFont, 18, "OUTLINE")
		scrollFrame:AddChild(versionLabel)

		for _, change in ipairs(changes) do
			local label = AceGUI:Create("Label") ---@type Label
			label:SetText(" - " .. change)
			label:SetFullWidth(true)
			label.label:SetFont(defaultFont, 14, "OUTLINE")
			scrollFrame:AddChild(label)
		end

		-- Add spacer after each version block
		local spacer = AceGUI:Create("Label") ---@type Label
		spacer:SetText(" ") -- Empty or a blank line for spacing
		spacer:SetFullWidth(true)
		scrollFrame:AddChild(spacer)
	end
end

---@class UI
DD.ui = DD.ui or {}
DD.ui.changelog = M

return changelog
