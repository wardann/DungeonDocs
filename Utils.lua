local AceGUI = LibStub("AceGUI-3.0")

function InspectTable(t, indent)
    indent = indent or 0
    local prefix = string.rep("  ", indent)
    
    if type(t) ~= "table" then
        print(prefix .. tostring(t))  -- Print non-table values directly
        return
    end
end

-- Function to get the mob ID from the target's GUID
function GetMobIDFromGUID(unit)
    local guid = UnitGUID(unit)  -- Get the GUID of the unit (e.g., "target")
    if guid then
        -- Split the GUID into its components and extract the mob ID
        print(guid)
        local type, zero, server_id, instance_id, zone_uid, mob_id, spawn_uid = strsplit("-", guid)
        if type == "Creature" or type == "Vehicle" then  -- Mobs are usually "Creature" or "Vehicle"
            return tonumber(mob_id)
        end
    end
    return nil  -- Return nil if no valid mob ID is found
end

function Utils_AddSpacer(container)
    -- Add a spacer (or line break)
    local spacer = AceGUI:Create("Label")
    spacer:SetFullWidth(true)
    container:AddChild(spacer)
end

function Log(...)
    local args = {...}  -- Capture all arguments
    local message = table.concat(args, " ")  -- Concatenate all arguments with a space
    print("[DungeonDocs]: " .. message)  -- Add prefix and print
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