local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

local treeGroup
local rightGroup
local models = {}


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
        if enemyType == "bosses" then
            DungeonDocs:HandleSelectedBoss(dungeonName, mobName)
        else
            DungeonDocs:HandleSelectedTrash(dungeonName, mobName)
        end
    end)

    rightGroup = AceGUI:Create("SimpleGroup")
    rightGroup:SetFullWidth(true)
    rightGroup:SetFullHeight(true)
    rightGroup:SetLayout("Flow")
    treeGroup:AddChild(rightGroup)
end

function DungeonDocs:HandleSelectedBoss(dungeonName, bossName)
    local bosses = self.db.profile.docs[dungeonName].bosses
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

    RenderNote(boss, "primaryNote", "Primary notes")
    RenderNote(boss, "tankNote", "Tank notes")
    RenderNote(boss, "healerNote", "Healer notes")
    RenderNote(boss, "damageNote", "DPS notes")
end

function DungeonDocs:HandleSelectedTrash(dungeonName, mobName)
    local trash = self.db.profile.docs[dungeonName].trash
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

    RenderNote(mob, "primaryNote", "Primary notes")
    RenderNote(mob, "tankNote", "Tank notes")
    RenderNote(mob, "healerNote", "Healer notes")
    RenderNote(mob, "damageNote", "DPS notes")
end

function RenderNote(dbEntry, noteKey, noteLabel)
    -- Add notes
    -- Create a SimpleGroup for the edit box to ensure proper layout
    local noteContainer = AceGUI:Create("SimpleGroup")
    noteContainer:SetFullWidth(true) -- Make it take the full width
    noteContainer:SetHeight(100)     -- Set a height for the edit box container
    noteContainer:SetLayout("Fill")
    rightGroup:AddChild(noteContainer)

    -- Add a Multi-Line Edit Box using a standard EditBox
    local note = AceGUI:Create("MultiLineEditBox")
    note:SetLabel(noteLabel)
    note:SetFullWidth(true)        -- Make the edit box take up the full width of the container
    note:SetText(dbEntry[noteKey]) -- You can prefill the edit box with text if needed
    note:DisableButton(true)       -- Disable the "Okay" button
    note:SetCallback("OnTextChanged", function(widget, event, text)
        DungeonDocs:DB_Update(function()
            dbEntry[noteKey] = text
        end)
    end)
    noteContainer:AddChild(note)
end

function DungeonDocs:DungeonDataToTreeData()
    local db = self.db

    -- Get instances only from the selected season
    local instances = {}
    for instanceName, instance in pairs(db.profile.docs) do
        if instance.seasonId == db.profile.internal.selectedSeason then
            instances[instanceName] = instance
        end
    end

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

        local treeDungeon = {
            value = d.name,
            text = d.name,
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

    return treeData
end
