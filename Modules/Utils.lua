---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI
local LSM = LibStub("LibSharedMedia-3.0") ---@type any
local M = {}

-- #    # ###### #      #####  ###### #####   ####
-- #    # #      #      #    # #      #    # #
-- ###### #####  #      #    # #####  #    #  ####
-- #    # #      #      #####  #      #####       #
-- #    # #      #      #      #      #   #  #    #
-- #    # ###### ###### #      ###### #    #  ####

---@param t table
---@param indent number
function M.InspectTable(t, indent)
	indent = indent or 0
	local prefix = string.rep("  ", indent)

	if type(t) ~= "table" then
		print(prefix .. tostring(t)) -- Print non-table values directly
		return
	end
end

--- Gets the mob ID from the target's GUID
---@param unit string
---@return string|nil
function M.GetMobIDFromGUID(unit)
	local guid = UnitGUID(unit) -- Get the GUID of the unit (e.g., "target")
	if guid then
		-- Split the GUID into its components and extract the mob ID
		-- vars are: type, zero, server_id, instance_id, zone_uid, mob_id, spawn_uid
		---@type string, string, string, string, string, string, string
		local type, _, _, _, _, mob_id, _ = strsplit("-", guid)
		if type == "Creature" or type == "Vehicle" then -- Mobs are usually "Creature" or "Vehicle"
			return mob_id
		end
	end
	return nil -- Return nil if no valid mob ID is found
end

---@param container AceGUIContainer
function M.AddSpacer(container)
	-- Add a spacer (or line break)
	local spacer = AceGUI:Create("Label") ---@type Label
	spacer:SetFullWidth(true)
	container:AddChild(spacer)
end

---@param ... any
function M.Log(...)
	local args = { ... } -- Capture all arguments
	local message = ""
	for i, v in ipairs(args) do
		if i == 1 then
			message = tostring(v)
		else
			message = message .. " " .. tostring(v)
		end
	end
	print("|cffffd700DungeonDocs|r " .. message) -- Add prefix and print
end

---@generic T
---@param orig T # The original table or value to copy
---@return T # A deep copy of the original value
function M.DeepCopy(orig)
	local orig_type = type(orig)
	local copy ---@type any

	if orig_type == "table" then
		copy = {} ---@type table<any, any>

		--- NOTE: could not figure out the proper way to type this
		---@diagnostic disable-next-line
		for orig_key, orig_value in next, orig, nil do
			copy[DD.utils.DeepCopy(orig_key)] = M.DeepCopy(orig_value)
		end
		setmetatable(copy, getmetatable(orig))
	else -- for non-table types, return the original value
		copy = orig
	end

	return copy
end

local function escapeStr(str)
	return str:gsub('"', '\\"')
end

local function isArray(tbl)
	local max = 0
	local count = 0
	---@diagnostic disable-next-line
	for k, _ in pairs(tbl) do
		if type(k) == "number" then
			if k > max then
				max = k
			end
			count = count + 1
		else
			return false
		end
	end
	return max == count
end

--- Removes all occurrences of a value from an array-style table.
---@param tbl table
---@param value any
function M.RemoveFromArray(tbl, value)
	for i = #tbl, 1, -1 do
		if tbl[i] == value then
			table.remove(tbl, i)
		end
	end
end

