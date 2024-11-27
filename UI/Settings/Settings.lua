local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

-- Get available fonts from LSM
local rightGroup


function DD:Settings_Tab(container)
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
            text = "Style",
            value = "style",
            children = {
                {
                    text = "Primary",
                    value = "primary",
                },
                {
                    text = "Role",
                    value = "role",
                    children = {
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
                        }
                    }
                }
            }
        },
    }
    treeGroup:SetTree(menu)

    -- Init right group
    rightGroup = AceGUI:Create("SimpleGroup")
    rightGroup:SetFullWidth(true)
    rightGroup:SetFullHeight(true)
    rightGroup:SetLayout("Flow")
    treeGroup:AddChild(rightGroup)

    treeGroup:SetCallback("OnGroupSelected", function(self, event, uniquePath)
        rightGroup:ReleaseChildren()

        local first, second, third = strsplit("\001", uniquePath)

        if first == "general" then
            DD:SettingsGeneral_View(rightGroup)
        elseif first == "style" then
            if not second then
                treeGroup:SelectByPath("style" .. "\001" .. "primary")
            elseif second == "primary" then
                DD:SettingsStylePrimary_View(rightGroup)
            elseif second == "role" then
                if not third then
                    DD:SettingsStyleRole_View(rightGroup)
                elseif third == "tank" then
                    DD:SettingsStyleRoleTank_View(rightGroup)
                elseif third == "healer" then
                    DD:SettingsStyleRoleHealer_View(rightGroup)
                elseif third == "damage" then
                    DD:SettingsStyleRoleDamage_View(rightGroup)
                end
            end
        end
    end)


    -- Force selection of all top-level nodes to ensure they're expanded
    -- for _, node in ipairs(menu) do
    --     treeGroup:SelectByPath(node.value)
    -- end


    ExpandAllTreeNodes(treeGroup, menu)

    treeGroup:SetSelected("general")
end

function ExpandAllTreeNodes(treeGroup, menu, path)
    for _, node in ipairs(menu) do
        -- Build the current path
        local currentPath = path and (path .. "\001" .. node.value) or node.value
        
        -- Expand the current node
        treeGroup:SelectByPath(currentPath)

        -- Recursively expand children
        if node.children then
            ExpandAllTreeNodes(treeGroup, node.children, currentPath)
        end
    end
end
