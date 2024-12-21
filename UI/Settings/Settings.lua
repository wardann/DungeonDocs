--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

--- @class UI
DD.ui = DD.ui or {}

--- @class SettingsUI
DD.ui.settings = DD.ui.settings or {}

-- Get available fonts from LSM
local rightGroup


function DD.ui.settings.TabRoot(container)
    local treeGroup = AceGUI:Create("TreeGroup")
    treeGroup:SetLayout("Fill")
    treeGroup:SetFullWidth(true)
    treeGroup:SetFullHeight(true)
    treeGroup:SetTreeWidth(200, false) -- Set the width of the tree part
    container:AddChild(treeGroup)

    -- Define the tree data structure

    -- Set the tree data
    local menu = {
        {
            text = "General",
            value = "general",
        },
        {
            text = "Title",
            value = "title",
        },
        {
            text = "Primary",
            value = "primary",
        },
        {
            text = "Role",
            value = "role",
        },
        {
            text = "Tank",
            value = "tank",
        },
        {
            text = "Healer",
            value = "healer",
        },
        {
            text = "Damage",
            value = "damage",
        },
    }
    treeGroup:SetTree(menu)

    -- Init right group
    rightGroup = AceGUI:Create("SimpleGroup")
    rightGroup:SetFullWidth(true)
    rightGroup:SetFullHeight(true)
    rightGroup:SetLayout("Flow")
    treeGroup:AddChild(rightGroup)

    treeGroup:SetCallback("OnGroupSelected", function(_, _, uniquePath)
        rightGroup:ReleaseChildren()

        local first = strsplit("\001", uniquePath)

        if first == "general" then
            DD.ui.settings.General_View(rightGroup)
        elseif first == "title" then
            DD.ui.settings.Title_View(rightGroup)
        elseif first == "primary" then
            DD.ui.settings.StylePrimary_View(rightGroup)
        elseif first == "role" then
            DD.ui.settings.StyleRole_View(rightGroup)
        elseif first == "tank" then
            DD.ui.settings.StyleRoleTank_View(rightGroup)
        elseif first == "healer" then
            DD.ui.settings.StyleRoleHealer_View(rightGroup)
        elseif first == "damage" then
            DD.ui.settings.StyleRoleDamage_View(rightGroup)
        end
    end)



    DD.ui.settings.ExpandAllTreeNodes(treeGroup, menu)

    treeGroup:SetSelected("general")
end

function DD.ui.settings.ExpandAllTreeNodes(treeGroup, menu, path)
    for _, node in ipairs(menu) do
        -- Build the current path
        local currentPath = path and (path .. "\001" .. node.value) or node.value

        -- Expand the current node
        treeGroup:SelectByPath(currentPath)

        -- Recursively expand children
        if node.children then
            DD.ui.settings.ExpandAllTreeNodes(treeGroup, node.children, currentPath)
        end
    end
end
