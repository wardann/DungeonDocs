---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI

---@class DocsUI
local M = {}

---@alias TreeNote {
---    value: string,
---    text: string,
---    noteName: string,
---    mobs: DocMob[],
---    isBoss: boolean,
---    ddid: DDID,
---}
---@alias TreeMobOrBoss {
---    value: string,
---    text: string,
---    children: TreeNote[],
---}
---@alias TreeDungeon {
---     value: string,
---     text: string,
---     name: string,
---     icon: string,
---     children: TreeMobOrBoss[],
--- }
---
---@alias TreeData TreeDungeon[]

local treeGroup ---@type TreeGroup

local rightGroup ---@type SimpleGroup

local models = {} ---@type PlayerModel[]

local modelContainers = {} ---@type SimpleGroup[]

local showClearAllTestNotesButton = false

---@param localTreeGroup TreeGroup
---@param treeData TreeData
local function setTreeGroupFocus(localTreeGroup, treeData)
	local targetId = DD.utils.GetMobIDFromGUID("target")
	if not targetId then
		return
	end

	local currentInstanceName = DD.dungeons.GetCurrentDungeon(targetId)
	if not currentInstanceName then
		return
	end

	for _, instance in ipairs(treeData) do
		if instance.name == currentInstanceName then
			for _, mobType in ipairs(instance.children) do
				for _, mobOrBoss in ipairs(mobType.children) do
					for _, mob in ipairs(mobOrBoss.mobs) do
						if mob.id == targetId then
							localTreeGroup:SelectByPath(instance.value, mobType.value, mobOrBoss.value)
							return true
						end
					end
				end
			end
		end
	end

	return false
end

local lastSelected = {}

-- Function to show the Default tab content
---@param container AceGUIContainer
function M.TabRoot(container)
	-- Create a TreeGroup for the hierarchical mob list
	treeGroup = AceGUI:Create("TreeGroup") ---@type TreeGroup
	treeGroup:SetLayout("Fill")
	treeGroup:SetFullWidth(true)
	treeGroup:SetFullHeight(true)
	treeGroup:SetTreeWidth(200, false) -- Set the width of the tree part
	container:AddChild(treeGroup)

	-- Set the tree data
	local treeData = M.DungeonDataToTreeData()
	treeGroup:SetTree(treeData)

	-- Set a callback for when a node is selected
	treeGroup:SetCallback("OnGroupSelected", function(_, _, uniquePath)
		local pathComponents = { strsplit("\001", uniquePath) }
		local numComponents = #pathComponents

		if numComponents < 3 then
			return
		end

		local dungeonName = pathComponents[1] ---@type string
		local enemyType = pathComponents[2] ---@type string
		local noteName = pathComponents[3] ---@type string
		M.HandleSelected(dungeonName, enemyType, noteName)
	end)

	rightGroup = AceGUI:Create("SimpleGroup") ---@type SimpleGroup
	rightGroup:SetFullWidth(true)
	rightGroup:SetFullHeight(true)
	rightGroup:SetLayout("Flow")
	treeGroup:AddChild(rightGroup)

	rightGroup.frame:SetScript("OnSizeChanged", M.UpdateWidthForRenderedModels)

	-- Focus an element in the tree if the player is targeting it
	-- Kicking this off with a very small delay else the model fails
	-- to load for some reason
	C_Timer.After(0.01, function()
		local groupWasFocused = setTreeGroupFocus(treeGroup, treeData)
		if not groupWasFocused and #lastSelected == 3 then
			treeGroup:SelectByPath(lastSelected[1], lastSelected[2], lastSelected[3])
		end
	end)
end

---@param dungeonName DungeonName
---@param docStruct DocStructure
local function resetNote(dungeonName, docStruct)
	DD.db.SetNote(dungeonName, docStruct.ddid, "primaryNote", nil)
	DD.db.SetNote(dungeonName, docStruct.ddid, "tankNote", nil)
	DD.db.SetNote(dungeonName, docStruct.ddid, "healerNote", nil)
	DD.db.SetNote(dungeonName, docStruct.ddid, "damageNote", nil)
end

function M.ClearModels()
	for _, model in pairs(models) do
		model:ClearModel()
		model:SetParent(nil)
		model:Hide()
	end
	models = {}

	for _, modelContainer in pairs(modelContainers) do
		if modelContainer and modelContainer.frame and modelContainer.frame:IsShown() then
			modelContainer:Release()
		end
	end
	modelContainers = {}
