local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local DD = DungeonDocs
local AceGUI = LibStub("AceGUI-3.0")

local treeGroup
local rightGroup
local models = {}


local function setTreeGroupFocus(treeGroup, treeData)
    local targetId = GetMobIDFromGUID("target")
    if not targetId then
        return
    end

    local currentInstanceName, currentInstanceType = GetInstanceInfo()
    if currentInstanceType ~= "party" then
        return
    end

    for _, instance in ipairs(treeData) do
        if instance.name == currentInstanceName then
            for _, mobType in ipairs(instance.children) do
                for _, mobOrBoss in ipairs(mobType.children) do
                    if mobOrBoss.value == "bosses" then
                        for _, mob in mobOrBoss.mobs do
                            if mob.id == targetId then
                                treeGroup:SelectByPath(instance.value, mobType.value, mob.value)
                                return true
                            end
                        end
                    else
                        if mobOrBoss.id == targetId then
                            treeGroup:SelectByPath(instance.value, mobType.value, mobOrBoss.value)
                            return true
                        end
                    end
                end
            end
        end
    end

    return false
end

local lastSelected = {}

-- Function to show the Default tab content
function DungeonDocs:ShowDocsTab(container)
    -- Create a TreeGroup for the hierarchical mob list
    treeGroup = AceGUI:Create("TreeGroup")
    treeGroup:SetLayout("Fill")
    treeGroup:SetFullWidth(true)
    treeGroup:SetFullHeight(true)
    treeGroup:SetTreeWidth(200, false) -- Set the width of the tree part
    container:AddChild(treeGroup)

    -- Define the tree data structure

    -- Set the tree data
    local treeData = DungeonDocs:DungeonDataToTreeData()
    treeGroup:SetTree(treeData)

    -- Set a callback for when a node is selected
    treeGroup:SetCallback("OnGroupSelected", function(self, event, uniquePath)
        local pathComponents = { strsplit("\001", uniquePath) }
        local numComponents = #pathComponents

        if numComponents < 3 then
            return
        end

        local dungeonName, enemyType, mobName = pathComponents[1], pathComponents[2], pathComponents[3]
        DungeonDocs:HandleSelected(dungeonName, enemyType, mobName)
    end)

    rightGroup = AceGUI:Create("SimpleGroup")
    rightGroup:SetFullWidth(true)
    rightGroup:SetFullHeight(true)
    rightGroup:SetLayout("Flow")
    treeGroup:AddChild(rightGroup)

    -- Focus an element in the tree if the player is targeting it
    -- Kicking this off with a very small delay else the model fails
    -- to load for some reason
    C_Timer.After(0.01, function()
        local groupWasFocused = setTreeGroupFocus(treeGroup, treeData)
        if not groupWasFocused and #lastSelected == 3 then
            print(">>> group was NOT focused, selecting last selected")
            treeGroup:SelectByPath(lastSelected[1], lastSelected[2], lastSelected[3])
        end
    end)
end

function DungeonDocs:HandleSelected(dungeonName, enemyType, mobName)
    if enemyType == "bosses" then
        DungeonDocs:HandleSelectedBoss(dungeonName, mobName)
    else
        DungeonDocs:HandleSelectedTrash(dungeonName, mobName)
    end

    lastSelected = { dungeonName, enemyType, mobName }
end

local function resetNote(dungeonName, mobs)
    for _, mob in ipairs(mobs) do
        DD:DB_SetNote(dungeonName, mob.id, "primaryNote", nil)
        DD:DB_SetNote(dungeonName, mob.id, "tankNote", nil)
        DD:DB_SetNote(dungeonName, mob.id, "healerNote", nil)
        DD:DB_SetNote(dungeonName, mob.id, "damageNote", nil)
    end
end

