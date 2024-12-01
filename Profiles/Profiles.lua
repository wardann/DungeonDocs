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

    local function shouldInsert(mob)
        return mob.primaryNote ~= "" or mob.healerNote ~= "" or mob.damageNote ~= "" or mob.tankNote ~= ""
    end

    for _, boss in ipairs(dungeonData.bosses) do
        for _, mob in ipairs(boss.mobs) do
            if shouldInsert(boss) then
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
    end

    for _, mob in ipairs(dungeonData.trash) do
        if shouldInsert(mob) then
            table.insert(dungeonDocs, {
                name = mob.name,
                id = mob.id,
                primaryNote = mob.primaryNote,
                healerNote = mob.healerNote,
                damageNote = mob.damageNote,
                tankNote = mob.tankNote,
            })
        end
    end

    return dungeonDocs
end

function DD:Profiles_Init()
    DD:ProfilesDefaultFallback_Init()

    -- Bootstrap player Default profile 
    if not self.db.profiles["Default"] then
        self.db.profiles["Default"] = {}
    end

    -- Set Default profile as active if no profile is active
    if not self.db.profile then
        self.db:SetProfile("Default")
    end
end
