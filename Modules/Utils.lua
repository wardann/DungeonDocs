---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI
local M = {}


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
function M.GetMobIDFromGUID(unit)
    local guid = UnitGUID(unit) -- Get the GUID of the unit (e.g., "target")
    if guid then
        -- Split the GUID into its components and extract the mob ID
        -- vars are: type, zero, server_id, instance_id, zone_uid, mob_id, spawn_uid
        local type, _, _, _, _, mob_id, _ = strsplit("-", guid)
        if type == "Creature" or type == "Vehicle" then -- Mobs are usually "Creature" or "Vehicle"
            return tonumber(mob_id)
        end
    end
    return nil -- Return nil if no valid mob ID is found
end

function M.AddSpacer(container)
    -- Add a spacer (or line break)
    local spacer = AceGUI:Create("Label")
    spacer:SetFullWidth(true)
    container:AddChild(spacer)
end

--- @param ... any
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

--- @generic T
--- @param orig T # The original table or value to copy
--- @return T # A deep copy of the original value
function M.DeepCopy(orig)
    local orig_type = type(orig)
    local copy

    if orig_type == "table" then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[DD.utils.DeepCopy(orig_key)] = DD.utils.DeepCopy(orig_value)
        end
        setmetatable(copy, getmetatable(orig))
    else -- for non-table types, return the original value
        copy = orig
    end

    return copy
end

--- @param container AceGUIContainer
--- @param title string
--- @returns AceGUIInlineGroup
function M.AddSection(container, title)
    -- Create an InlineGroup as a section container
    local section = AceGUI:Create("InlineGroup") ---@type InlineGroup
    section:SetTitle(title)
    section:SetFullWidth(true)
    section:SetLayout("Flow")
    container:AddChild(section)

    return section
end

--- @param mobID string|number|nil
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

