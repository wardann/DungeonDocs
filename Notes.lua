local DungeonDocs = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local notePanels = {}

local notePanelPlaceholders = {
    primary = "PRIMARY NOTE",
    role = "ROLE NOTE",
}

local noteContent = {
    primary = nil,
    role = nil,
}

DungeonDocs:SubscribeToDBChange(function()
    DungeonDocs:Notes_SyncNotesWithTarget()
end)

-- Create the text panel frame
function DungeonDocs:InitNotePanels()
    local notesPositions = self.db.profile.notes.positions

    -- Primary note panel
    InitNotePanel("primary", notesPositions.primary, "TOP")

    -- Role note panel
    InitNotePanel("role", notesPositions.secondary, "TOPLEFT")

    -- Initial render
    DungeonDocs:RenderNotePanels()
end

function InitNotePanel(noteName, framePosition, defaultPosition)
    -- Create a frame to display the text
    local textFrame = CreateFrame("Frame", "TextPanel", UIParent)
    textFrame:SetSize(300, 100)  -- Set the size of the panel
    textFrame:EnableMouse(false) -- Disable mouse interactions initially
    textFrame:SetMovable(false)  -- Initially immovable

    -- Create a background for the frame
    textFrame.bg = textFrame:CreateTexture(nil, "BACKGROUND")
    textFrame.bg:SetAllPoints(textFrame)
    textFrame.bg:SetColorTexture(0, 0, 0, 0) -- Fully transparent initially

    -- Create a font string for the text
    textFrame.text = textFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    textFrame.text:SetPoint("CENTER")
    textFrame.text:SetText("") -- Initially blank text

    -- Use the position from the user, else use the default
    if framePosition then
        local f = framePosition
        textFrame:SetPoint(f[1], UIParent, f[2], f[3], f[4])
    else
        textFrame:SetPoint(defaultPosition, UIParent, defaultPosition, 0, -50) -- Center at the top of the screen
    end

    notePanels[noteName] = textFrame
end

function DungeonDocs:Notes_SaveFrameCoordinates(noteName)
    local notesPositions = self.db.profile.notes.positions
    local textFrame = notePanels[noteName]

    -- Get the anchor point and position (relative to parent)
    local point, relativeTo, relativePoint, xOffset, yOffset = textFrame:GetPoint()

    -- Print the coordinates in the chat window
    notesPositions[noteName] = { point, relativePoint, xOffset, yOffset }
end

function DungeonDocs:RenderNotePanels()
    local moversEnabled = self.db.profile.settings.internal.movers

    if moversEnabled then
        RenderNotePanelMovers("primary")
        RenderNotePanelMovers("role")
    else
        RenderNotePanelNotes("primary")
        RenderNotePanelNotes("role")
    end
end

function RenderNotePanelMovers(noteName)
    local textFrame = notePanels[noteName]

    textFrame:EnableMouse(true)             -- Enable mouse interactions
    textFrame:SetMovable(true)              -- Allow movement
    textFrame:RegisterForDrag("LeftButton") -- Enable dragging
    textFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    textFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        DungeonDocs:Notes_SaveFrameCoordinates(noteName)
    end)

    -- Set placeholder text
    textFrame.text:SetText(notePanelPlaceholders[noteName])

    -- Set a transparent gray background
    textFrame.bg:SetColorTexture(0, 0, 0, 0.5) -- 50% transparent gray
end

function RenderNotePanelNotes(noteName)
    local textFrame = notePanels[noteName]
    -- Switch to the blank, immovable state
    textFrame:EnableMouse(false)                  -- Disable mouse interactions
    textFrame:SetMovable(false)                   -- Make it immovable
    textFrame.text:SetText(noteContent[noteName]) -- Clear the text
    textFrame.bg:SetColorTexture(0, 0, 0, 0)      -- Make the background fully transparent
end

local function deriveRoleNoteKey()
    local specIndex = GetSpecialization()
    local specRole
    if specIndex then
        specRole = GetSpecializationRole(specIndex)
    end

    if specRole == "TANK" then
        return "tankNote"
    elseif specRole == "HEALER" then
        return "healerNote"
    elseif specRole == "DAMAGER" then
        return "damageNote"
    else
        print("DungeonDocs: error, could not determine spec role")
    end
end

function DungeonDocs:Notes_SyncNotesWithTarget()
    -- Check if the player has a target
    local targetName = UnitName("target") -- Get the name of the current target

    -- If player does not have a target, clear out the notes
    if not targetName then
        noteContent["primary"] = nil
        noteContent["role"] = nil
        DungeonDocs:RenderNotePanels()
        return
    end

    local targetId = GetMobIDFromGUID("target")
    if not targetId then
        return
    end

    local currentInstanceName, currentInstanceType = GetInstanceInfo()
    if currentInstanceType ~= "party" then
        return
    end

    local docs = self.db.profile.docs
    local roleNoteKey = deriveRoleNoteKey()

    for _, instance in pairs(docs) do
        if instance.nameFull == currentInstanceName then
            -- Scan bosses for a matching mob id first
            local found = false
            for _, encounter in ipairs(instance.bosses) do
                for _, boss in ipairs(encounter.mobs) do
                    if boss.id == targetId then
                        noteContent["primary"] = encounter.primaryNote
                        noteContent["role"] = encounter[roleNoteKey]
                        found = true
                    end
                end
            end

            if found then break end

            -- Scan mobs for a matching mob id
            for _, mob in pairs(instance.trash) do
                if mob.id == targetId then
                    noteContent["primary"] = mob.primaryNote
                    noteContent["role"] = mob[roleNoteKey]
                    found = true
                end
            end
        end
    end

    DungeonDocs:RenderNotePanels()
end

-- -- Create a function to display text on screen
-- function DungeonDocs:DisplayTextOnScreen(text)
--     -- Create a frame to show text on the screen
--     if not self.textFrame then
--         self.textFrame = CreateFrame("MessageFrame", "DungeonDocsTextFrame", UIParent)
--         self.textFrame:SetSize(600, 100)  -- Width and height
--         self.textFrame:SetPoint("CENTER", 0, 200)  -- Center of the screen
--         self.textFrame:SetFontObject(GameFontNormalLarge)
--         self.textFrame:SetInsertMode("TOP")  -- Show text at the top of the frame
--         self.textFrame:SetFading(true)  -- Enable fading
--         self.textFrame:SetFadeDuration(3)  -- Fade out after 3 seconds
--         self.textFrame:SetTimeVisible(5)  -- How long to display the message
--     end

--     -- Display the text
--     self.textFrame:AddMessage(text, 1.0, 1.0, 1.0)  -- White color text (RGB)
-- end
