--- @class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
local AceGUI = LibStub("AceGUI-3.0")

--- @class DocsUI
local M = {}

--- @type TreeGroup
local treeGroup

local rightGroup

local models = {}


--- @param localTreeGroup TreeGroup
--- @param treeData table
local function setTreeGroupFocus(localTreeGroup, treeData)
    local targetId = DD.utils.GetMobIDFromGUID("target")
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
                    for _, mob in ipairs(mobOrBoss.mobs) do
                        if mob.id == targetId then
                            localTreeGroup:SelectByPath(instance.value, mobType.value, mobOrBoss.value)
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
function M.TabRoot(container)
    -- Create a TreeGroup for the hierarchical mob list
    treeGroup = AceGUI:Create("TreeGroup")
    treeGroup:SetLayout("Fill")
    treeGroup:SetFullWidth(true)
    treeGroup:SetFullHeight(true)
    treeGroup:SetTreeWidth(200, false) -- Set the width of the tree part
    container:AddChild(treeGroup)

    -- Set the tree data
    local treeData = M.DungeonDataToTreeData()
    treeGroup:SetTree(treeData)

    -- Set a callback for when a node is selected
    treeGroup:SetCallback("OnGroupSelected", function(_, _, uniquePath)
        local pathComponents = { strsplit("\001", uniquePath) }
        local numComponents = #pathComponents

        if numComponents < 3 then
            return
        end

        local dungeonName, enemyType, noteName = pathComponents[1], pathComponents[2], pathComponents[3]
        M.HandleSelected(dungeonName, enemyType, noteName)
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
            treeGroup:SelectByPath(lastSelected[1], lastSelected[2], lastSelected[3])
        end
    end)
end

local function resetNote(dungeonName, note)
    DD.db.SetNote(dungeonName, note.ddid, "primaryNote", nil)
    DD.db.SetNote(dungeonName, note.ddid, "tankNote", nil)
    DD.db.SetNote(dungeonName, note.ddid, "healerNote", nil)
    DD.db.SetNote(dungeonName, note.ddid, "damageNote", nil)
end

function M.ClearModels()
    for _, model in pairs(models) do
        if model then
            model:ClearModel()
            model:Hide()
        end
    end
    models = {}
end

--- @param dungeonName string
--- @param enemyType "boss"|"trash"
--- @param noteName string
function M.HandleSelected(dungeonName, enemyType, noteName)
    local notes = DD.dungeons.List[dungeonName].noteStructures
    local note

    -- Find the boss in the database
    for _, n in ipairs(notes) do
        if n.noteName == noteName then
            note = n
        end
    end

    -- Clean up previous runs
    rightGroup:ReleaseChildren()
    M.ClearModels()

    -- Add a title for the page
    local titleLabel = AceGUI:Create("Label")
    titleLabel:SetText(note.noteName)
    titleLabel:SetFontObject(GameFontNormalLarge) -- Sets the font to a larger style
    titleLabel:SetFullWidth(true)
    titleLabel.label:SetJustifyH("CENTER")
    rightGroup:AddChild(titleLabel)

    local mobsToRender = {}
    for _, mob in ipairs(note.mobs) do
        if not mob.hideModel then
            table.insert(mobsToRender, mob)
        end
    end

    if enemyType == "trash" then
        mobsToRender = { note.mobs[1] }
    end

    -- Render character models
    for _, mob in ipairs(mobsToRender) do
        local numMobs = #mobsToRender
        local widthPerModel = (1 / numMobs) * rightGroup.frame:GetWidth() -- Each model gets a fraction of the width

        local modelContainer = AceGUI:Create("SimpleGroup")


        -- Render enemy model
        modelContainer:SetWidth(widthPerModel)
        -- modelContainer:SetFullHeight(true)
        modelContainer:SetHeight(200)
        modelContainer:SetLayout("Fill")
        rightGroup:AddChild(modelContainer)

        --- @type PlayerModel
        local model = CreateFrame("PlayerModel", nil, modelContainer.frame) --[[@as PlayerModel]]
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

    M.RenderNote(dungeonName, note, "primaryNote", "Primary notes", scrollFrame)
    M.RenderNote(dungeonName, note, "tankNote", "Tank notes", scrollFrame)
    M.RenderNote(dungeonName, note, "healerNote", "Healer notes", scrollFrame)
    M.RenderNote(dungeonName, note, "damageNote", "DPS notes", scrollFrame)

    local testNoteButton = AceGUI:Create("Button")
    testNoteButton:SetText("Render Notes")
    testNoteButton:SetFullWidth(true)
    testNoteButton:SetCallback("OnClick", function()
        DD.omniNote.RenderTestNote(note.ddid, dungeonName)
    end)
    scrollFrame:AddChild(testNoteButton)

    local button = AceGUI:Create("Button")
    local resetButtonText = "Reset Notes to Fallback Profile"
    button:SetText(resetButtonText)
    button:SetFullWidth(true)

    local confirming = false
    local doubleConfirm = false
    button:SetCallback("OnClick", function()
        if not confirming then
            button:SetText("Confirm")
            confirming = true
            return
        end

        if not doubleConfirm then
            button:SetText("You totally sure?")
            doubleConfirm = true
            return
        end

        resetNote(dungeonName, note)
        confirming = false
        button:SetText(resetButtonText)
        M.HandleSelected(dungeonName, enemyType, noteName)
    end)

    scrollFrame:AddChild(button)
    lastSelected = { dungeonName, enemyType, noteName }
