local AceGUI = LibStub("AceGUI-3.0")

function InspectTable(t, indent)
    indent = indent or 0
    local prefix = string.rep("  ", indent)

    if type(t) ~= "table" then
        print(prefix .. tostring(t)) -- Print non-table values directly
        return
    end
end

-- Function to get the mob ID from the target's GUID
function GetMobIDFromGUID(unit)
    local guid = UnitGUID(unit) -- Get the GUID of the unit (e.g., "target")
    if guid then
        -- Split the GUID into its components and extract the mob ID
        local type, zero, server_id, instance_id, zone_uid, mob_id, spawn_uid = strsplit("-", guid)
        if type == "Creature" or type == "Vehicle" then -- Mobs are usually "Creature" or "Vehicle"
            return tonumber(mob_id)
        end
    end
    return nil -- Return nil if no valid mob ID is found
end

function Utils_AddSpacer(container)
    -- Add a spacer (or line break)
    local spacer = AceGUI:Create("Label")
    spacer:SetFullWidth(true)
    container:AddChild(spacer)
end

function Log(...)
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

function DeepCopy(orig)
    local orig_type = type(orig)
    local copy

    if orig_type == "table" then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[DeepCopy(orig_key)] = DeepCopy(orig_value)
        end
        setmetatable(copy, getmetatable(orig))
    else -- for non-table types, return the original value
        copy = orig
    end

    return copy
end

function AddSection(container, title)
    -- Create an InlineGroup as a section container
    local section = AceGUI:Create("InlineGroup")
    section:SetTitle(title)
    section:SetFullWidth(true)
    section:SetLayout("Flow")
    container:AddChild(section)

    return section
end

function IsFollowerNPC(mobID)
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

--
-- Frame helpers
--

function FrameHide(frame)
    if frame:IsShown() then
        frame:Hide()
    end
end

function FrameShow(frame)
    if not frame:IsShown() then
        frame:Show()
    end
end

function FrameWidth(frame, width)
    if frame:GetWidth() ~= width then
        frame:SetWidth(width)
    end
end

function FrameHeight(frame, height)
    if frame:GetHeight() ~= height then
        frame:SetHeight(height)
    end
end

function FrameCollapse(frame)
    FrameHide(frame)
    FrameHeight(frame, 0)
end

function FrameSetPoint(frame, point, relativeTo, relativePoint, offsetX, offsetY)
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

function FontText(frame, text)
    if frame.fontString:GetText() ~= text then
        frame.fontString:SetText(text)
    end
end

function SafeSetFont(fontString, fontPath, fontSize, fontFlags)
    local currentFont, currentSize, currentFlags = fontString:GetFont()
    if currentFont ~= fontPath or currentSize ~= fontSize or currentFlags ~= fontFlags then
        fontString:SetFont(fontPath, fontSize, fontFlags)
    end
end

function SafeSetTextColor(fontString, r, g, b, a)
    local cr, cg, cb, ca = fontString:GetTextColor()
    if cr ~= r or cg ~= g or cb ~= b or ca ~= a then
        fontString:SetTextColor(r, g, b, a)
    end
end

function SafeSetAlpha(frame, newAlpha)
    if frame:GetAlpha() ~= newAlpha then
        frame:SetAlpha(newAlpha)
    end
end

function SafeSetJustifyH(fontString, align)
    if fontString:GetJustifyH() ~= align then
        fontString:SetJustifyH(align)
    end
end

function SafeSetAllPoints(texture, parentFrame)
    local point1, relativeTo1 = texture:GetPoint(1)
    if not point1 or relativeTo1 ~= parentFrame then
        texture:SetAllPoints(parentFrame)
    end
end

function SafeSetColorTexture(texture, r, g, b, a)
    local cr, cg, cb, ca = texture:GetVertexColor()
    if cr ~= r or cg ~= g or cb ~= b or ca ~= a then
        texture:SetColorTexture(r, g, b, a)
    end
end

