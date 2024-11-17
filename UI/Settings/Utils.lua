local AceGUI = LibStub("AceGUI-3.0")
local LSM = LibStub("LibSharedMedia-3.0")
local fontList = LSM:HashTable("font")

local fontNameToPath = fontList
local fontPathToName = {}
for fontName, fontPath in pairs(fontList) do
    fontPathToName[fontPath] = fontName     -- Use font names as display text
end

local fontNames = {}
for fontName, _ in pairs(fontList) do
    fontNames[fontName] = fontName     -- Use font names as display text
end

function FontNameToPath(fontName)
    return fontNameToPath[fontName]
end

function FontPathToName(fontPath)
    return fontPathToName[fontPath]
end


function AddFontSelect(container, label, startingFont, callback)
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
