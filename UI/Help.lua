--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0") ---@type AceGUI

--- @class HelpUI
local M = {}


---@param container AceGUIContainer
function M.TabRoot(container)
    container:SetLayout("Fill")

    local label = AceGUI:Create("Label") ---@type Label
    label:SetText([[
Welcome to DungeonDocs!

Questions? Please read the documentation:
|cff71d5ffgithub.com/wardann/DungeonDocs|r

Need more help? Want to request a feature? Found a bug? Please open an issue:
|cff71d5ffgithub.com/wardann/DungeonDocs/issues/new|r
    ]])
    label:SetFullWidth(true)

    container:AddChild(label)
end

--- @class UI
DD.ui = DD.ui or {}
DD.ui.help = M