-- Mock LibStub
_G.LibStub = setmetatable({
    addons = {},
    NewAddon = function(self, name)
        local addon = { name = name }
        ---@diagnostic disable-next-line
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
        if libraryName == "LibSharedMedia-3.0" then
            return _G.LibSharedMedia
        end
        return self  -- Simulate LibStub being callable
    end
})

-- Mock LibSharedMedia-3.0
_G.LibSharedMedia = {
    fonts = {
        ["Font A"] = "path/to/fontA.ttf",
        ["Font B"] = "path/to/fontB.ttf",
    },
    HashTable = function(self, mediaType)
        if mediaType == "font" then
            return self.fonts
        end
        error("Unsupported media type: " .. tostring(mediaType))
    end
}

-- Mock WoW globals
--- @type fun(frameType: string, name: string|nil, parent: Frame|nil, inherits: string|nil): Frame
_G.CreateFrame = function(_, _, _)
    return {
        SetSize = function() end,
        SetPoint = function() end,
        Show = function() end,
        GetHeight = function() return 100 end
    }
end

-- Register your addon for testing
LibStub:NewAddon("DungeonDocs")
