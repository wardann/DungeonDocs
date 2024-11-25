

function BuildNoteCard(index, noteName, note, options)
    -- Create the main card frame
    local card = CreateFrame("Frame", "CardFrame" .. index, omniAnchorFrame2)

    if note.primaryNote == "" and note.tankNote == "" and note.healerNote == "" and note.damageNote == "" then
        card:SetSize(0, 0)
        return card
    end

    card:SetSize(options.width, 30)       -- Set a base width and height
    card.bg = card:CreateTexture(nil, "BACKGROUND")
    card.bg:SetAllPoints(card)            -- Ensure background fills the entire card
    card.bg:SetColorTexture(0, 0, 0, 0.5) -- Semi-transparent for visibility

    -- Ensure the card is visible
    card:Show()

    local totalHeight = 0
    local recordHeight = function(frame)
        totalHeight = totalHeight + frame:GetHeight()
    end

    local withPadding = function(padding)
        totalHeight = totalHeight + math.abs(padding)
        return padding
    end

    -- Create name frame
    local mobNameFrame = CreateFrame("Frame", "Name" .. index, card)
    mobNameFrame:SetPoint("TOP", card, "TOP", 0, 0) -- Offset from top of the card
    mobNameFrame:SetWidth(card:GetWidth())

    local mobName = mobNameFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    local fontPath, _, fontFlags = mobName:GetFont()     -- Retrieve the current font path and flags
    mobName:SetFont(fontPath, 20, fontFlags)             -- Set font with new size (e.g., 14)
    mobName:SetPoint("LEFT", mobNameFrame, "LEFT", 5, 0) -- Align to left of lineFrame with padding
    mobName:SetWidth(mobNameFrame:GetWidth() - 10)       -- Account for padding
    mobName:SetWordWrap(true)
    mobName:SetText(noteName)                            -- Set the text to display
    mobName:SetAlpha(1.0)
    mobName:SetJustifyH("LEFT")
    mobNameFrame:SetHeight(mobName:GetStringHeight())
    recordHeight(mobNameFrame)


    -- Create primary note frame
    local primaryNoteFrame = CreateFrame("Frame", "PrimaryNoteFrame" .. index, card)
    primaryNoteFrame:SetPoint("TOP", mobNameFrame, "BOTTOM", 0, withPadding(-5)) -- Position below the first line
    primaryNoteFrame:SetWidth(card:GetWidth())

    local primaryNote = primaryNoteFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    primaryNote:SetPoint("LEFT", primaryNoteFrame, "LEFT", 5, 0) -- Align to left with padding
    primaryNote:SetWidth(primaryNoteFrame:GetWidth() - 10)       -- Account for padding
    primaryNote:SetWordWrap(true)
    primaryNote:SetText(note.primaryNote)                       -- Placeholder text for debugging
    primaryNote:SetAlpha(1.0)
    primaryNote:SetJustifyH("LEFT")
    primaryNoteFrame:SetHeight(primaryNote:GetStringHeight())
    recordHeight(primaryNoteFrame)

    local previousFrame = primaryNoteFrame

    if note.tankNote ~= "" then
        -- Create tank header
        local tankHeaderFrame = CreateFrame("Frame", "TankHeaderFrame " .. index, card)
        tankHeaderFrame:SetPoint("TOP", previousFrame, "BOTTOM", 0, withPadding(-5)) -- Position below the first line
        tankHeaderFrame:SetWidth(card:GetWidth())

        local tankHeader = tankHeaderFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        tankHeader:SetPoint("LEFT", tankHeaderFrame, "LEFT", 5, 0) -- Align to left with padding
        tankHeader:SetWidth(tankHeaderFrame:GetWidth() - 10)       -- Account for padding
        tankHeader:SetWordWrap(true)
        tankHeader:SetText("[Tank]")                               -- Placeholder text for debugging
        tankHeader:SetAlpha(1.0)
        tankHeader:SetJustifyH("LEFT")
        tankHeaderFrame:SetHeight(tankHeader:GetStringHeight())
        recordHeight(tankHeaderFrame)

        -- Create tank note
        local tankNoteFrame = CreateFrame("Frame", "TankNoteFrame" .. index, card)
        tankNoteFrame:SetPoint("TOP", tankHeaderFrame, "BOTTOM", 0, withPadding(-5)) -- Position below the first line
        tankNoteFrame:SetWidth(card:GetWidth())

        local tankNote = tankNoteFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        tankNote:SetPoint("LEFT", tankNoteFrame, "LEFT", 5, 0) -- Align to left with padding
        tankNote:SetWidth(tankNoteFrame:GetWidth() - 10)       -- Account for padding
        tankNote:SetWordWrap(true)
        tankNote:SetText(note.tankNote)                        -- Placeholder text for debugging
        tankNote:SetAlpha(1.0)
        tankNote:SetJustifyH("LEFT")
        tankNoteFrame:SetHeight(tankNote:GetStringHeight())
        recordHeight(tankNoteFrame)

        previousFrame = tankNoteFrame
    end

    if note.healerNote ~= "" then
        -- Create healer header
        local healerHeaderFrame = CreateFrame("Frame", "HealerHeaderFrame" .. index, card)
        healerHeaderFrame:SetPoint("TOP", previousFrame, "BOTTOM", 0, withPadding(-5)) -- Position below the first line
        healerHeaderFrame:SetWidth(card:GetWidth())

        local healerHeader = healerHeaderFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        healerHeader:SetPoint("LEFT", healerHeaderFrame, "LEFT", 5, 0) -- Align to left with padding
        healerHeader:SetWidth(healerHeaderFrame:GetWidth() - 10)       -- Account for padding
        healerHeader:SetWordWrap(true)
        healerHeader:SetText("[Healer]")                               -- Placeholder text for debugging
        healerHeader:SetAlpha(1.0)
        healerHeader:SetJustifyH("LEFT")
        healerHeaderFrame:SetHeight(healerHeader:GetStringHeight())
        recordHeight(healerHeaderFrame)

        -- Create healer note
        local healerNoteFrame = CreateFrame("Frame", "HealerNoteFrame" .. index, card)
        healerNoteFrame:SetPoint("TOP", healerHeaderFrame, "BOTTOM", 0, withPadding(-5)) -- Position below the first line
        healerNoteFrame:SetWidth(card:GetWidth())

        local healerNote = healerNoteFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        healerNote:SetPoint("LEFT", healerNoteFrame, "LEFT", 5, 0) -- Align to left with padding
        healerNote:SetWidth(healerNoteFrame:GetWidth() - 10)       -- Account for padding
        healerNote:SetWordWrap(true)
        healerNote:SetText(note.healerNote)                        -- Placeholder text for debugging
        healerNote:SetAlpha(1.0)
        healerNote:SetJustifyH("LEFT")
        healerNoteFrame:SetHeight(healerNote:GetStringHeight())
        recordHeight(healerNoteFrame)

        previousFrame = healerNoteFrame
    end

    if note.damageNote ~= "" then
        -- Create damage header
        local damageHeaderFrame = CreateFrame("Frame", "DamageHeaderFrame" .. index, card)
        damageHeaderFrame:SetPoint("TOP", previousFrame, "BOTTOM", 0, withPadding(-5)) -- Position below the first line
        damageHeaderFrame:SetWidth(card:GetWidth())

        local damageHeader = damageHeaderFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        damageHeader:SetPoint("LEFT", damageHeaderFrame, "LEFT", 5, 0) -- Align to left with padding
        damageHeader:SetWidth(damageHeaderFrame:GetWidth() - 10)       -- Account for padding
        damageHeader:SetWordWrap(true)
        damageHeader:SetText("[Damage]")                               -- Placeholder text for debugging
        damageHeader:SetAlpha(1.0)
        damageHeader:SetJustifyH("LEFT")
        damageHeaderFrame:SetHeight(damageHeader:GetStringHeight())
        recordHeight(damageHeaderFrame)

        -- Create damage note
        local damageNoteFrame = CreateFrame("Frame", "DamageNoteFrame" .. index, card)
        damageNoteFrame:SetPoint("TOP", damageHeaderFrame, "BOTTOM", 0, withPadding(-5)) -- Position below the first line
        damageNoteFrame:SetWidth(card:GetWidth())

        local damageNote = damageNoteFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        damageNote:SetPoint("LEFT", damageNoteFrame, "LEFT", 5, 0) -- Align to left with padding
        damageNote:SetWidth(damageNoteFrame:GetWidth() - 10)       -- Account for padding
        damageNote:SetWordWrap(true)
        damageNote:SetText(note.damageNote)                        -- Placeholder text for debugging
        damageNote:SetAlpha(1.0)
        damageNote:SetJustifyH("LEFT")
        damageNoteFrame:SetHeight(damageNote:GetStringHeight())
        recordHeight(damageNoteFrame)

        previousFrame = damageNoteFrame
    end

    -- Set the total height of the card based on content
    card:SetHeight(totalHeight) -- Add padding as needed

    return card
end