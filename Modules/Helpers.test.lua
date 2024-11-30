require("Modules.Helpers")

describe("MergeDocs", function()
    it("should merge two docs as expected", function()
        local profileDocs = {
            TestInstance1 = {
                {
                    id = 1,
                    primaryNote = "primary",
                    tankNote = "primary",
                    healerNote = "",
                    damageNote = nil,
                }
            },
            TestInstance2 = {
                {
                    id = 2,
                    primaryNote = "primary",
                    tankNote = "primary",
                    healerNote = "primary",
                    damageNote = "primary",
                }
            }

        }
        local fallbackProfileDocs = {
            TestInstance1 = {
                {
                    id = 1,
                    primaryNote = "fallback",
                    tankNote = "fallback",
                    healerNote = "fallback",
                    damageNote = "fallback",
                },
            },
            TestInstance3 = {
                {
                    id = 3,
                    primaryNote = "fallback",
                    tankNote = "fallback",
                    healerNote = "fallback",
                    damageNote = "fallback",
                }
            }
        }
        local expected = {
            TestInstance1 = {
                {
                    id = 1,
                    primaryNote = "primary",
                    tankNote = "primary",
                    healerNote = "",
                    damageNote = "fallback",
                }
            },
            TestInstance2 = {
                {
                    id = 2,
                    primaryNote = "primary",
                    tankNote = "primary",
                    healerNote = "primary",
                    damageNote = "primary",
                }
            },
            TestInstance3 = {
                {
                    id = 3,
                    primaryNote = "fallback",
                    tankNote = "fallback",
                    healerNote = "fallback",
                    damageNote = "fallback",
                }
            }
        }
        local actual = MergeDocs(profileDocs, fallbackProfileDocs)
        assert.are.same(expected, actual)
    end)
end)
