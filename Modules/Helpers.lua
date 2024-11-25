function MergeDocs(profileDocs, fallbackProfileDocs)
    local docs = {}
    for instance, mobs in pairs(profileDocs) do
        if not docs[instance] then
            docs[instance] = {}
        end

        for _, mob in ipairs(mobs) do
            docs[instance][mob.id] = mob
        end
    end

    -- LogTableToBugSack(fallbackProfileDocs)

    -- now add the fallback docs where applicable
    for instance, mobs in pairs(fallbackProfileDocs) do
        if not docs[instance] then
            docs[instance] = {}
        end

        for _, mob in ipairs(mobs) do
            (function()
                local found = docs[instance][mob.id]
                if not found then
                    docs[instance][mob.id] = mob
                    return
                end

                local function shouldUseFallback(note, fallbackNote)
                    return not note and fallbackNote and #fallbackNote > 0
                end

                if shouldUseFallback(found.primaryNote, mob.primaryNote) then
                    found.primaryNote = mob.primaryNote
                end

                if shouldUseFallback(found.tankNote, mob.tankNote) then
                    found.tankNote = mob.tankNote
                end

                if shouldUseFallback(found.healerNote, mob.healerNote) then
                    found.healerNote = mob.healerNote
                end

                if shouldUseFallback(found.damageNote, mob.damageNote) then
                    found.damageNote = mob.damageNote
                end
            end)()
        end
    end

    local docsFinal = {}

    for instance, mobs in pairs(docs) do
        for _, mob in pairs(mobs) do
            if not docsFinal[instance] then
                docsFinal[instance] = {}
            end
            table.insert(docsFinal[instance], mob)
        end
    end

    return docsFinal
end

function IsTableEmpty(tbl)
    return next(tbl) == nil
end

function TableToString(tbl, indent)
    indent = indent or ""
    local result = "{\n"
    local nextIndent = indent .. "  "


    for k, v in pairs(tbl) do
        local key = tostring(k)
        if type(v) == "table" then
            result = result .. nextIndent .. key .. " = " .. TableToString(v, nextIndent) .. ",\n"
        else
            result = result .. nextIndent .. key .. " = " .. tostring(v) .. ",\n"
        end
    end

    return result .. indent .. "}"
end

-- Function to log the human-readable table string to BugSack
function LogTableToBugSack(msg, tbl)
    local readableTable = TableToString(tbl)
    error(msg .. "\n\n" .. readableTable) -- Triggers BugSack to capture the output
end