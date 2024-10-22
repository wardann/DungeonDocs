local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

function DungeonDocs:InspectTable(t, indent)
    indent = indent or 0
    local prefix = string.rep("  ", indent)
    
    if type(t) ~= "table" then
        print(prefix .. tostring(t))  -- Print non-table values directly
        return
    end
end
