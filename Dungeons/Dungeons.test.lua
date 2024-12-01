require("Dungeons.Dungeons")
require("Dungeons.TWW.S1.AraKara")
require("Dungeons.TWW.S1.CityOfThreads")
require("Dungeons.TWW.S1.GrimBatol")
require("Dungeons.TWW.S1.MistsOfTirnaScithe")
require("Dungeons.TWW.S1.SiegeOfBoralus")
require("Dungeons.TWW.S1.TheDawnbreaker")
require("Dungeons.TWW.S1.TheNecroticWake")
require("Dungeons.TWW.S1.TheStonevault")

local dungeonChecker = function(dungeons)
    local foundPrefixes = {}

    local isFoundPrefix = function(prefix)
        for _, foundPrefix in ipairs(foundPrefixes) do
            if foundPrefix == prefix then
                return true
            end
        end
        return false
    end


    local totalNoteStructureCount = 0

    for name, data in pairs(dungeons) do
        local dungeonPrefix

        for i, note in ipairs(data.noteStructures) do
            local prefix, number = note.ddid:match("(%a+)(%d+)")
            if i == 1 then
                dungeonPrefix = prefix
                if isFoundPrefix(dungeonPrefix) then
                    error("dungeon prefix is not unique across dungeons: " .. note.ddid)
                else
                    table.insert(foundPrefixes, prefix)
                end
            else
                if dungeonPrefix ~= prefix then
                    error("dungeon prefix is not the same throughout dungeon: " .. note.ddid)
                end
            end

            if tostring(i) ~= number then
                error("dungeon prefix not incrementing as expected for DDID: " .. note.ddid)
            end

            totalNoteStructureCount = totalNoteStructureCount + 1
        end
    end

    return totalNoteStructureCount
end

describe("dungeonChecker", function()
    it("valid DDIDs should pass", function()
        local dungeons = {
            dungeon = {
                noteStructures = {
                    {
                        ddid = "dh1",
                    },
                    {
                        ddid = "dh2",
                    }
                }
            }
        }
        assert.has_no.error(function()
            dungeonChecker(dungeons)
        end)
    end)

    it("repeated DDIDs should error", function()
        local dungeons = {
            dungeon = {
                noteStructures = {
                    {
                        ddid = "dh1",
                    },
                    {
                        ddid = "dh1",
                    }
                }
            }
        }
        assert.has_error(function()
            dungeonChecker(dungeons)
        end, "dungeon prefix not incrementing as expected for DDID: dh1")
    end)

    it("different DDID prefixes in the same dungeon should error", function()
        local dungeons = {
            dungeon = {
                noteStructures = {
                    {
                        ddid = "dh1",
                    },
                    {
                        ddid = "vh1",
                    }
                }
            }
        }
        assert.has_error(function()
            dungeonChecker(dungeons)
        end, "dungeon prefix is not the same throughout dungeon: vh1")
    end)

    it("repeated DDIDs across dungeons should error", function()
        local dungeons = {
            dungeon1 = {
                noteStructures = {
                    {
                        ddid = "dh1",
                    },
                }
            },
            dungeon2 = {
                noteStructures = {
                    {
                        ddid = "dh1",
                    },
                }
            }
        }
        assert.has_error(function()
            dungeonChecker(dungeons)
        end, "dungeon prefix is not unique across dungeons: dh1")
    end)
end)


describe("Dungeons Module", function()
    local DD
    local totalNoteStructureCount

    -- Setup: Retrieve the addon object
    before_each(function()
        DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
    end)

    it("should initialize all dungeons without errors", function()
        assert.has_no.errors(function()
            DD:Dungeons_InitAll()
        end)
    end)

    it("should have expected DDID properties in note structures", function()
        assert.has_no.errors(function()
            totalNoteStructureCount = dungeonChecker(DD.Dungeons)
        end)
    end)

    it("should have expected note structure count", function()
        assert.are.equal(totalNoteStructureCount, 189)
    end)
end)

describe("DD:Dungeons_IsBossInDungeon", function()
    local DD
    before_each(function()
        DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
        DD:Dungeons_InitAll()
    end)

    it("should be able to resolve boss if in dungeon", function()
        local avanoxxID = 213179
        local dungeonName = "Ara-Kara, City of Echoes"
        local isBossInDungeon = DD:Dungeons_IsBossInDungeon(avanoxxID, dungeonName)

        assert.is_true(isBossInDungeon)
    end)

    it("should NOT be able to resolve boss if NOT in dungeon", function()
        local badID = 101010
        local dungeonName = "Ara-Kara, City of Echoes"
        local isBossInDungeon = DD:Dungeons_IsBossInDungeon(badID, dungeonName)

        assert.is_false(isBossInDungeon)
    end)
end)

describe("DD:Dungeons_MobIdToNoteName", function()
    local DD
    before_each(function()
        DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
        DD:Dungeons_InitAll()
    end)

    it("should be able to resolve boss if in dungeon", function()
        local avanoxxID = 213179
        local dungeonName = "Ara-Kara, City of Echoes"
        local noteName = DD:Dungeons_MobIdToNoteName(avanoxxID, dungeonName)

        assert.is_equal("Avanoxx", noteName)
    end)

    it("should NOT be able to resolve boss if NOT in dungeon", function()
        local badID = 101010
        local dungeonName = "Ara-Kara, City of Echoes"
        local noteName = DD:Dungeons_MobIdToNoteName(badID, dungeonName)

        assert.is_nil(noteName)
    end)
end)

describe("DD:Dungeons_MobIdToDungeonName", function()
    local DD
    before_each(function()
        DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
        DD:Dungeons_InitAll()
    end)

    it("should be able to resolve dungeon name if good mob id", function()
        local avanoxxID = 213179
        local dungeonName = DD:Dungeons_MobIdToDungeonName(avanoxxID, dungeonName)

        assert.is_equal("Ara-Kara, City of Echoes", dungeonName)
    end)

    it("should NOT be able to resolve dungeon name if bad mob id", function()
        local badID = 101010
        local dungeonName = DD:Dungeons_MobIdToDungeonName(badID, dungeonName)

        assert.is_nil(dungeonName)
    end)
end)

describe("DD:Dungeons_MobIDToDDID", function()
    local DD
    before_each(function()
        DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")
        DD:Dungeons_InitAll()
    end)

    it("should be able to resolve DDID if good mob id", function()
        local avanoxxID = 213179
        local dungeonName = "Ara-Kara, City of Echoes"
        local ddid = DD:Dungeons_MobIDToDDID(avanoxxID, dungeonName)

        assert.is_equal("ak1", ddid)
    end)

    it("should NOT be able to resolve DDID if bad mob id", function()
        local badID = 101010
        local dungeonName = "Ara-Kara, City of Echoes"
        local ddid = DD:Dungeons_MobIDToDDID(badID, dungeonName)

        assert.is_nil(ddid)
    end)
end)
