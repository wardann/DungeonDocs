local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


DD.Profiles = {}

local reservedProfileNames = {
    "Default*"
}

function Profiles_IsReservedProfile(profileName)
    for _, value in ipairs(reservedProfileNames) do
        if value == profileName then
            return true
        end
    end
    return false
end

function DD:Profiles_InitProfile(profileName, dungeon)
    if not DD.Profiles[profileName] then
        DD.Profiles[profileName] = {}
    end

    local docs = {}

    for _, boss in ipairs(dungeon.bosses) do
        for _, mob in ipairs(boss.mobs) do
            table.insert(docs, {
                name = mob.name,
                id = mob.id,
                primaryNote = boss.primaryNote,
                healerNote = boss.healerNote,
                damageNote = boss.damageNote,
                tankNote = boss.tankNote,
            })
        end
    end

    for _, mob in ipairs(dungeon.trash) do
        table.insert(docs, {
            name = mob.name,
            id = mob.id,
            primaryNote = mob.primaryNote,
            healerNote = mob.healerNote,
            damageNote = mob.damageNote,
            tankNote = mob.tankNote,
        })
    end

    DD.Profiles[profileName][dungeon.name] = docs
end