end

---@param numMobs number
---@return number
function M.CalculateWidthPerModel(numMobs)
	local buffer = 1
	local totalWidth = rightGroup.frame:GetWidth() or 0
	if totalWidth <= 0 then
		return 0 -- Prevent invalid widths
	end
	return ((1 / numMobs) * totalWidth) - buffer
end

function M.UpdateWidthForRenderedModels()
	local numMobs = #models
	local width = M.CalculateWidthPerModel(numMobs)

	for _, model in pairs(models) do
		model:SetSize(width, 200)
	end

	for _, modelContainer in pairs(modelContainers) do
		modelContainer:SetWidth(width)
	end
end

---@param dungeonName string
---@param enemyType "boss"|"trash"
---@param docName string
function M.HandleSelected(dungeonName, enemyType, docName)
	local rerender = function()
		M.HandleSelected(dungeonName, enemyType, docName)
	end

	local docStructures = DD.dungeons.List[dungeonName].docStructures
	local docStruct ---@type DocStructure

	-- Find the boss in the database
	for _, ds in ipairs(docStructures) do
		if ds.docName == docName then
			docStruct = ds
		end
	end

	-- Clean up previous runs
	rightGroup:ReleaseChildren()
	M.ClearModels()

	-- Add a title for the page
	local titleLabel = AceGUI:Create("Label") ---@type Label
	titleLabel:SetText(docStruct.docName)
	titleLabel:SetFontObject(GameFontNormalLarge) -- Sets the font to a larger style
	titleLabel.label:SetJustifyH("CENTER")
	titleLabel:SetFullWidth(true)
	titleLabel.label:SetJustifyH("CENTER")
	rightGroup:AddChild(titleLabel)

	local mobsToRender = {}
	for _, mob in ipairs(docStruct.mobs) do
		if not mob.hideModel then
			table.insert(mobsToRender, mob)
		end
	end

	if enemyType == "trash" then
		mobsToRender = { docStruct.mobs[1] }
	end

	-- Render character models
	for _, mob in ipairs(mobsToRender) do
		local numMobs = #mobsToRender
		local widthPerModel = M.CalculateWidthPerModel(numMobs)

		local modelContainer = AceGUI:Create("SimpleGroup") ---@type SimpleGroup

		-- Render enemy model
		modelContainer:SetWidth(widthPerModel)
		modelContainer:SetHeight(200)
		modelContainer:SetLayout("Fill")
		table.insert(modelContainers, modelContainer)
		rightGroup:AddChild(modelContainer)

		---@type PlayerModel
		local model = CreateFrame("PlayerModel", nil, modelContainer.frame) --[[@as PlayerModel]]
		model:SetPoint("CENTER")
		model:SetSize(widthPerModel, 200)
		model:SetCamDistanceScale(1.5)
		model:SetModelScale(1)
		model:SetDisplayInfo(mob.displayId)

		table.insert(models, model)
	end

	local scrollFrame = AceGUI:Create("ScrollFrame") ---@type ScrollFrame
	scrollFrame:SetLayout("Flow")
	scrollFrame:SetFullWidth(true)
	scrollFrame:SetFullHeight(true)
	rightGroup:AddChild(scrollFrame)

	M.RenderNote(dungeonName, docStruct, "primaryNote", "Primary notes", scrollFrame)
	M.RenderNote(dungeonName, docStruct, "tankNote", "Tank notes", scrollFrame)
	M.RenderNote(dungeonName, docStruct, "healerNote", "Healer notes", scrollFrame)
	M.RenderNote(dungeonName, docStruct, "damageNote", "DPS notes", scrollFrame)

	local testNoteButton = AceGUI:Create("Button") ---@type Button
	testNoteButton:SetText("Render Notes")
	testNoteButton:SetFullWidth(true)
	testNoteButton:SetCallback("OnClick", function()
		local inCombat = UnitAffectingCombat("player")
		if inCombat then
			DD.utils.Log("Can't render test note while in combat")
			return
		end

		showClearAllTestNotesButton = true
		DD.omniNote.RenderTestNote(docStruct.ddid, dungeonName)
		rerender()
	end)
	scrollFrame:AddChild(testNoteButton)

	if showClearAllTestNotesButton then
		local clearAllTestNotesButton = AceGUI:Create("Button") ---@type Button
		clearAllTestNotesButton:SetText("Clear Test Notes")
		clearAllTestNotesButton:SetFullWidth(true)
		clearAllTestNotesButton:SetCallback("OnClick", function()
			local inCombat = UnitAffectingCombat("player")
			if inCombat then
				DD.utils.Log("Cannot clear notes while in combat")
				return
			end

			DD.omniNote.ClearNotes()
			showClearAllTestNotesButton = false
			rerender()
		end)
		scrollFrame:AddChild(clearAllTestNotesButton)
	end

	local button = AceGUI:Create("Button") ---@type Button
	local resetButtonText = "Reset Notes to Fallback Profile"
	button:SetText(resetButtonText)
	button:SetFullWidth(true)

	local confirming = false
	local doubleConfirm = false
	button:SetCallback("OnClick", function()
		if not confirming then
			button:SetText("Confirm")
			confirming = true
			return
		end

		if not doubleConfirm then
			button:SetText("You totally sure?")
			doubleConfirm = true
			return
		end

		resetNote(dungeonName, docStruct)
		confirming = false
		button:SetText(resetButtonText)
		rerender()
	end)

	scrollFrame:AddChild(button)
	lastSelected = { dungeonName, enemyType, docName }