function DungeonDocs:HandleSelectedBoss(dungeonName, bossName)
    local bosses = DD.Dungeons[dungeonName].bosses
    local boss

    -- Find the boss in the database
    for _, b in ipairs(bosses) do
        if b.bossName == bossName then
            boss = b
        end
    end

    -- Clean up previous runs
    rightGroup:ReleaseChildren()
    for _, model in pairs(models) do
        if model then
            model:ClearModel()
            model:Hide()
            model = nil
        end
    end
    models = {}

    -- Add a title for the page
    local titleLabel = AceGUI:Create("Label")
    titleLabel:SetText(boss.bossName)
    titleLabel:SetFontObject(GameFontNormalLarge) -- Sets the font to a larger style
    titleLabel:SetFullWidth(true)
    titleLabel.label:SetJustifyH("CENTER")
    rightGroup:AddChild(titleLabel)

    -- Render character models
    for _, mob in ipairs(boss.mobs) do
        local numMobs = #boss.mobs
        local widthPerModel = (1 / numMobs) * rightGroup.frame:GetWidth() -- Each model gets a fraction of the width

        local modelContainer = AceGUI:Create("SimpleGroup")


        -- Render enemy model
        modelContainer:SetWidth(widthPerModel)
        -- modelContainer:SetFullHeight(true)
        modelContainer:SetHeight(200)
        modelContainer:SetLayout("Fill")
        rightGroup:AddChild(modelContainer)

        local model = CreateFrame("PlayerModel", nil, modelContainer.frame)
        model:SetPoint("CENTER")
        model:SetSize(widthPerModel, 200)
        model:SetCamDistanceScale(1.5)
        model:SetModelScale(1)
        model:SetDisplayInfo(mob.displayId)

        table.insert(models, model)
    end


    local scrollFrame = AceGUI:Create("ScrollFrame")
    scrollFrame:SetLayout("Flow")
    scrollFrame:SetFullWidth(true)
    scrollFrame:SetFullHeight(true)
    rightGroup:AddChild(scrollFrame)

    RenderNote(dungeonName, boss.mobs, "primaryNote", "Primary notes", scrollFrame)
    RenderNote(dungeonName, boss.mobs, "tankNote", "Tank notes", scrollFrame)
    RenderNote(dungeonName, boss.mobs, "healerNote", "Healer notes", scrollFrame)
    RenderNote(dungeonName, boss.mobs, "damageNote", "DPS notes", scrollFrame)

    local button = AceGUI:Create("Button")
    local resetButtonText = "Reset Notes to Fallback Profile"
    button:SetText(resetButtonText)
    button:SetFullWidth(true)

    local confirming = false
    button:SetCallback("OnClick", function()
        if not confirming then
            button:SetText("Confirm")
            confirming = true
            return
        end

        resetNote(dungeonName, boss.mobs)
        confirming = false
        button:SetText(resetButtonText)
        DungeonDocs:HandleSelectedBoss(dungeonName, bossName)
    end)

    scrollFrame:AddChild(button)
end

function DungeonDocs:HandleSelectedTrash(dungeonName, mobName)
    local trash = DD.Dungeons[dungeonName].trash
    local mob

    -- Find the boss in the database
    for _, t in ipairs(trash) do
        if t.name == mobName then
            mob = t
        end
    end

    -- Clean up previous runs
    rightGroup:ReleaseChildren()
    for _, model in pairs(models) do
        if model then
            model:ClearModel()
            model:Hide()
            model = nil
        end
    end
    models = {}

    -- Add a title for the page
    local titleLabel = AceGUI:Create("Label")
    titleLabel:SetText(mob.name)
    titleLabel:SetFontObject(GameFontNormalLarge) -- Sets the font to a larger style
    titleLabel:SetFullWidth(true)
    titleLabel.label:SetJustifyH("CENTER")
    rightGroup:AddChild(titleLabel)


    -- Render character models

    local modelContainer = AceGUI:Create("SimpleGroup")
    local widthPerModel = rightGroup.frame:GetWidth()

    -- Render enemy model
    modelContainer:SetWidth(widthPerModel)
    -- modelContainer:SetFullHeight(true)
    modelContainer:SetHeight(200)
    modelContainer:SetLayout("Fill")
    rightGroup:AddChild(modelContainer)

    local model = CreateFrame("PlayerModel", nil, modelContainer.frame)
    model:SetPoint("CENTER")
    model:SetSize(widthPerModel, 200)
    model:SetCamDistanceScale(1.5)
    model:SetModelScale(1)
    model:SetDisplayInfo(mob.displayId)

    table.insert(models, model)



    local scrollFrame = AceGUI:Create("ScrollFrame")
    scrollFrame:SetLayout("Flow")
    scrollFrame:SetFullWidth(true)
    scrollFrame:SetFullHeight(true)
    rightGroup:AddChild(scrollFrame)

    RenderNote(dungeonName, { mob }, "primaryNote", "Primary notes", scrollFrame)
    RenderNote(dungeonName, { mob }, "tankNote", "Tank notes", scrollFrame)
    RenderNote(dungeonName, { mob }, "healerNote", "Healer notes", scrollFrame)
    RenderNote(dungeonName, { mob }, "damageNote", "DPS notes", scrollFrame)

    -- Create the button and position it to the right
    local button = AceGUI:Create("Button")
    local resetButtonText = "Reset Notes to Fallback Profile"
    button:SetText(resetButtonText)
    button:SetFullWidth(true)

    local confirming = false
    button:SetCallback("OnClick", function()
        if not confirming then
            button:SetText("Confirm")
            confirming = true
            return
        end

        resetNote(dungeonName, { mob })
        confirming = false
        button:SetText(resetButtonText)
        DungeonDocs:HandleSelectedTrash(dungeonName, mobName)
    end)

    scrollFrame:AddChild(button)
