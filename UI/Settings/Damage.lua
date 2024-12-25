--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI

--- @class UI
DD.ui = DD.ui or {}

--- @class SettingsUI
DD.ui.settings = DD.ui.settings or {}

---@param container AceGUIContainer
function DD.ui.settings.StyleRoleDamage_View(container)
	local refresh = function()
		container:ReleaseChildren()
		DD.ui.settings.StyleRoleDamage_View(container)
	end
	container:SetLayout("Flow")

	local state = DD.db.database.profile.settings.omniNote

	local scrollFrame = AceGUI:Create("ScrollFrame") ---@type ScrollFrame
	scrollFrame:SetLayout("Flow")
	scrollFrame:SetFullWidth(true)
	scrollFrame:SetFullHeight(true)
	container:AddChild(scrollFrame)

	DD.ui.settings.StyleRoleDamage_AddDescription(scrollFrame)

	--
	--
	-- Damage role note section
	--
	--
	local damageRoleNoteSection = DD.utils.AddSection(scrollFrame, "")
	local damageHeaderInput = AceGUI:Create("EditBox") ---@type EditBox
	damageHeaderInput:SetLabel("Header")
	damageHeaderInput:SetText(state.damageHeader)
	damageHeaderInput:DisableButton(true)
	damageHeaderInput:SetCallback("OnTextChanged", function(_, _, value)
		DD.db.UpdateDB(function()
			state.damageHeader = value
		end)
	end)
	damageRoleNoteSection:AddChild(damageHeaderInput)

	DD.utils.AddSpacer(damageRoleNoteSection)

	-- Use default role header
	DD.ui.shared.AddCheckBox(
		damageRoleNoteSection,
		"Use Default Role Header",
		state.style.damageHeader,
		"useDefaultRoleHeaderStyle",
		refresh
	)

	-- Use default text style
	DD.ui.shared.AddCheckBox(
		damageRoleNoteSection,
		"Use Default Text Style",
		state.style.damageNote,
		"useDefaultTextStyle",
		refresh
	)

	if not state.style.damageHeader.useDefaultRoleHeaderStyle then
		local damageHeaderStyleSection = DD.utils.AddSection(scrollFrame, "Damage Header Style")
		DD.ui.shared.AddFontSettings(damageHeaderStyleSection, state.style.damageHeader.text)
	end

	if not state.style.damageNote.useDefaultTextStyle then
		local damageNoteStyleSection = DD.utils.AddSection(scrollFrame, "Damage Note Style")
		DD.ui.shared.AddFontSettings(damageNoteStyleSection, state.style.damageNote.text)
	end
end

---@param container AceGUIContainer
function DD.ui.settings.StyleRoleDamage_AddDescription(container)
	-- Create a title label
	local title = AceGUI:Create("Label") ---@type Label
	title:SetText("|cffffd700Damage Notes Style|r") -- Gold-colored text for the title
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
