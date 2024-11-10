stds = {
   wow = {
      globals = {
         "UnitName", "GetSpellInfo", "CreateFrame", -- Add other WoW globals here
      },
   },
}

std = "wow"  -- Use the custom 'wow' standard defined above

-- Disable all warnings until we can get the globals sorted
only = {"E"}  -- Only show errors, ignoring warnings