--   __
--  / _|_ __ __ _ _ __ ___   ___
-- | |_| '__/ _` | '_ ` _ \ / _ \
-- |  _| | | (_| | | | | | |  __/
-- |_| |_|  \__,_|_| |_| |_|\___|

--- @param frame Frame
function M.FrameHide(frame)
    if frame:IsShown() then
        frame:Hide()
    end
end

--- @param frame Frame
function M.FrameShow(frame)
    if not frame:IsShown() then
        frame:Show()
    end
end

--- @param frame Frame
function M.FrameWidth(frame, width)
    if frame:GetWidth() ~= width then
        frame:SetWidth(width)
    end
end

--- @param frame Frame
function M.FrameHeight(frame, height)
    if frame:GetHeight() ~= height then
        frame:SetHeight(height)
    end
end

--- @param frame Frame
function M.FrameCollapse(frame)
    M.FrameHide(frame)
    M.FrameHeight(frame, 0)
end

function M.FrameSetPoint(frame, point, relativeTo, relativePoint, offsetX, offsetY)
    local existingPoint = { frame:GetPoint() } -- Get the current point

    -- Check if the new point matches the existing one
    if existingPoint[1] ~= point or
        existingPoint[2] ~= relativeTo or
        existingPoint[3] ~= relativePoint or
        existingPoint[4] ~= offsetX or
        existingPoint[5] ~= offsetY then
        frame:SetPoint(point, relativeTo, relativePoint, offsetX, offsetY)
    end
end

--- @param frame Frame
--- @param text string
function M.FontText(frame, text)
    if frame.fontString:GetText() ~= text then
        frame.fontString:SetText(text)
    end
end

function M.SafeSetFont(fontString, fontPath, fontSize, fontFlags)
    local currentFont, currentSize, currentFlags = fontString:GetFont()
    if currentFont ~= fontPath or currentSize ~= fontSize or currentFlags ~= fontFlags then
        fontString:SetFont(fontPath, fontSize, fontFlags)
    end
end

function M.SafeSetTextColor(fontString, r, g, b, a)
    local cr, cg, cb, ca = fontString:GetTextColor()
    if cr ~= r or cg ~= g or cb ~= b or ca ~= a then
        fontString:SetTextColor(r, g, b, a)
    end
end

function M.SafeSetAlpha(frame, newAlpha)
    if frame:GetAlpha() ~= newAlpha then
        frame:SetAlpha(newAlpha)
    end
end

function M.SafeSetJustifyH(fontString, align)
    if fontString:GetJustifyH() ~= align then
        fontString:SetJustifyH(align)
    end
end

function M.SafeSetAllPoints(texture, parentFrame)
    local point1, relativeTo1 = texture:GetPoint(1)
    if not point1 or relativeTo1 ~= parentFrame then
        texture:SetAllPoints(parentFrame)
    end
end

function M.SafeSetColorTexture(texture, r, g, b, a)
    local cr, cg, cb, ca = texture:GetVertexColor()
    if cr ~= r or cg ~= g or cb ~= b or ca ~= a then
        texture:SetColorTexture(r, g, b, a)
    end
end

function M.MergeDocs(profileDocs, fallbackProfileDocs)
    local docs = {}
    for instance, mobs in pairs(profileDocs) do
        if not docs[instance] then
            docs[instance] = {}
        end

        for _, mob in ipairs(mobs) do
            docs[instance][mob.ddid] = mob
        end
    end

    -- LogTableToBugSack(fallbackProfileDocs)

    -- now add the fallback docs where applicable
    for instance, mobs in pairs(fallbackProfileDocs) do
        if not docs[instance] then
            docs[instance] = {}
        end

        for _, mob in ipairs(mobs) do
            (function()
                local found = docs[instance][mob.ddid]
                if not found then
                    docs[instance][mob.ddid] = mob
                    return
                end

                local function shouldUseFallback(note, fallbackNote)
                    return not note and fallbackNote and #fallbackNote > 0
                end

                if shouldUseFallback(found.primaryNote, mob.primaryNote) then
                    found.primaryNote = mob.primaryNote
                end

                if shouldUseFallback(found.tankNote, mob.tankNote) then
                    found.tankNote = mob.tankNote
                end

                if shouldUseFallback(found.healerNote, mob.healerNote) then
                    found.healerNote = mob.healerNote
                end

                if shouldUseFallback(found.damageNote, mob.damageNote) then
                    found.damageNote = mob.damageNote
                end
            end)()
        end
    end

    local docsFinal = {}

    for instance, mobs in pairs(docs) do
        for _, mob in pairs(mobs) do
            if not docsFinal[instance] then
                docsFinal[instance] = {}
            end
            table.insert(docsFinal[instance], mob)
        end
    end

    return docsFinal
end

function M.IsTableEmpty(tbl)
    return next(tbl) == nil
end

function M.IsInArray(array, element)
    for _, e in ipairs(array) do
        if e == element then
            return true
        end
    end
    return false
end

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
function M.LogTableToBugSack(msg, tbl)
    local readableTable = M.TableToString(tbl)
    error(msg .. "\n\n" .. readableTable) -- Triggers BugSack to capture the output
end

--- @param message string
function M.LogToGroup(message)
    --- @param msg string
    --- @param channel string
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

--   __             _
--  / _| ___  _ __ | |_ ___
-- | |_ / _ \| '_ \| __/ __|
-- |  _| (_) | | | | |_\__ \
-- |_|  \___/|_| |_|\__|___/

local LSM = LibStub("LibSharedMedia-3.0")
local fontList = LSM:HashTable("font")

local fontNameToPath = fontList
local fontPathToName = {}
for fontName, fontPath in pairs(fontList) do
    fontPathToName[fontPath] = fontName -- Use font names as display text
end

local fontNames = {}
for fontName, _ in pairs(fontList) do
    fontNames[fontName] = fontName -- Use font names as display text
end

function M.FontNameToPath(fontName)
    return fontNameToPath[fontName]
end

function M.FontPathToName(fontPath)
    return fontPathToName[fontPath]
end

function M.AddFontSelect(container, label, startingFont, callback)
    -- Dropdown menu for font selection
    local fontDropdown = AceGUI:Create("Dropdown")
    fontDropdown:SetLabel(label)

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
