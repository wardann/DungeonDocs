---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI

---@class DeveloperCapture
local M = {}

---@class Developer
DD.developer = DD.developer or {}

---@alias InstanceName string

---@alias MobID string

---@alias SpellName string
---@alias SpellID number
---@alias SpellSchool number
---@alias Spell {
---    name: SpellName|nil,
---    id: SpellID,
---    school: SpellSchool|nil,
---}
--

---@alias MobData {
---    name: string,
---    id: string,
---    guid: string,
---    spells: table<SpellID, Spell>,
---}
---
---@alias MobIDToData table<MobID, MobData>
---
---
---@alias InstanceData {
---  mobIDToData: MobIDToData,
---  type: string,
---}

---@alias InstanceCapture table<InstanceName, InstanceData>

function M.Init()
	local inInstance, instanceType = IsInInstance()
	if inInstance then
		local instanceName = GetInstanceInfo()
		DD.developer.Log("Instance of type " .. DD.utils.Gray(instanceType) .. " detected: " .. instanceName)
	end

	M.InitEvents()
end

-- #     # ###
-- #     #  #
-- #     #  #
-- #     #  #
-- #     #  #
-- #     #  #
--  #####  ###

-- TODO set this to the current instance the player is in by default
local localState = {
	selectedInstance = "All",
}

-- TODO make it so we're always capturing, do not return
-- if we already have the capture
-- TODO capture the mob type. consider filtering on critters

---@param wrapperContainer AceGUIContainer
---@param isRefresh? boolean
function M.TabRoot(wrapperContainer, isRefresh)
	-- Refresh function to rebuild the view
	local refresh = function()
		wrapperContainer:ReleaseChildren()
		M.TabRoot(wrapperContainer, true)
	end

	-- Simplify default instance dropdown value
	local inInstance, _ = IsInInstance()
	if inInstance and not isRefresh then
		local currentInstance = GetInstanceInfo()
		if DD.developer.database.profile.instanceCapture[currentInstance] then
			localState.selectedInstance = currentInstance
		end
	end

	-- Create a vertical container for layout
	local mainContainer = AceGUI:Create("SimpleGroup")
	mainContainer:SetLayout("Flow") -- Stack elements vertically
	mainContainer:SetFullWidth(true)
	mainContainer:SetFullHeight(true)
	wrapperContainer:AddChild(mainContainer)

	-- Create and configure the profile dropdown
	local instanceDropdown = AceGUI:Create("Dropdown")
	instanceDropdown:SetLabel("Instance")
	instanceDropdown:SetFullWidth(true) -- Ensure it takes the full width

    -- Changed: Use a key-value table so that the keys (and values) are instance names.
    local instances = {} ---@type table<string, string>
    instances["All"] = "All"
    for instanceName in pairs(DD.developer.database.profile.instanceCapture) do
        instances[instanceName] = instanceName
    end
	instanceDropdown:SetList(instances)

	instanceDropdown:SetCallback("OnValueChanged", function(_, _, instanceName)
		localState.selectedInstance = instanceName
		refresh()
	end)
	instanceDropdown:SetValue(localState.selectedInstance)

	mainContainer:AddChild(instanceDropdown)

	-- Add Delete Instance Button
    local singleConfirm = false
    local doubleConfirm = false
	local deleteButton = AceGUI:Create("Button")
	deleteButton:SetText("Delete Instance")
	deleteButton:SetFullWidth(true)
	deleteButton:SetCallback("OnClick", function()
		if localState.selectedInstance == "All" then
            DD.utils.Log("Cannot delete all instances")
            return
        end
		if not singleConfirm then
			deleteButton:SetText("Confirm")
			singleConfirm = true
			return
		end
		if not doubleConfirm then
			deleteButton:SetText("You totally sure?")
			doubleConfirm = true
			return
		end
		if localState.selectedInstance ~= "" then
			DD.developer.database.profile.instanceCapture[localState.selectedInstance] = nil
			DD.developer.Log("Deleted instance: " .. DD.utils.Gray(localState.selectedInstance))
			localState.selectedInstance = "All"
			refresh()
		end
	end)

	mainContainer:AddChild(deleteButton)

	-- Create and configure the multi-line edit box
	local textBox = AceGUI:Create("MultiLineEditBox")
	textBox:SetLabel("Data")
	textBox:DisableButton(true)
	textBox:SetFullWidth(true)
	textBox:SetFullHeight(true) -- Let the edit box take the remaining space

	local setText = function()
		if localState.selectedInstance == "All" then
			local allInstances = DD.developer.database.profile.instanceCapture
			textBox:SetText(DD.utils.TableToJSON(allInstances, 4))
            return
        end

		if localState.selectedInstance ~= "" then
			local instanceData = DD.developer.database.profile.instanceCapture[localState.selectedInstance]
			textBox:SetText(DD.utils.TableToJSON(instanceData, 4))
		end
	end
	setText()

	textBox:SetCallback("OnTextChanged", function(_, _, _)
		-- Prevent editing by setting the text back to its original state
		setText()
	end)

	-- Add the text box to the main container
	mainContainer:AddChild(textBox)
