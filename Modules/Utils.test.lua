require("Modules.Utils")

describe("MergeDocs", function()
	---@type DungeonDocs
	local DD

	-- Setup: Retrieve the addon object
	before_each(function()
		DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs") ---@type DungeonDocs
	end)

	it("should merge two docs as expected", function()
		local profileDocs = {
			TestInstance1 = {
				{
					ddid = "test1_1",
					primaryNote = "primary",
					tankNote = "primary",
					healerNote = "",
					damageNote = nil,
				},
			},
			TestInstance2 = {
				{
					ddid = "test2_2",
					primaryNote = "primary",
					tankNote = "primary",
					healerNote = "primary",
					damageNote = "primary",
				},
			},
		}
		local fallbackProfileDocs = {
			TestInstance1 = {
				{
					ddid = "test1_1",
					primaryNote = "fallback",
					tankNote = "fallback",
					healerNote = "fallback",
					damageNote = "fallback",
				},
			},
			TestInstance3 = {
				{
					ddid = "test3_3",
					primaryNote = "fallback",
					tankNote = "fallback",
					healerNote = "fallback",
					damageNote = "fallback",
				},
			},
		}
		local expected = {
			TestInstance1 = {
				{
					ddid = "test1_1",
					primaryNote = "primary",
					tankNote = "primary",
					healerNote = "",
					damageNote = "fallback",
				},
			},
			TestInstance2 = {
				{
					ddid = "test2_2",
					primaryNote = "primary",
					tankNote = "primary",
					healerNote = "primary",
					damageNote = "primary",
				},
			},
			TestInstance3 = {
				{
					ddid = "test3_3",
					primaryNote = "fallback",
					tankNote = "fallback",
					healerNote = "fallback",
					damageNote = "fallback",
				},
			},
		}
		local actual = DD.utils.MergePlayerNotes(profileDocs, fallbackProfileDocs)
		assert.are.same(expected, actual)
	end)
end)

describe("RemoveFromArray", function()
	---@type DungeonDocs
	local DD

	before_each(function()
		DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs") ---@type DungeonDocs
	end)

	it("removes all occurrences of a value from an array table", function()
		local arr = { "a", "b", "c", "b", "d", "b" }
		DD.utils.RemoveFromArray(arr, "b")
		assert.are.same({ "a", "c", "d" }, arr)
	end)
end)
