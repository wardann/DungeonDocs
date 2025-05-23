---@global CreateFrame fun(frameType: string, frameName: string|nil, parent: Frame|nil, template: string|nil): Frame

---@type Frame
UIParent = UIParent

---@class C_AddOns
---@field LoadAddOn fun(addonName: string): boolean|nil, string|nil Loads the specified add-on and returns whether it was successfully loaded, along with an error message if applicable.
---@field IsAddOnLoaded fun(addonName: string): boolean Checks if the specified add-on is loaded.
---@field GetAddOnInfo fun(addonIndex: number): string, string, string, boolean, boolean, boolean, string, string Retrieves information about an add-on by its index. Returns name, title, notes, enabled state, loadable state, reason, security, and new version details.
---@field GetAddOnMetadata fun(addonName: string, field: string): string|nil Retrieves metadata from an add-on's `.toc` file based on the provided field name.
---@field GetNumAddOns fun(): number Returns the total number of add-ons available.
---@type C_AddOns
C_AddOns = C_AddOns

---@type fun(): string, string, number, string, string, number, number, number Returns instance information.
--- Returns values such as instance name, instance type, difficulty ID, and more.
GetInstanceInfo = GetInstanceInfo

---@type fun(unit: string): string|nil Gets the name of a unit.
--- Takes a unit identifier (e.g., "target").
UnitName = UnitName

---@type fun(category: number): boolean Checks if the player is in a group of the specified category.
--- Accepts LE_PARTY_CATEGORY_INSTANCE or LE_PARTY_CATEGORY_HOME.
IsInGroup = IsInGroup

---@type fun(message: string, chatType: string, language?: string, target?: string): nil Sends a chat message.
--- Sends a message to a specified chat channel or player.
SendChatMessage = SendChatMessage

---@type number Represents the instance party category.
LE_PARTY_CATEGORY_INSTANCE = LE_PARTY_CATEGORY_INSTANCE

---@type number Represents the home party category.
LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME

---@class C_Timer
---@field After fun(duration: number, callback: fun()): nil Schedules a one-time callback after the given duration (in seconds).
---@field NewTimer fun(duration: number, callback: fun()): TimerObject Creates a timer that fires once after the given duration.
---@field NewTicker fun(interval: number, callback: fun(), iterations?: number): TimerObject Creates a repeating timer with the given interval.

---@class TimerObject
---@field Cancel fun(self: TimerObject): nil Cancels the timer.
---@field IsCancelled fun(self: TimerObject): boolean Checks if the timer has been canceled.
---@type C_Timer
C_Timer = C_Timer

---@type Font
GameFontNormalLarge = GameFontNormalLarge

---@type fun(unit: string): boolean # Returns true if the specified unit is in combat, false otherwise
UnitAffectingCombat = UnitAffectingCombat

---@type fun(): number|nil # Returns the current specialization index (1-based), or nil if not available
GetSpecialization = GetSpecialization

---@type fun(specIndex: number): string # Returns the role associated with the given specialization index ("DAMAGER", "HEALER", or "TANK")
GetSpecializationRole = GetSpecializationRole

--- Returns details about the latest combat log event.
---@return number timestamp           -- The time the event occurred.
---@return string subevent            -- The event type (e.g. "SPELL_CAST_SUCCESS", "SWING_DAMAGE", etc.).
---@return boolean hideCaster         -- Whether to hide the caster.
---@return string sourceGUID          -- GUID of the source unit.
---@return string sourceName          -- Name of the source unit.
---@return number sourceFlags         -- Bitfield flags for the source unit (e.g. type, reaction).
---@return number sourceRaidFlags     -- Additional raid flags for the source unit.
---@return string destGUID            -- GUID of the destination unit.
---@return string destName            -- Name of the destination unit.
---@return number destFlags           -- Bitfield flags for the destination unit.
---@return number destRaidFlags       -- Additional raid flags for the destination unit.
---@return number|nil spellId         -- Spell ID (if applicable).
---@return string|nil spellName       -- Spell name (if applicable).
---@return number|nil spellSchool     -- Spell school as a bitmask (if applicable).
---@return any ...                    -- Additional event-specific parameters.
function CombatLogGetCurrentEventInfo()
	-- Stub return values to satisfy type checking.
	return 0, "", false, "", "", 0, 0, "", "", 0, 0, nil, nil, nil
end
-- Assign the global so that tools recognize the type.
CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo

---@type any
_ = _

---@type fun(delimiter: string, str: string): string, ... # Splits a string into components based on a delimiter.
strsplit = strsplit

---@type fun(unit: string): string|nil # Retrieves the globally unique identifier (GUID) for the specified unit.
UnitGUID = UnitGUID

---@type fun(): number
GetTime = GetTime

---@type fun()
ReloadUI = ReloadUI

---@type fun(): boolean, string
IsInInstance = IsInInstance

---@class bit
---@field band fun(a: number, b: number): number
---@type bit
bit = bit

---@type number
COMBATLOG_OBJECT_REACTION_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE
