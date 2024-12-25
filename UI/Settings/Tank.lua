--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI

--- @class UI
DD.ui = DD.ui or {}

--- @class SettingsUI
DD.ui.settings = DD.ui.settings or {}

---@param container AceGUIContainer
function DD.ui.settings.StyleRoleTank_View(container)
	local refresh = function()
		container:ReleaseChildren()
		DD.ui.settings.StyleRoleTank_View(container)
	end
	container:SetLayout("Flow")

	local state = DD.db.database.profile.settings.omniNote

	local scrollFrame = AceGUI:Create("ScrollFrame")
	scrollFrame:SetLayout("Flow")
	scrollFrame:SetFullWidth(true)
	scrollFrame:SetFullHeight(true)
	container:AddChild(scrollFrame)

	DD.ui.settings.StyleRoleTank_AddDescription(scrollFrame)

	--
	--
	-- Tank role note section
	--
	--
	local tankRoleNoteSection = DD.utils.AddSection(scrollFrame, "")
	local tankHeaderInput = AceGUI:Create("EditBox") ---@type EditBox
	tankHeaderInput:SetLabel("Header")
	tankHeaderInput:SetText(state.tankHeader)
	tankHeaderInput:DisableButton(true)
	tankHeaderInput:SetCallback("OnTextChanged", function(_, _, value)
		DD.db.UpdateDB(function()
			state.tankHeader = value
		end)
	end)
	tankRoleNoteSection:AddChild(tankHeaderInput)

	DD.utils.AddSpacer(tankRoleNoteSection)

	-- Use default role header
	DD.ui.shared.AddCheckBox(
		tankRoleNoteSection,
		"Use Default Role Header",
		state.style.tankHeader,
		"useDefaultRoleHeaderStyle",
		refresh
	)

	-- Use default text style
	DD.ui.shared.AddCheckBox(
		tankRoleNoteSection,
		"Use Default Text Style",
		state.style.tankNote,
		"useDefaultTextStyle",
		refresh
	)

	if not state.style.tankHeader.useDefaultRoleHeaderStyle then
		local tankHeaderStyleSection = DD.utils.AddSection(scrollFrame, "Tank Header Style")
		DD.ui.shared.AddFontSettings(tankHeaderStyleSection, state.style.tankHeader.text)
	end

	if not state.style.tankNote.useDefaultTextStyle then
		local tankNoteStyleSection = DD.utils.AddSection(scrollFrame, "Tank Note Style")
		DD.ui.shared.AddFontSettings(tankNoteStyleSection, state.style.tankNote.text)
	end
end

---@param container AceGUIContainer
function DD.ui.settings.StyleRoleTank_AddDescription(container)
	-- Create a title label
	local title = AceGUI:Create("Label") ---@type Label
	title:SetText("|cffffd700Tank Notes Style|r") -- Gold-colored text for the title
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
