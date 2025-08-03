const fs = require('fs');
const figlet = require('figlet');

// Usage: node index.js <profileName>
const profileName = process.argv[2];
if (!profileName) {
    console.error('Error: profile name required as first argument.');
    process.exit(1);
}

// Read stdin synchronously
const input = fs.readFileSync(0, 'utf-8');
let data;
try {
    data = JSON.parse(input);
} catch (e) {
    console.error('Failed to parse JSON from stdin:', e);
    process.exit(1);
}

// Group notes by dungeonName
const notesByDungeon = {};
data.forEach(entry => {
    if (!notesByDungeon[entry.dungeonName]) notesByDungeon[entry.dungeonName] = [];
    notesByDungeon[entry.dungeonName].push(entry);
});

// Sort dungeons alphabetically
const sortedDungeonNames = Object.keys(notesByDungeon).sort();

// Sort notes within each dungeon by ddid
sortedDungeonNames.forEach(dungeonName => {
    notesByDungeon[dungeonName].sort((a, b) => a.ddid.localeCompare(b.ddid));
});

function luaEscape(str) {
    return str.replace(/\\/g, "\\\\").replace(/\"/g, '\\"').replace(/\n/g, '\\n');
}

function luaNote(note) {
    return `        {
            ddid = "${luaEscape(note.ddid)}",
            primaryNote = "${luaEscape(note.primaryNote)}",
            tankNote = "${luaEscape(note.tankNote)}",
            healerNote = "${luaEscape(note.healerNote)}",
            damageNote = "${luaEscape(note.damageNote)}",
            docName = "${luaEscape(note.docName)}"
        }`;
}

const luaTableEntries = sortedDungeonNames.map(dungeonName => {
    const banner = figlet.textSync(dungeonName, { font: 'Banner' }).split('\n').map(line => `-- ${line}`).join('\n');
    const notes = notesByDungeon[dungeonName].map(luaNote).join(',\n');
    return `${banner}\n    ["${luaEscape(dungeonName)}"] = {\n${notes}\n    }`;
}).join(',\n');

const luaTable = `{
${luaTableEntries}
}`;

const luaOutput = `---@type DungeonDocs
local DD = LibStub("AceAddon-3.0"):GetAddon("DungeonDocs")

DD.profiles.StoreReservedProfile("${luaEscape(profileName)}", ${luaTable})`;

console.log(luaOutput);