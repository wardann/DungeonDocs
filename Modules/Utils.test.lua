require("Modules.Utils")

describe("MergeDocs", function()
	---@type DungeonDocs
	local DD

	-- Setup: Retrieve the addon object
	before_each(function()
		DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs") ---@type DungeonDocs
	end)

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

	it("should merge two docs as expected", function()
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

	it("should be able to handle nils", function()
		---@diagnostic disable-next-line
		assert.has_no.errors(function()
			local actual = DD.utils.MergePlayerNotes(nil, fallbackProfileDocs)
			assert.are.same(fallbackProfileDocs, actual)
		end)

		---@diagnostic disable-next-line
		assert.has_no.errors(function()
			local actual = DD.utils.MergePlayerNotes(profileDocs, nil)
			assert.are.same(profileDocs, actual)
		end)

		---@diagnostic disable-next-line
		assert.has_no.errors(function()
			local actual = DD.utils.MergePlayerNotes(nil, nil)
			assert.are.same({}, actual)
		end)
	end)
end)
