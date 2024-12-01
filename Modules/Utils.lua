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
    local args = { ... }                    -- Capture all arguments
    local message = table.concat(args, " ") -- Concatenate all arguments with a space
    print("|cffffd700DungeonDocs|r " .. message)     -- Add prefix and print
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