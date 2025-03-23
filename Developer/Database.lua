---@class DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

---@class DeveloperDB
local M = {}

---@class Developer
DD.developer = DD.developer or {}

---@alias DevDatabaseSchema {
---    instanceCapture: InstanceCapture,
---}
---

---@type DevDatabaseSchema
local devDBDefaults = {
    instanceCapture = {},
}

---@param profile DevDatabaseSchema
---@param defaults DevDatabaseSchema
local function applyDefaults(profile, defaults)
	--- NOTE: the types aren't getting inferred correctly here.
	--- Unsure how to solve, disabling for now
	---@diagnostic disable-next-line
	for key, value in pairs(defaults) do
		if profile[key] == nil then
			---@diagnostic disable-next-line
			profile[key] = DD.utils.DeepCopy(value)
		elseif type(value) == "table" and type(profile[key]) == "table" then
			---@diagnostic disable-next-line
			applyDefaults(profile[key], value) -- Recursively apply for nested tables
		end
	end
end


function M.Init()
	local defaultProfileName = "Default"

	-- Empty defaults {} are used here so everything gets flushed to disk and missing fields
	-- aren't encountered due to the on-demand pruning AceDB does
	DD.developer.database = LibStub("AceDB-3.0"):New("DungeonDocsDevDB", {}, defaultProfileName) ---@type AceDBDeveloper

	-- If there is no default profile, then this is the first time the addon is running. Apply
	-- defaults directly to the active profile to ensure all fields are there as expected
	if not DD.developer.database.profiles[defaultProfileName] then
		applyDefaults(DD.developer.database.profile, devDBDefaults)
	end
end

---@class DeveloperDB
DD.developer.db = M