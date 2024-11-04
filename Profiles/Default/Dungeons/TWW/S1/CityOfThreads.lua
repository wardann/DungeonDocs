local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

local dungeonBosses = {
    {
        bossName = "Orator Krixvizk",
        encounterId = 2594,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
        mobs = {
            {
                name = "Orator Krixvizk",
                id = 216619,
                displayId = 116692,
            }
        },
    },
    {
        bossName = "Nx & Vx",
        encounterId = 2595,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
        mobs = {
            {
                name = "Nx",
                id = 216648,
                displayId = 116699,
            },
            {
                name = "Vx",
                id = 216649,
                displayId = 116700,
            },
        },
    },
    {
        bossName = "Izo The Grand Splicer",
        encounterId = 2596,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
        mobs = {
            {
                name = "Izo The Grand Splicer",
                id = 216658,
                displayId = 116701,
            }
        },
    },
    {
        bossName = "The Coaglamation",
        encounterId = 2600,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
        mobs = {
            {
                name = "The Coaglamation",
                id = 216320,
                displayId = 11725,
            }
        },
    },
}

local dungeonTrash = {
    {
        name = "Starved Crawler",
        id = 216336,
        displayId = 120876,
    },
    {
        name = "Sureki Silkbinder",
        id = 220195,
        displayId = 120872,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Sureki Venomblade",
        id = 220193,
        displayId = 120868,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Royal Swarmguard",
        id = 220197,
        displayId = 120882,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Herald Of Ansurek",
        id = 220196,
        displayId = 120905,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Xephitik",
        id = 219984,
        displayId = 119732,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Eye Of The Queen",
        id = 219983,
        displayId = 119371,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Web Marauder",
        id = 223182,
        displayId = 119369,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Agile Pursuer",
        id = 223181,
        displayId = 119370,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Congealed Droplet",
        id = 216329,
        displayId = 114555,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Battle Scarab",
        id = 220199,
        displayId = 120589,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Covert Webmancer",
        id = 223844,
        displayId = 118106,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Sureki Conscript",
        id = 223357,
        displayId = 120886,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Royal Venomshell",
        id = 220730,
        displayId = 120890,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Skittering Assistant",
        id = 216342,
        displayId = 120891,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Unstable Test Subject",
        id = 216328,
        displayId = 116499,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Sureki Unnaturaler",
        id = 216339,
        displayId = 120894,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Elder Shadeweaver",
        id = 221102,
        displayId = 118827,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Hulking Warshell",
        id = 221103,
        displayId = 118826,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Ravenous Scarab",
        id = 219198,
        displayId = 116480,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Web Marauder",
        id = 224731,
        displayId = 119369,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Covert Webmancer",
        id = 224732,
        displayId = 118106,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Agile Pursuer",
        id = 228361,
        displayId = 119370,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
    {
        name = "Retired Lord Vul'azak",
        id = 220423,
        displayId = 120885,
        primaryNote = "",
        healerNote = "",
        damageNote = "",
        tankNote = "",
    },
}

local dungeonData = {
    name = "City of Threads",
    bosses = dungeonBosses,
    trash = dungeonTrash,
}

DD:ProfilesDefault_InitDocs(dungeonData)