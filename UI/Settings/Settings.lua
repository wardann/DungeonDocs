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
            text = "Notes",
            value = "notes",
            children = {
                {
                    text = "Primary",
                    value = "primary",
                },
                {
                    text = "Role",
                    value = "role",
                },
                {
                    text = "Omni",
                    value = "omni",
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

        local first, second = strsplit("\001", uniquePath)

        if first == "general" then
            DD:SettingsGeneral_View(rightGroup)
        elseif first == "notes" then
            if second == "primary" then
                DD:SettingsPrimary_View(rightGroup)
            elseif second == "role" then
                print(">>> role")
            elseif second == "omni" then
                print(">>> omni")
            end
        end
    end)


    -- Force selection of all top-level nodes to ensure they're expanded
    for _, node in ipairs(menu) do
        treeGroup:SelectByPath(node.value)
    end

    treeGroup:SetSelected("general")
end
