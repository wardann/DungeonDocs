
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