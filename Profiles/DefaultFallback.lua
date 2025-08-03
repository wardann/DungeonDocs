---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

DD.profiles.StoreReservedProfile("DefaultFallback!*", {
	--     #                        #    #                              #####                                    #######
	--    # #   #####    ##         #   #    ##   #####    ##          #     # # ##### #   #     ####  ######    #        ####  #    #  ####  ######  ####
	--   #   #  #    #  #  #        #  #    #  #  #    #  #  #         #       #   #    # #     #    # #         #       #    # #    # #    # #      #
	--  #     # #    # #    # ##### ###    #    # #    # #    #        #       #   #     #      #    # #####     #####   #      ###### #    # #####   ####
	--  ####### #####  ######       #  #   ###### #####  ###### ###    #       #   #     #      #    # #         #       #      #    # #    # #           #
	--  #     # #   #  #    #       #   #  #    # #   #  #    # ###    #     # #   #     #      #    # #         #       #    # #    # #    # #      #    #
	--  #     # #    # #    #       #    # #    # #    # #    #  #      #####  #   #     #       ####  #         #######  ####  #    #  ####  ######  ####
	--                                                          #
	["Ara-Kara, City of Echoes"] = {
		{
			ddid = "ak1",
			primaryNote = "Kill adds before he eats them and wipes the group",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Avanoxx",
		},
		{
			ddid = "ak2",
			primaryNote = "(1) Avoid swirlies throughout the fight\n(2) At 100 energy, boss summons a swarm. Stay inside the eye of the swarm to survive",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Anubzekt",
		},
		{
			ddid = "ak3",
			primaryNote = "(1) Create 5-7 blue puddles by striking the slime mobs\n(2) Standing in blue puddles roots you in place\n(3) When the boss casts the pull, STAND IN A PUDDLE to get rooted\n(4) After the pull, KILL ALL ROOTS with EITHER damage or CC\n(5) Avoid swirlies",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Kikatal The Harvester",
		},
	},
	--   #####                                                               #     #
	--  #     # # #    # #####  ###### #####  #####  #####  ###### #    #    ##   ## ######   ##   #####  ###### #####  #   #
	--  #       # ##   # #    # #      #    # #    # #    # #      #    #    # # # # #       #  #  #    # #      #    #  # #
	--  #       # # #  # #    # #####  #    # #####  #    # #####  #    #    #  #  # #####  #    # #    # #####  #    #   #
	--  #       # #  # # #    # #      #####  #    # #####  #      # ## #    #     # #      ###### #    # #      #####    #
	--  #     # # #   ## #    # #      #   #  #    # #   #  #      ##  ##    #     # #      #    # #    # #      #   #    #
	--   #####  # #    # #####  ###### #    # #####  #    # ###### #    #    #     # ###### #    # #####  ###### #    #   #
	--
	["Cinderbrew Meadery"] = {
		{
			ddid = "cbm1",
			primaryNote = "1. Before intermission: avoid hazards\n2. During intermission: bring brews to red patrons\n3. After intermission: avoid more hazards",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Brewmaster Aldryr",
		},
		{
			ddid = "cbm2",
			primaryNote = "Kill bee adds, then click on them and ram them into the barrels",
			tankNote = "Drop puddles at the edge of the room",
			healerNote = "",
			damageNote = "",
			docName = "Benk Buzzbee",
		},
		{
			ddid = "cbm3",
			primaryNote = "- CC and nuke adds ASAP\n- Do NOT let adds touch the boss",
			tankNote = "- Kite when possible",
			healerNote = "",
			damageNote = "",
			docName = "I'pa",
		},
		{
			ddid = "cbm4",
			primaryNote = "- Destroy the big barrels with the red circle attack\n- Don't destroy too many barrels at once",
			tankNote = "- The frontal can also be used to destroy barrels",
			healerNote = "",
			damageNote = "",
			docName = "Goldie Baronbottom",
		},
	},
	--   #####                                    #######
	--  #     # # ##### #   #     ####  ######       #    #    # #####  ######   ##   #####   ####
	--  #       #   #    # #     #    # #            #    #    # #    # #       #  #  #    # #
	--  #       #   #     #      #    # #####        #    ###### #    # #####  #    # #    #  ####
	--  #       #   #     #      #    # #            #    #    # #####  #      ###### #    #      #
	--  #     # #   #     #      #    # #            #    #    # #   #  #      #    # #    # #    #
	--   #####  #   #     #       ####  #            #    #    # #    # ###### #    # #####   ####
	--
	["City of Threads"] = {
		{
			ddid = "cot1",
			primaryNote = "(1) STAY IN THE CIRCLE!\n(2) At 100 energy, he drops a death puddle. Stack on tank and move out together.",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Orator Krixvizk",
		},
		{
			ddid = "cot2",
			primaryNote = "(1) Run out of purple circles or die\n(2) Avoid anything that looks like a line or die\n(3) In Phase 2 do not stand with anyone if you have the purple circle or they die\n(4) In Phase 2 stand with Tank when they get the big white circle or they die",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Fangs of the Queen",
		},
		{
			ddid = "cot3",
			primaryNote = "When boss slams the ground and knocks you back, run around and absorb 2-3 black orbs",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "The Coaglamation",
		},
		{
			ddid = "cot4",
			primaryNote = "Avoid the orbs on the ground. They telegraph where they will go",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Izo, The Grand Splicer",
		},
	},
	--  ######                                                              #####
	--  #     #   ##   #####  #    # ###### #        ##   #    # ######    #     # #      ###### ###### #####
	--  #     #  #  #  #    # #   #  #      #       #  #  ##  ## #         #       #      #      #        #
	--  #     # #    # #    # ####   #####  #      #    # # ## # #####     #       #      #####  #####    #
	--  #     # ###### #####  #  #   #      #      ###### #    # #         #       #      #      #        #
	--  #     # #    # #   #  #   #  #      #      #    # #    # #         #     # #      #      #        #
	--  ######  #    # #    # #    # #      ###### #    # #    # ######     #####  ###### ###### #        #
	--
	["Darkflame Cleft"] = {
		{
			ddid = "dfc1",
			primaryNote = "1. Destroy dynamite cart ASAP\n2. Don't get caught by mobs if fixated. Run, CC, or bait them into carts\n3. Avoid charge",
			tankNote = "- Mitigate [Rock Buster]",
			healerNote = "",
			damageNote = "",
			docName = "Ol' Waxbeard",
		},
		{
			ddid = "dfc2",
			primaryNote = "- Light candles by moving red circle barrage on them\n- Make sure one candle is lit during [Inferno]\n- Extinguish candles by baiting gust attack towards them\n- Make sure one candle is unlit during [Incite Flames]",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Blazikon",
		},
		{
			ddid = "dfc3",
			primaryNote = "1. Destroy statues with the purple circle attack or by baiting the pickaxe when targeted\n2. Interrupt [Paranoid Mind]",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "The Candle King",
		},
		{
			ddid = "dfc4",
			primaryNote = "DO NOT let candle die!\n\n1. Move out of purple circle\n2. Move candle out of frontal\n3. Replenish candle\n4. Interrupt [Call Darkspawn]",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "The Darkness",
		},
	},
	--   #####                     ######
	--  #     # #####  # #    #    #     #   ##   #####  ####  #
	--  #       #    # # ##  ##    #     #  #  #    #   #    # #
	--  #  #### #    # # # ## #    ######  #    #   #   #    # #
	--  #     # #####  # #    #    #     # ######   #   #    # #
	--  #     # #   #  # #    #    #     # #    #   #   #    # #
	--   #####  #    # # #    #    ######  #    #   #    ####  ######
	--
	["Grim Batol"] = {
		{
			ddid = "gb1",
			primaryNote = "(1) Avoid orange circles on ground.\n(2) When room turns purple, look for safe lane",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "General Umbriss",
		},
		{
			ddid = "gb2",
			primaryNote = "(1) When boss changes weapon, he does lots of aoe damage\n(2) Phase 1 is Axe, drop conals next to each other\n(3) Phase 2 is dual wield, tank buster, big heals on tank\n(4) Phase 3 is 2h mace - kite phase\n(5) Rinse & Repeat",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Forgemaster Throngus",
		},
		{
			ddid = "gb3",
			primaryNote = "(1) Phase 1 kill adds\n(2) Phase 2 kill adds and avoid stuff (this can get crazy, help your healer, avoid stuff)\n(3) Boss done at 50%",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Drahga Shadowburner",
		},
		{
			ddid = "gb4",
			primaryNote = "(1) Avoid Tenticles\n(2) Compress when room starts closing in, but still stay as spread out as possible",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Erudax",
		},
	},
	--  #     #                                           #######                            #####
	--  ##   ## #  ####  #####  ####      ####  ######       #    # #####  #    #   ##      #     #  ####  # ##### #    # ######
	--  # # # # # #        #   #         #    # #            #    # #    # ##   #  #  #     #       #    # #   #   #    # #
	--  #  #  # #  ####    #    ####     #    # #####        #    # #    # # #  # #    #     #####  #      #   #   ###### #####
	--  #     # #      #   #        #    #    # #            #    # #####  #  # # ######          # #      #   #   #    # #
	--  #     # # #    #   #   #    #    #    # #            #    # #   #  #   ## #    #    #     # #    # #   #   #    # #
	--  #     # #  ####    #    ####      ####  #            #    # #    # #    # #    #     #####   ####  #   #   #    # ######
	--
	["Mists of Tirna Scithe"] = {
		{
			ddid = "mots1",
			primaryNote = "(1) Save DPS cooldowns for when boss is stunned\n(2) Avoid swirlies",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Ingra Maloch",
		},
		{
			ddid = "mots2",
			primaryNote = "(1) Avoid BALLS OF DEATH\n(2) Avoid FOX OF DEATH\n(3) When boss creates 4 clones, kill the odd one out",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Mistcaller",
		},
		{
			ddid = "mots3",
			primaryNote = "(1) Avoid swirlies\n(2) The tank & the rest of party should stay on opposite sides of the boss. This makes breaking the tether easier\n(3) Kill adds\n(4) At 70% & 40% the boss shields. DPS shield down quickly and interrupt",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Tred'ova",
		},
	},
	--  #######                                                    #     #######
	--  #     # #####  ###### #####    ##   ##### #  ####  #    # ###    #       #       ####   ####  #####   ####    ##   ##### ######
	--  #     # #    # #      #    #  #  #    #   # #    # ##   #  #     #       #      #    # #    # #    # #    #  #  #    #   #
	--  #     # #    # #####  #    # #    #   #   # #    # # #  #        #####   #      #    # #    # #    # #      #    #   #   #####
	--  #     # #####  #      #####  ######   #   # #    # #  # #  #     #       #      #    # #    # #    # #  ### ######   #   #
	--  #     # #      #      #   #  #    #   #   # #    # #   ## ###    #       #      #    # #    # #    # #    # #    #   #   #
	--  ####### #      ###### #    # #    #   #   #  ####  #    #  #     #       ######  ####   ####  #####   ####  #    #   #   ######
	--
	["Operation: Floodgate"] = {
		{
			ddid = "of1",
			primaryNote = "1. Focus adds, interrupt them, avoid their charge\n2. When targeted, point [Sonic Boom] away from group",
			tankNote = "- Mitigate [Electrocrush]\n- Move boss after each intermission",
			healerNote = "",
			damageNote = "",
			docName = "Big M.O.M.M.A.",
		},
		{
			ddid = "of2",
			primaryNote = "1. When targeted by the charge, bait boss to run over bombs\n2. When circle spawns around you, go next to bombs",
			tankNote = "- Mitigate [Wallop]",
			healerNote = "- Dispel circle from players next to bombs to destroy them",
			damageNote = "",
			docName = "Demolition Duo",
		},
		{
			ddid = "of3",
			primaryNote = "Stay next to the player you're tethered to. Dodge the boss's attacks together",
			tankNote = "Mitigate [Sludge Claws]",
			healerNote = "",
			damageNote = "",
			docName = "Swampface",
		},
		{
			ddid = "of4",
			primaryNote = "1. Do NOT step in water puddles with the [Gigazap] DoT\n2. Bait the sparks that focus you into the water puddles",
			tankNote = "- Do NOT get knocked out of the arena by [Thunder Punch]",
			healerNote = "",
			damageNote = "",
			docName = "Geezle Gigazap",
		},
	},
	--  #######                                                    #     #     #
	--  #     # #####  ###### #####    ##   ##### #  ####  #    # ###    ##   ## ######  ####  #    #   ##    ####   ####  #    #
	--  #     # #    # #      #    #  #  #    #   # #    # ##   #  #     # # # # #      #    # #    #  #  #  #    # #    # ##   #
	--  #     # #    # #####  #    # #    #   #   # #    # # #  #        #  #  # #####  #      ###### #    # #      #    # # #  #
	--  #     # #####  #      #####  ######   #   # #    # #  # #  #     #     # #      #      #    # ###### #  ### #    # #  # #
	--  #     # #      #      #   #  #    #   #   # #    # #   ## ###    #     # #      #    # #    # #    # #    # #    # #   ##
	--  ####### #      ###### #    # #    #   #   #  ####  #    #  #     #     # ######  ####  #    # #    #  ####   ####  #    #
	--
	["Operation: Mechagon"] = {
		{
			ddid = "mw1",
			primaryNote = "- Don't get tossed into bombs\n- Avoid saw blades\n- Avoid red areas on ground",
			tankNote = "- Remove plating using hammers\n- Mitigate [Pummel]",
			healerNote = "",
			damageNote = "",
			docName = "Tussle Tonks",
		},
		{
			ddid = "mw2",
			primaryNote = "- Hide behind boxes when boss casts [Venting Flames]\n- Stay AWAY from boxes when targeted by leap",
			tankNote = "- Mitigate [Blazing Chomp]",
			healerNote = "- Dispelling chomp debuff does party damage. Be careful!",
			damageNote = "",
			docName = "K.U.-J.0.",
		},
		{
			ddid = "mw3",
			primaryNote = "- Stun & kill plants ASAP\n- AVOID fire, gears, lasers",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Head Machinist Sparkflux",
		},
		{
			ddid = "mw4",
			primaryNote = "PHASE 1:\n\n- Avoid Plasma Orbs\n\n\nPHASE 2:\n\n- Move as little as possible if targeted by [Mega Zap], everyone else step out of cone\n- When magnet pulls, avoid plasma orbs & use defensives",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "King Mechagon",
		},
	},
	--  ######                                                                           #####                                        #######
	--  #     # #####  #  ####  #####  #   #     ####  ######    ##### #    # ######    #     #   ##    ####  #####  ###### #####     #       #        ##   #    # ######
	--  #     # #    # # #    # #    #  # #     #    # #           #   #    # #         #        #  #  #    # #    # #      #    #    #       #       #  #  ##  ## #
	--  ######  #    # # #    # #    #   #      #    # #####       #   ###### #####      #####  #    # #      #    # #####  #    #    #####   #      #    # # ## # #####
	--  #       #####  # #    # #####    #      #    # #           #   #    # #               # ###### #      #####  #      #    #    #       #      ###### #    # #
	--  #       #   #  # #    # #   #    #      #    # #           #   #    # #         #     # #    # #    # #   #  #      #    #    #       #      #    # #    # #
	--  #       #    # #  ####  #    #   #       ####  #           #   #    # ######     #####  #    #  ####  #    # ###### #####     #       ###### #    # #    # ######
	--
	["Priory of the Sacred Flame"] = {
		{
			ddid = "potsf1",
			primaryNote = "- Always interrupt [Battle Cry]\n- Break [Savage Mauling] absorb shield ASAP\n- Avoid spear\n- Interrupt Duelmal (if paired with him)",
			tankNote = "- Mitigate [Pierce Armor]\n- Mitigate Emberlanz's attacks (if paired with her)",
			healerNote = "",
			damageNote = "",
			docName = "Captain Dailcry",
		},
		{
			ddid = "potsf2",
			primaryNote = "1. Avoid hazards\n2. Help tank soak if needed",
			tankNote = "- The 3 Sacrificial Pyre orbs need to be soaked\n- During [Vindictive Wrath], there will be 5 orbs and you may need help",
			healerNote = "",
			damageNote = "",
			docName = "Baron Braunpyke",
		},
		{
			ddid = "potsf3",
			primaryNote = "PHASE 1:\n\n1. Look away when boss casts [Blinding Light]\n2. Bait beam to edges of room if targeted\n3. Interrupt [Holy Smite]\n\n\nPHASE 2:\n\n1. Chase boss upstairs, CC & nuke adds that spawn ASAP\n2. Once shield is broken, Phase 1 mechanics start again",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Prioress Murrpray",
		},
	},
	--   #####                                             ######
	--  #     # # ######  ####  ######     ####  ######    #     #  ####  #####    ##   #      #    #  ####
	--  #       # #      #    # #         #    # #         #     # #    # #    #  #  #  #      #    # #
	--   #####  # #####  #      #####     #    # #####     ######  #    # #    # #    # #      #    #  ####
	--        # # #      #  ### #         #    # #         #     # #    # #####  ###### #      #    #      #
	--  #     # # #      #    # #         #    # #         #     # #    # #   #  #    # #      #    # #    #
	--   #####  # ######  ####  ######     ####  #         ######   ####  #    # #    # ######  ####   ####
	--
	["Siege of Boralus"] = {
		{
			ddid = "sob1",
			primaryNote = "(1) Kite boss into bombs (save big DPS CDs until boss is stunned, he takes more damage)\n(2) Avoid bombs\n(3) Run away when he sucks you in\n(4) Avoid swirlies\n(5) Cleave adds",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Chopper Redhook",
		},
		{
			ddid = "sob2",
			primaryNote = "(1) Avoid stuff on ground\n(2) Kill adds in intermission phase",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Dread Captain Lockwood",
		},
		{
			ddid = "sob3",
			primaryNote = "(1) Avoid swirlies\n(2) When [TIDAL SURGE] is cast, stand on the opposite side of the statue\n(3) Follow Tank",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Hadal Darkfathom",
		},
		{
			ddid = "sob4",
			primaryNote = "(1) Kill Demolishing Terror before Gripping Terror\n(2) Avoid Swirlies\n(3) When tenticles are killed on a platform, hop into cannon and shoot boss\n(4) Repeat on second platform\n(5) Repeat on boat platform",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Viqgoth",
		},
	},
	--  #######                  ######
	--     #    #    # ######    #     #   ##   #    # #    # #####  #####  ######   ##   #    # ###### #####
	--     #    #    # #         #     #  #  #  #    # ##   # #    # #    # #       #  #  #   #  #      #    #
	--     #    ###### #####     #     # #    # #    # # #  # #####  #    # #####  #    # ####   #####  #    #
	--     #    #    # #         #     # ###### # ## # #  # # #    # #####  #      ###### #  #   #      #####
	--     #    #    # #         #     # #    # ##  ## #   ## #    # #   #  #      #    # #   #  #      #   #
	--     #    #    # ######    ######  #    # #    # #    # #####  #    # ###### #    # #    # ###### #    #
	--
	["The Dawnbreaker"] = {
		{
			ddid = "tdb1",
			primaryNote = "(1) Avoid the rotating purple beams of death\n(2) Fly away at 50% and 0% HP, when boss does instant kill spell",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Speaker Shadowcrown",
		},
		{
			ddid = "tdb2",
			primaryNote = "(1) Run out of purple circle\n(2) Don't get hit by giant purple ball\n(3) Ball does big AoE damage if it collides with an object(4)\nIf targeted by ball, send up or down the hill",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Anubikkaj",
		},
		{
			ddid = "tdb3",
			primaryNote = "(1) In the first phase, only the barrels matter, not DPS. Use barrels ASAP.\n(2) You can fly straight to second platform but first grab a gold orb\n(3) In the second phase, take the webs to the edge of the platform\n(4) Boss down at 60%",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Rashanan",
		},
	},
	--  #######                  #     # ####### ####### #     # ####### ######  #       ####### ######  ####### ### ###
	--     #    #    # ######    ##   ## #     #    #    #     # #       #     # #       #     # #     # #       ### ###
	--     #    #    # #         # # # # #     #    #    #     # #       #     # #       #     # #     # #       ### ###
	--     #    ###### #####     #  #  # #     #    #    ####### #####   ######  #       #     # #     # #####    #   #
	--     #    #    # #         #     # #     #    #    #     # #       #   #   #       #     # #     # #
	--     #    #    # #         #     # #     #    #    #     # #       #    #  #       #     # #     # #       ### ###
	--     #    #    # ######    #     # #######    #    #     # ####### #     # ####### ####### ######  ####### ### ###
	--
	["The MOTHERLODE!!"] = {
		{
			ddid = "tm1",
			primaryNote = "- Kick balls into boss\n- Avoid slam",
			tankNote = "- Move boss away from coins on ground",
			healerNote = "",
			damageNote = "",
			docName = "Coin-Operated Crowd Pummeler",
		},
		{
			ddid = "tm2",
			primaryNote = "1. Kite & CC adds\n2. Kill infused add ASAP\n3. Stay out of quake and smash",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Azerokk",
		},
		{
			ddid = "tm3",
			primaryNote = "- Drop puddles next to each other to save space\n- Aim boss's [Propellant Blast] towards puddles to clear them",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Rixxa Fluxflame",
		},
		{
			ddid = "tm4",
			primaryNote = "PHASE 1:\n\n- Stay close to boss\n- Move out when targeted by missile\n- Don't get gunned down\n\n\nPHASE 2:\n\n- Nuke adds\n- If marked by [Drill Smash], move next to a pillar. Move out when red circle appears",
			tankNote = "- Watch mobs on the edges to figure out safe quadrant. Move boss there",
			healerNote = "",
			damageNote = "",
			docName = "Mogul Razdunk",
		},
	},
	--  #######                  #     #                                               #     #
	--     #    #    # ######    ##    # ######  ####  #####   ####  ##### #  ####     #  #  #   ##   #    # ######
	--     #    #    # #         # #   # #      #    # #    # #    #   #   # #    #    #  #  #  #  #  #   #  #
	--     #    ###### #####     #  #  # #####  #      #    # #    #   #   # #         #  #  # #    # ####   #####
	--     #    #    # #         #   # # #      #      #####  #    #   #   # #         #  #  # ###### #  #   #
	--     #    #    # #         #    ## #      #    # #   #  #    #   #   # #    #    #  #  # #    # #   #  #
	--     #    #    # ######    #     # ######  ####  #    #  ####    #   #  ####      ## ##  #    # #    # ######
	--
	["The Necrotic Wake"] = {
		{
			ddid = "tnw1",
			primaryNote = "(1) Aim belch away from group if targeted\n(2) Kill adds ASAP (stun and CC if needed)",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Blightbone",
		},
		{
			ddid = "tnw2",
			primaryNote = "(1) Always interrupt the boss\n(2) Kill the adds ASAP starting with the mage\n(3) Avoid beam of death & decay",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Amarth, The Harvester",
		},
		{
			ddid = "tnw3",
			primaryNote = "(1) Aim the meat hook (arrow) at the boss to pull him down\n(2) Save CDs for when boss is pulled down\n(3) Hit boss with meat hook arrow even after pulled down",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Surgeon Stitchflesh",
		},
		{
			ddid = "tnw4",
			primaryNote = "(1) Avoid swirlies\n(2) Ranged players spread out\n(3) When someone gets frozen, move out of their circle ASAP. Do NOT dispel the frozen buff until circle is empty\n(4) Avoid crossing each other's paths during the comet storm\n(5) If sent away, go through gauntlet & kill the mob at the end",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Nalthor the Rimebinder",
		},
	},
	--  #######                  ######
	--     #    #    # ######    #     #  ####   ####  #    # ###### #####  #   #
	--     #    #    # #         #     # #    # #    # #   #  #      #    #  # #
	--     #    ###### #####     ######  #    # #    # ####   #####  #    #   #
	--     #    #    # #         #   #   #    # #    # #  #   #      #####    #
	--     #    #    # #         #    #  #    # #    # #   #  #      #   #    #
	--     #    #    # ######    #     #  ####   ####  #    # ###### #    #   #
	--
	["The Rookery"] = {
		{
			ddid = "tr1",
			primaryNote = "- Don't overlap circles\n- Electricity = ouch",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Kyrioss",
		},
		{
			ddid = "tr2",
			primaryNote = "1. Don't pass the DoT to someone with the debuff (unless you know they can mitigate the damage)\n2. Avoid the crush & void tornadoes\n3. Run when boss uses gravity pull",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Stormguard Gorren",
		},
		{
			ddid = "tr3",
			primaryNote = "1. Stay spread out around the boss\n2. After big smash, avoid puddles and move with blue circle on top of crystals",
			tankNote = "- Point wave attack away from group",
			healerNote = "- Dispel DoTs, but be careful with positioning as dispelling creates puddles",
			damageNote = "",
			docName = "Voidstone Monstrosity",
		},
	},
	--  #######                   #####
	--     #    #    # ######    #     # #####  ####  #    # ###### #    #   ##   #    # #      #####
	--     #    #    # #         #         #   #    # ##   # #      #    #  #  #  #    # #        #
	--     #    ###### #####      #####    #   #    # # #  # #####  #    # #    # #    # #        #
	--     #    #    # #               #   #   #    # #  # # #      #    # ###### #    # #        #
	--     #    #    # #         #     #   #   #    # #   ## #       #  #  #    # #    # #        #
	--     #    #    # ######     #####    #    ####  #    # ######   ##   #    #  ####  ######   #
	--
	["The Stonevault"] = {
		{
			ddid = "tsv1",
			primaryNote = "(1) Using the boss's arrow attack, clear a few of the spikes on the ground\n(2) Do NOT break all spikes at the same time\n(3) Do NOT stack",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "E.D.N.A",
		},
		{
			ddid = "tsv2",
			primaryNote = "(1) When the shards spawn, destory only ONE at a time\n(2) When the orbs spawn, only pick up 1-3 at a time",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Skarmorak",
		},
		{
			ddid = "tsv3",
			primaryNote = "(1) Focus the small boss first & always interrupt\n(2) Focus big boss when small boss runs (keep interrupting small boss)\n(3) Do not stand on exhaust vents\n(4) Avoid DEATH CUBE\n(5) Kill both at the same time!",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Master Machinists",
		},
		{
			ddid = "tsv4",
			primaryNote = "(1) Drop blue circles at the edge of the room\n(2) Clear your corruption by standing near a portal, but NOT on top of it\n(3) Avoid DEATH CONE",
			tankNote = "",
			healerNote = "",
			damageNote = "",
			docName = "Void Speaker Eirich",
		},
	},
	--  #######                                                              ######
	--     #    #    # ######   ##   ##### ###### #####      ####  ######    #     #   ##   # #    #
	--     #    #    # #       #  #    #   #      #    #    #    # #         #     #  #  #  # ##   #
	--     #    ###### #####  #    #   #   #####  #    #    #    # #####     ######  #    # # # #  #
	--     #    #    # #      ######   #   #      #####     #    # #         #       ###### # #  # #
	--     #    #    # #      #    #   #   #      #   #     #    # #         #       #    # # #   ##
	--     #    #    # ###### #    #   #   ###### #    #     ####  #         #       #    # # #    #
	--
	["Theater of Pain"] = {
		{
			ddid = "top1",
			primaryNote = "- Interrupt [Necrotic Bolts]\n- Avoid ground hazards",
			tankNote = "- Mitigate [Mortal Strike]",
			healerNote = "- Dispel DoTs\n- Save a cooldown for [Mighty Smash]",
			damageNote = "",
			docName = "Affront of Challengers",
		},
		{
			ddid = "top2",
			primaryNote = "1. NUKE banner to make moving out of green areas easier\n2. Don't actually duel",
			tankNote = "- Mitigate [Brutal Combo]",
			healerNote = "",
			damageNote = "",
			docName = "Xav the Unfallen",
		},
		{
			ddid = "top3",
			primaryNote = "1. Stay next to boss until the circle appears and THEN move\n2. Move through the gaps to avoid the meat hooks wall",
			tankNote = "- Mitigate [Hateful Strike]",
			healerNote = "",
			damageNote = "",
			docName = "Gorechop",
		},
		{
			ddid = "top4",
			primaryNote = "1. Stack when the boss casts [Draw Soul]\n2. Nuke/CC adds ASAP\n3. Avoid green hazards\n4. Interrupt bolts",
			tankNote = "- Stay in boss's melee range",
			healerNote = "",
			damageNote = "",
			docName = "Kul'tharok",
		},
		{
			ddid = "top5",
			primaryNote = "- Phase 1: avoid beam & don't get sucked into [Grasping Rift]\n- Phase 2: same, but also avoid ghosts & charges",
			tankNote = "- Mitigate [Reaping Scythe]",
			healerNote = "",
			damageNote = "",
			docName = "Mordretha",
		},
	},
})
