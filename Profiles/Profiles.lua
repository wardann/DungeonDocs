local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")


local reservedProfileNames = {}

function DD:Profiles_ReserveProfileName(profileName)
    table.insert(reservedProfileNames, profileName)
end


function Profiles_IsReservedProfile(profileName)
    for _, value in ipairs(reservedProfileNames) do
        if value == profileName then
            return true
        end
    end
    return false
end

function DD:Profiles_BuildDungeonDocs(dungeonData)
    local dungeonDocs = {}

    for _, boss in ipairs(dungeonData.bosses) do
        for _, mob in ipairs(boss.mobs) do
            table.insert(dungeonDocs, {
                name = mob.name,
                id = mob.id,
                primaryNote = boss.primaryNote,
                healerNote = boss.healerNote,
                damageNote = boss.damageNote,
                tankNote = boss.tankNote,
            })
        end
    end

    for _, mob in ipairs(dungeonData.trash) do
        table.insert(dungeonDocs, {
            name = mob.name,
            id = mob.id,
            primaryNote = mob.primaryNote,
            healerNote = mob.healerNote,
            damageNote = mob.damageNote,
            tankNote = mob.tankNote,
        })
    end

    return dungeonDocs
end

function DD:Profiles_Init()
    DD:ProfilesDefault_Init()
end