function M.TableToJSON(tbl, indent)
	indent = indent or 0
	local indentStr = string.rep("  ", indent)
	local nextIndentStr = string.rep("  ", indent + 1)

	if type(tbl) == "table" then
		local is_arr = isArray(tbl)
		local parts = {}
		if is_arr then
			table.insert(parts, "[\n")

			---@diagnostic disable-next-line
			for i, v in ipairs(tbl) do
				table.insert(parts, nextIndentStr .. M.TableToJSON(v, indent + 1))
				if i < #tbl then
					table.insert(parts, ",\n")
				else
					table.insert(parts, "\n")
				end
			end
			table.insert(parts, indentStr .. "]")
		else
			table.insert(parts, "{\n")
			local count = 0
			local total = 0
			---@diagnostic disable-next-line
			for _ in pairs(tbl) do
				total = total + 1
			end
			---@diagnostic disable-next-line
			for k, v in pairs(tbl) do
				count = count + 1
				---@diagnostic disable-next-line
				local key
				if type(k) == "string" then
					---@diagnostic disable-next-line
					key = '"' .. escapeStr(k) .. '"'
				else
					key = tostring(k)
				end
				table.insert(parts, nextIndentStr .. key .. ": " .. M.TableToJSON(v, indent + 1))
				if count < total then
					table.insert(parts, ",\n")
				else
					table.insert(parts, "\n")
				end
			end
			table.insert(parts, indentStr .. "}")
		end
		return table.concat(parts)
	elseif type(tbl) == "string" then
		return '"' .. escapeStr(tbl) .. '"'
	elseif type(tbl) == "number" or type(tbl) == "boolean" then
		return tostring(tbl)
	else
		return "null"
	end
end

---@param container AceGUIContainer
---@param title string
---@return InlineGroup
function M.AddSection(container, title)
	-- Create an InlineGroup as a section container
	local section = AceGUI:Create("InlineGroup") ---@type InlineGroup
	section:SetTitle(title)
	section:SetFullWidth(true)
	section:SetLayout("Flow")
	container:AddChild(section)

	return section
end

---@param mobID string|number|nil
function M.IsFollowerNPC(mobID)
	if not mobID then
		return false
	end
	mobID = tostring(mobID)
	local followerNPCIDs = {
		"214390", -- Shuja Grimaxe, Shaman
		"209072", -- Crenna Earth-Daughter, Druid
		"209065", -- Austin Huxworth, Hunter
		"209059", -- Meredy Huntswell, Mage
		"209057", -- Captain Garrick, Paladin
	}

	for _, followerMobId in ipairs(followerNPCIDs) do
		if followerMobId == mobID then
			return true
		end
	end
	return false
end

---@param active PlayerNotes
---@param fallback PlayerNotes
---@return PlayerNotes
function M.MergePlayerNotes(active, fallback)
	---@alias PlayerNotesMapped table<DungeonName, table<DDID, PlayerNote>>
	local playerNotesMapped = {} ---@type PlayerNotesMapped

	for dungeonName, notes in pairs(active) do
		if not playerNotesMapped[dungeonName] then
			playerNotesMapped[dungeonName] = {}
		end

		for _, note in ipairs(notes) do
			playerNotesMapped[dungeonName][note.ddid] = note
		end
	end

	-- Add the notes from the fallback profile where applicable
	for instance, fallbackNotes in pairs(fallback) do
		if not playerNotesMapped[instance] then
			playerNotesMapped[instance] = {}
		end

		for _, fallbackNote in ipairs(fallbackNotes) do
			(function()
				local found = playerNotesMapped[instance][fallbackNote.ddid]
				if not found then
					playerNotesMapped[instance][fallbackNote.ddid] = fallbackNote
					return
				end

				---@param activeValue string
				---@param fallbackValue string
				local function shouldUseFallback(activeValue, fallbackValue)
					return not activeValue and fallbackValue and #fallbackValue > 0
				end

				if shouldUseFallback(found.primaryNote, fallbackNote.primaryNote) then
					found.primaryNote = fallbackNote.primaryNote
				end

				if shouldUseFallback(found.tankNote, fallbackNote.tankNote) then
					found.tankNote = fallbackNote.tankNote
				end

				if shouldUseFallback(found.healerNote, fallbackNote.healerNote) then
					found.healerNote = fallbackNote.healerNote
				end

				if shouldUseFallback(found.damageNote, fallbackNote.damageNote) then
					found.damageNote = fallbackNote.damageNote
				end
			end)()
		end
	end

	local playerNotesFinal = {} ---@type PlayerNotes

	for dungeonName, notes in pairs(playerNotesMapped) do
		for _, note in pairs(notes) do
			if not playerNotesFinal[dungeonName] then
				playerNotesFinal[dungeonName] = {}
			end
			table.insert(playerNotesFinal[dungeonName], note)
		end
	end

	return playerNotesFinal
