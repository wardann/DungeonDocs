--- @class AceDB
--- @field profile DatabaseStructure # Active profile data
--- @field profiles table<string, DatabaseStructure> # All available profiles and their data
--- @field global table<string, any> # Global settings shared across profiles
--- @field factionrealm table<string, any> # Settings specific to faction and realm
--- @field realm table<string, any> # Settings specific to the realm
--- @field char table<string, any> # Settings specific to the character
--- @field class table<string, any> # Settings specific to the class
--- @field defaults table<string, any> # Default settings for profiles and other scopes
--- @field RegisterCallback fun(self: AceDB, obj: any, event: string, method: string|function) # Registers a callback for database events
--- @field UnregisterCallback fun(self: AceDB, obj: any, event: string) # Unregisters a callback for a specific event
--- @field ResetProfile fun(self: AceDB, silent?: boolean) # Resets the active profile to its defaults
--- @field SetProfile fun(self: AceDB, profileName: string) # Switches to a different profile
--- @field GetProfiles fun(self: AceDB, tbl?: table): string[], number # Returns a table of profile names and the count
--- @field GetCurrentProfile fun(self: AceDB): string # Returns the current profile name
--- @field DeleteProfile fun(self: AceDB, name: string, silent?: boolean) # Deletes a specified profile
--- @field CopyProfile fun(self: AceDB, name: string, silent?: boolean) # Copies a specified profile into the current profile
--- @field ResetDB fun(self: AceDB, defaultProfile?: string|boolean) # Resets the entire database, optionally specifying a new default profile
--- @field RegisterNamespace fun(self: AceDB, name: string, defaults?: table): AceDB # Registers a new namespace within the database
--- @field GetNamespace fun(self: AceDB, name: string, silent?: boolean): AceDB|nil # Retrieves an existing namespace
--- @field New fun(self: AceDB, tbl: string|table, defaults?: table, defaultProfile?: string|boolean): AceDB # Creates a new database object
--- @field RegisterDefaults fun(self: AceDB, defaults: table) # Sets or clears the defaults for the database
