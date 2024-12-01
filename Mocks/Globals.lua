-- Mock LibStub
_G.LibStub = setmetatable({
    addons = {},
    NewAddon = function(self, name)
        local addon = { name = name }
        self.addons[name] = addon
        return addon
    end,
    GetAddon = function(self, name)
        if not self.addons[name] then
            error("Addon '" .. name .. "' not found", 2)
        end
        return self.addons[name]
    end
}, {
    __call = function(self, libraryName)
        return self  -- Simulate LibStub being callable
    end
})

-- Mock WoW globals
_G.CreateFrame = function(frameType, frameName, parent)
    return {
        SetSize = function() end,
        SetPoint = function() end,
        Show = function() end,
        GetHeight = function() return 100 end
    }
end

-- Register your addon for testing
LibStub:NewAddon("DungeonDocs")