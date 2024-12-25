--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI

--- @class UI
DD.ui = DD.ui or {}

--- @class SettingsUI
DD.ui.settings = DD.ui.settings or {}

---@param container AceGUIContainer
function DD.ui.settings.StylePrimary_View(container)
	local refresh = function()
		container:ReleaseChildren()
		DD.ui.settings.StylePrimary_View(container)
	end

	container:SetLayout("Flow")

	local state = DD.db.database.profile.settings.omniNote

	local scrollFrame = AceGUI:Create("ScrollFrame") ---@type ScrollFrame
	scrollFrame:SetLayout("Flow")
	scrollFrame:SetFullWidth(true)
	scrollFrame:SetFullHeight(true)
	container:AddChild(scrollFrame)

	DD.ui.settings.StylePrimary_AddDescription(scrollFrame)

	-- Add primary note settings
	local primaryNoteSection = DD.utils.AddSection(scrollFrame, "")
	if not state.style.primaryNote.useDefaultTextStyle then
		DD.ui.shared.AddFontSettings(primaryNoteSection, state.style.primaryNote.text)
	end
	DD.ui.shared.AddCheckBox(
		primaryNoteSection,
		"Use default text style",
		state.style.primaryNote,
		"useDefaultTextStyle",
		refresh
	)
end

---@param container AceGUIContainer
function DD.ui.settings.StylePrimary_AddDescription(container)
	-- Create a title label
	local title = AceGUI:Create("Label") --- @type Label
	title:SetText("|cffffd700Primary Note|r") -- Gold-colored text for the title
	title:SetFont(GameFontNormalLarge:GetFont()) -- Use a larger font for the title
	title:SetFullWidth(true) -- Stretch across the frame
	container:AddChild(title)

	-- Create an explanation label
	-- local explanation = AceGUI:Create("Label")
	-- explanation:SetText(
	-- "Displays a note on a per-target basis.")
	-- explanation:SetFullWidth(true)            -- Stretch across the frame
	-- explanation:SetFont(GameFontNormal:GetFont()) -- Standard font for the explanation
	-- frame:AddChild(explanation)
end