end

function M.RenderNote(dungeonName, note, noteKey, noteLabel, container)
    -- Add notes
    -- Create a SimpleGroup for the edit box to ensure proper layout
    local noteContainer = AceGUI:Create("SimpleGroup")
    noteContainer:SetFullWidth(true) -- Make it take the full width
    noteContainer:SetHeight(100)     -- Set a height for the edit box container
    noteContainer:SetLayout("Fill")
    container:AddChild(noteContainer)

    -- Add a Multi-Line Edit Box using a standard EditBox
    local noteTextBox = AceGUI:Create("MultiLineEditBox")
    noteTextBox:SetLabel(noteLabel)
    noteTextBox:SetFullWidth(true)                                             -- Make the edit box take up the full width of the container

    noteTextBox:SetText(DD.db.GetNotePrimary(dungeonName, note.ddid, noteKey)) -- You can prefill the edit box with text if needed
    noteTextBox:DisableButton(true)                                            -- Disable the "Okay" button
    noteTextBox:SetCallback("OnTextChanged", function(_, _, text)
        DD.db.SetNote(dungeonName, note.ddid, noteKey, text)
    end)
    noteContainer:AddChild(noteTextBox)
end

--- @returns table
function M.DungeonDataToTreeData()
    -- Get instances only from the selected season
    local instances = DD.dungeons.GetCurrentSeason()

    local treeData = {}

    for _, d in pairs(instances) do
        local treeBosses = {}
        local treeTrash = {}

        for _, noteStruct in ipairs(d.noteStructures) do
            local target = treeTrash
            if noteStruct.isBoss then target = treeBosses end

            local note = {
                value = noteStruct.noteName,
                text = noteStruct.noteName,
                noteName = noteStruct.noteName,
                mobs = noteStruct.mobs,
                isBoss = noteStruct.isBoss,
                ddid = noteStruct.ddid,
            }
            table.insert(target, note)
        end

        -- Sort trash alphabetically
        table.sort(treeTrash, function(a, b)
            return a.value < b.value
        end)

        local treeDungeon = {
            value = d.dungeonName,
            text = d.dungeonName,
            name = d.dungeonName,
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

--- @class UI
DD.ui = DD.ui or {}
DD.ui.docs = M