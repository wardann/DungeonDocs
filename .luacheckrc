--- @diagnostic disable
-- luacheck: ignore


-- Do not allow global variables/functions unless explicitly declared
std = "lua52"

exclude_files = {
    "Libs/**",
}

-- Specify allowed globals (e.g., WoW API or Ace3 globals)
globals = {
    -- Placeholder for unused vars
    "_",
    -- Testing vars
    "describe",
    "it",
    "before_each",
    "after_each",
    "setup",
    "teardown",
    "assert",
    "spy",
    "mock",
    "LibStub",          -- Allow Ace3's LibStub
    --  "AceAddon-3.0",  -- Example: AceAddon global
    "CreateFrame",      -- WoW API function
    "GetAddOnMetadata", -- WoW API function
    "UnitGUID",         -- WoW API function
    "strsplit",
    "UIParent",
    "C_AddOns",
    "GetMobIDFromGUID",
    "GetInstanceInfo",
    "UnitName",
    "IsInGroup",
    "SendChatMessage",
    "LE_PARTY_CATEGORY_INSTANCE",
    "LE_PARTY_CATEGORY_HOME",
    "C_Timer",
    "GameFontNormalLarge",
    "UnitAffectingCombat",
    "GetSpecialization",
    "GetSpecializationRole",
    "CombatLogGetCurrentEventInfo",
}

max_line_length = false