end

---@param tbl table
function M.IsTableEmpty(tbl)
	return next(tbl) == nil
end

---@param array any[]
---@param element any
function M.IsInArray(array, element)
	for _, e in ipairs(array) do
		if e == element then
			return true
		end
	end
	return false
end

---@param tbl table<any, any>
---@param indent string?
---@return string
function M.TableToString(tbl, indent)
	indent = indent or ""
	local result = "{\n"
	local nextIndent = indent .. "  "

	for k, v in pairs(tbl) do
		local key = tostring(k)
		if type(v) == "table" then
			result = result .. nextIndent .. key .. " = " .. M.TableToString(v, nextIndent) .. ",\n"
		else
			result = result .. nextIndent .. key .. " = " .. tostring(v) .. ",\n"
		end
	end

	return result .. indent .. "}"
end

-- Function to log the human-readable table string to BugSack
---@param msg string
---@param tbl table<any, any>
function M.LogTableToBugSack(msg, tbl)
	local readableTable = M.TableToString(tbl)
	error(msg .. "\n\n" .. readableTable) -- Triggers BugSack to capture the output
end

---@param message string
function M.LogToGroup(message)
	---@param msg string
	---@param channel string
	local function sendMultiLineMsg(msg, channel)
		for line in msg:gmatch("[^\n]+") do
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

--- Wraps text in a light gray color escape sequence for logging
--- @param text string The text to wrap
--- @return string The text wrapped in a light gray color
function M.Gray(text)
	return "|cffd3d3d3" .. text .. "|r"
end

-- ######  ####  #    # #####  ####
-- #      #    # ##   #   #   #
-- #####  #    # # #  #   #    ####
-- #      #    # #  # #   #        #
-- #      #    # #   ##   #   #    #
-- #       ####  #    #   #    ####

---@param fontName string
function M.FontNameToPath(fontName)
	local fontNameToPath = LSM:HashTable("font") ---@type table<string, string>
	return fontNameToPath[fontName]
end

---@param targetFontPath string
function M.FontPathToName(targetFontPath)
	local fontList = LSM:HashTable("font") ---@type table<string, string>

	for fontName, fontPath in pairs(fontList) do
		if fontPath == targetFontPath then
			return fontName
		end
	end
end

---@param container AceGUIContainer
---@param label string
---@param startingFont string
---@param callback fun(string)
function M.AddFontSelect(container, label, startingFont, callback)
	-- Dropdown menu for font selection
	local fontDropdown = AceGUI:Create("Dropdown") ---@type Dropdown
	fontDropdown:SetLabel(label)

	-- Build list of available fonts
	local fontList = LSM:HashTable("font") ---@type table<string, string>
	local fontNames = {} ---@type table<string, string>
	for fontName, _ in pairs(fontList) do
		fontNames[fontName] = fontName -- Use font names as display text
	end

	-- Create a list with font-specific labels
	fontDropdown:SetList(fontNames)

	-- Set initial font
	fontDropdown:SetValue(startingFont)

	-- Set callback to apply the selected font and preview it
	fontDropdown:SetCallback("OnValueChanged", function(_, _, selectedFont)
		callback(selectedFont)
	end)

	container:AddChild(fontDropdown)
end

DD.utils = M

-- ###### #####    ##   #    # ######
-- #      #    #  #  #  ##  ## #
-- #####  #    # #    # # ## # #####
-- #      #####  ###### #    # #
-- #      #   #  #    # #    # #
-- #      #    # #    # #    # ######

--- Enable this to debug the conditional setting of frame properties
local force = false

---@param frame Frame|FontString
function M.SafeFrameHide(frame)
	if not frame then
		return
	end
	if frame:IsShown() or force then
		frame:Hide()
	end
end

---@param frame Frame|FontString
function M.SafeFrameShow(frame)
	if not frame then
		return
	end
	if not frame:IsShown() or force then
		frame:Show()
	end