end

function RenderNote(dungeonName, mobs, noteKey, noteLabel, container)
    -- Add notes
    -- Create a SimpleGroup for the edit box to ensure proper layout
    local noteContainer = AceGUI:Create("SimpleGroup")
    noteContainer:SetFullWidth(true) -- Make it take the full width
    noteContainer:SetHeight(100)     -- Set a height for the edit box container
    noteContainer:SetLayout("Fill")
    container:AddChild(noteContainer)

    local mob = mobs[1]

    -- Add a Multi-Line Edit Box using a standard EditBox
    local note = AceGUI:Create("MultiLineEditBox")
    note:SetLabel(noteLabel)
    note:SetFullWidth(true)                                          -- Make the edit box take up the full width of the container
    note:SetText(DD:DB_GetNotePrimary(dungeonName, mob.id, noteKey)) -- You can prefill the edit box with text if needed
    note:DisableButton(true)                                         -- Disable the "Okay" button
    note:SetCallback("OnTextChanged", function(widget, event, text)
        for _, m in ipairs(mobs) do
            DD:DB_SetNote(dungeonName, m.id, noteKey, text)
        end
    end)
    noteContainer:AddChild(note)
end

function DungeonDocs:DungeonDataToTreeData()
    local db = self.db

    -- Get instances only from the selected season
    local instances = DD:Dungeons_GetCurrentSeason()

    local treeData = {}

    for _, d in pairs(instances) do
        local treeBosses = {}
        for _, b in ipairs(d.bosses) do
            local boss = {
                value = b.bossName,
                text = b.bossName,
                bossName = b.bossName,
                encounterId = b.encounterId,
                mobs = b.mobs
            }
            table.insert(treeBosses, boss)
        end

        local treeTrash = {}
        for _, m in ipairs(d.trash) do
            local mob = {
                value = m.name,
                text = m.name,
                name = m.name,
                id = m.id,
                displayId = m.displayId,
                primaryNote = m.primaryNote,
                roleNotes = m.roleNotes,
            }
            table.insert(treeTrash, mob)
        end
        -- Sort trash alphabetically
        table.sort(treeTrash, function(a, b)
            return a.value < b.value
        end)

        local treeDungeon = {
            value = d.name,
            text = d.name,
            name = d.name,
            icon = d.icon,
            children = {
                {
                    value = "bosses",
                    text = "Bosses",
                    children = treeBosses,
                },
                {
                    value = "trash",
                    text = "Trash",
                    children = treeTrash,
                }
            },
        }


        table.insert(treeData, treeDungeon)
    end

    -- Sort dungeons alphabetically
    table.sort(treeData, function(a, b)
        return a.name < b.name
    end)

    return treeData
end