end

-- ####### #     # ####### #     # #######  #####
-- #       #     # #       ##    #    #    #     #
-- #       #     # #       # #   #    #    #
-- #####   #     # #####   #  #  #    #     #####
-- #        #   #  #       #   # #    #          #
-- #         # #   #       #    ##    #    #     #
-- #######    #    ####### #     #    #     #####

function M.InitEvents()
	local eventFrame = CreateFrame("Frame")
	eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	eventFrame:SetScript("OnEvent", function(_, event)
		if event == "COMBAT_LOG_EVENT_UNFILTERED" then
			local inInstance, instanceType = IsInInstance()
			if not inInstance then
				return
			end

			local instanceName, _ = GetInstanceInfo()

			local _, _, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, _, spellId, spellName, spellSchool =
				CombatLogGetCurrentEventInfo()

			local sourceMobId = sourceGUID:match("-(%d+)-%x+$")
			local sourceGuidType = sourceGUID:match("^(.-)-")

			local destMobId = destGUID:match("-(%d+)-%x+$")
			local destGuidType = destGUID:match("^(.-)-")

			local function isHostile(flags)
				return bit.band(flags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0
			end

			local isValidEvent = function()
				if sourceGuidType == "Player" and destGuidType == "Player" then
					return false
				end

                if not isHostile(sourceFlags) and not isHostile(destFlags) then
                    return false
                end

				if DD.utils.IsFollowerNPC(sourceMobId) or DD.utils.IsFollowerNPC(destMobId) then
					return true
				end

                return true
			end

			if isValidEvent() then
                M.captureInstance(instanceName, instanceType)

				if sourceGuidType ~= "Player" and isHostile(sourceFlags) then
					M.captureMob(instanceName, sourceMobId, sourceGUID, sourceName)
                    if spellId then
                        M.captureSpell(instanceName, sourceMobId, sourceName, spellId, spellName, spellSchool)
                    end
				end
				if destGuidType ~= "Player" and isHostile(destFlags) then
					M.captureMob(instanceName, destMobId, destGUID, destName)
				end
			end
		end
	end)
end

---@param instanceName string
---@param instanceType string
function M.captureInstance(instanceName, instanceType)
	local state = DD.developer.database.profile.instanceCapture
	if not state[instanceName] then
		DD.developer.Log("Found a new instance: " .. DD.utils.Gray(instanceName))
		state[instanceName] = {
			mobIDToData = {},
			type = instanceType,
		}
	end
end

---@param instanceName string
---@param mobId string
---@param guid string
---@param mobName string
function M.captureMob(instanceName, mobId, guid, mobName)
	if not mobId then return end

	local state = DD.developer.database.profile.instanceCapture
	local instanceData = state[instanceName]

	if not instanceData.mobIDToData[mobId] then
		DD.developer.Log("Found new mob " .. DD.utils.Gray(mobName) .. " in instance " .. DD.utils.Gray(instanceName))

		instanceData.mobIDToData[mobId] = {
			name = mobName,
			id = mobId,
			guid = guid,
            spells = {},
		}
	end

    local mobData = instanceData.mobIDToData[mobId]
    mobData.name = mobName
    mobData.id = mobId
    mobData.guid = guid
end

-- New function to capture a mob's spell cast
---@param instanceName string
---@param mobId string
---@param mobName string
---@param spellId SpellID
---@param spellName SpellName|nil
---@param spellSchool SpellSchool|nil
function M.captureSpell(instanceName, mobId, mobName, spellId, spellName, spellSchool)
	if not mobId or not spellId then return end

    -- Only capture mob spells; ignore spells from players
    if mobId:match("^Player") then return end

    if not spellName then return end

    if spellName == -1 then return end

	local mobData = DD.developer.database.profile.instanceCapture[instanceName].mobIDToData[mobId]
    if not mobData.spells[spellId] then
	    DD.developer.Log("Captured spell " .. DD.utils.Gray(spellName) .. " for mob " .. DD.utils.Gray(mobName) .. " in instance " .. DD.utils.Gray(instanceName))
    end
	mobData.spells[spellId] = {
		name = spellName,
		id = spellId,
		school = spellSchool,
	}
end

-- ### #     # ### #######
--  #  ##    #  #     #
--  #  # #   #  #     #
--  #  #  #  #  #     #
--  #  #   # #  #     #
--  #  #    ##  #     #
-- ### #     # ###    #

DD.developer.capture = M
