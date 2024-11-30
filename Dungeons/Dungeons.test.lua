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
        assert.are.equal(totalNoteStructureCount, 190)
    end)
end)
