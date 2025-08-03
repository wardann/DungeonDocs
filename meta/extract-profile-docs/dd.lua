-- This file contains the necessary setup to bootstrap
-- DungeonDocs in a local env

DD = {
	dungeons = {}, -- allow Dungeons.lua to assign to this
}
local aceAddonMock = {
	GetAddon = function(_) -- Using _ for unused argument
		return DD
	end,
}

LibStub = function(name)
	if name == "AceAddon-3.0" then
		return aceAddonMock
	end
end

PrintTable = function(tbl, indent)
    indent = indent or 0
    local prefix = string.rep("  ", indent)
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            print(prefix .. tostring(k) .. ":")
            PrintTable(v, indent + 1)
        else
            print(prefix .. tostring(k) .. ": " .. tostring(v))
        end
    end
end