end

--- TODO
---@param dungeonName DungeonName
---@param docStruct DocStructure
---@param noteKey PlayerNoteKeys
---@param noteLabel string
---@param container AceGUIContainer
function M.RenderNote(dungeonName, docStruct, noteKey, noteLabel, container)
	-- Add notes
	-- Create a SimpleGroup for the edit box to ensure proper layout
	local noteContainer = AceGUI:Create("SimpleGroup") ---@type SimpleGroup
	noteContainer:SetFullWidth(true) -- Make it take the full width
	noteContainer:SetHeight(100) -- Set a height for the edit box container
	noteContainer:SetLayout("Fill")
	container:AddChild(noteContainer)

	-- Add a Multi-Line Edit Box using a standard EditBox
	local noteTextBox = AceGUI:Create("MultiLineEditBox") ---@type MultiLineEditBox
	noteTextBox:SetLabel(noteLabel)
	noteTextBox:SetFullWidth(true) -- Make the edit box take up the full width of the container

	noteTextBox:SetText(DD.db.GetActiveNoteWithFallback(dungeonName, docStruct.ddid, noteKey))
	noteTextBox:DisableButton(true) -- Disable the "Okay" button
	noteTextBox:SetCallback("OnTextChanged", function(_, _, text)
		DD.db.SetNote(dungeonName, docStruct.ddid, noteKey, text)
	end)
	noteContainer:AddChild(noteTextBox)
end

---@return TreeData
function M.DungeonDataToTreeData()
	-- Get instances only from the selected season
	local instances = DD.dungeons.GetCurrentSeason()

	local treeData = {} ---@type TreeData

	for _, d in pairs(instances) do
		local treeBossNotes = {} ---@type TreeNote[]
		local treeTrashNotes = {} ---@type TreeNote[]

		for _, noteStruct in ipairs(d.docStructures) do
			local target = treeTrashNotes
			if noteStruct.isBoss then
				target = treeBossNotes
			end

			local note = {
				value = noteStruct.docName,
				text = noteStruct.docName,
				noteName = noteStruct.docName,
				mobs = noteStruct.mobs,
				isBoss = noteStruct.isBoss,
				ddid = noteStruct.ddid,
			}
			table.insert(target, note)
		end

		-- Sort trash alphabetically
		table.sort(treeTrashNotes, function(a, b)
			return a.value < b.value
		end)

		local treeDungeon = {
			value = d.dungeonName,
			text = d.dungeonName,
			name = d.dungeonName,
			icon = d.icon,
			children = {
				{
					value = "bosses",
					text = "Bosses",
					children = treeBossNotes,
				},
				{
					value = "trash",
					text = "Trash",
					children = treeTrashNotes,
				},
			},
		}

		table.insert(treeData, treeDungeon)
	end

	-- Sort dungeons alphabetically
	table.sort(treeData, function(a, b)
		return a.name < b.name
	end)

	return treeData
end

---@class UI
DD.ui = DD.ui or {}
DD.ui.docs = M