end

---@param frame Frame|FontString
function M.SafeFrameWidth(frame, width)
	if not frame then
		return
	end
	if frame:GetWidth() ~= width or force then
		frame:SetWidth(width)
	end
end

---@param frame Frame|FontString
function M.SafeFrameHeight(frame, height)
	if not frame then
		return
	end
	if frame:GetHeight() ~= height or force then
		frame:SetHeight(height)
	end
end

---@param frame Frame|FontString
function M.SafeFrameCollapse(frame)
	if not frame then
		return
	end
	M.SafeFrameHide(frame)
	M.SafeFrameHeight(frame, 0)
end

---@param frame Frame|FontString The frame to set the position for.
---@param point string The anchor point of the frame (e.g., "TOPLEFT", "CENTER").
---@param relativeTo Frame The frame or name of the frame to anchor to, or nil for the screen.
---@param relativePoint string The anchor point on the relative frame (e.g., "TOPLEFT", "CENTER").
---@param offsetX number The x-axis offset in pixels.
---@param offsetY number The y-axis offset in pixels.
function M.SafeFrameSetPoint(frame, point, relativeTo, relativePoint, offsetX, offsetY)
	if not frame then
		return
	end

	local existingPoint = { frame:GetPoint() } -- Get the current point

	-- Check if the new point matches the existing one
	if
		existingPoint[1] ~= point
		or existingPoint[2] ~= relativeTo
		or existingPoint[3] ~= relativePoint
		or existingPoint[4] ~= offsetX
		or existingPoint[5] ~= offsetY
		or force
	then
		frame:SetPoint(point, relativeTo, relativePoint, offsetX, offsetY)
	end
end

---@param frame Frame
---@param text string
function M.SafeFontText(frame, text)
	if not frame then
		return
	end
	if frame.fontString:GetText() ~= text or force then
		frame.fontString:SetText(text)
	end
end

---@param fontString FontString
---@param fontPath string
---@param fontSize number
---@param fontFlags string
function M.SafeSetFont(fontString, fontPath, fontSize, fontFlags)
	if not fontString then
		return
	end

	local currentFont, currentSize, currentFlags = fontString:GetFont()
	if currentFont ~= fontPath or currentSize ~= fontSize or currentFlags ~= fontFlags or force then
		fontString:SetFont(fontPath, fontSize, fontFlags)
	end
end

---@param fontString FontString
---@param r number
---@param g number
---@param b number
---@param a number
function M.SafeSetTextColor(fontString, r, g, b, a)
	if not fontString then
		return
	end

	local cr, cg, cb, ca = fontString:GetTextColor()
	if cr ~= r or cg ~= g or cb ~= b or ca ~= a or force then
		fontString:SetTextColor(r, g, b, a)
	end
end

---@param frame Frame|FontString
---@param newAlpha number
function M.SafeSetAlpha(frame, newAlpha)
	if not frame then
		return
	end
	if frame:GetAlpha() ~= newAlpha or force then
		frame:SetAlpha(newAlpha)
	end
end

---@param fontString FontString
---@param align string
function M.SafeSetJustifyH(fontString, align)
	if not fontString then
		return
	end
	if fontString:GetJustifyH() ~= align or force then
		fontString:SetJustifyH(align)
	end
end

---@param texture Texture
---@param parentFrame Frame
function M.SafeSetAllPoints(texture, parentFrame)
	if not texture then
		return
	end
	local point1, relativeTo1 = texture:GetPoint(1)
	if not point1 or relativeTo1 ~= parentFrame or force then
		texture:SetAllPoints(parentFrame)
	end
end

---@param texture Texture
---@param r number
---@param g number
---@param b number
---@param a number
function M.SafeSetColorTexture(texture, r, g, b, a)
	if not texture then
		return
	end
	local cr, cg, cb, ca = texture:GetVertexColor()
	if cr ~= r or cg ~= g or cb ~= b or ca ~= a or force then
		texture:SetColorTexture(r, g, b, a)
	end
end
