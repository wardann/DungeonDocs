<p align="center">
  <img src="Assets/DungeonDocs.svg" alt="DungeonDocs Logo" width="200"/>
</p>
<h1 align="center">DungeonDocs</h1>

<p align="center">A WoW addon to display notes during combat to help you conquer M+</p>

## Overview

DungeonDocs is a World of Warcraft addon that displays notes during combat in Mythic+. Notes are enemy-specific and will be displayed for each enemy detected during combat.  

Basic boss notes have been included for TWW Season 1 of M+, but you can easily add your own.


## Features

- Display general and role-specific notes for each mob in an M+ dungeon
- Postition and style the notes on your screen
- Profile support allows for importing & exporting notes for easy sharing
- Fallback profiles make it possible to inherit notes from another profile
- Report notes in party chat with a slash command

## Demo

[Here is a quick demo that shows some of the features of DungeonDocs.](https://www.youtube.com/watch?v=lzqX2w3UBVY)

## Usage

### Commands
- DungeonDocs can be invoked with either `/dd` or `/dungeondocs`
- `/dd report` reports the primary notes for the current target to the instance, party, or say channel

### UI

Use the `Docs` tab to edit notes, the `Settings` tab to change the note appearance, and the `Profile` tab to manage profiles.

### Profiles

An `Active Profile` and `Fallback Profile` can be selected.

Notes in the `Active Profile` will be used first and, if none are found, the `Fallback Profile` will be used.

This allows for a player to import a profile as a base and overlay their own note changes on top (i.e. by setting the imported profile as the fallback).

**Settings and visual changes are sourced from the `Active Profile` only.**


## Tips & Tricks

- The slash command both opens and closes the UI. You can put this in a macro and bind it to a key for a quick toggle (same applies to the report command)
- If you open the UI with an enemy targeted, the note for that enemy will be selected. Otherwise, the last note you had open will be displayed
- The size and position of the UI is saved for the next time it's opened 

## Installation

DungeonDocs can be installed using [WowUp](https://wowup.io/).

For manual installation, the addon is made available here:
- [CurseForge](https://www.curseforge.com/wow/addons/dungeondocs)
- [Wago](https://addons.wago.io/addons/dungeondocs)
- [GitHub Releases](https://github.com/wardann/DungeonDocs/releases)

## Help

Questions? Feedback? Found a bug? Want to request a feature?

Please [open an issue](https://github.com/wardann/DungeonDocs/issues/new).


## Special Thanks

- Boss notes for TWW S1 was sourced from these two Reddit posts, so thank you to the authors:
  -  [Simple Tips for Every M+ Boss (Shareable Infographic)](https://www.reddit.com/r/wow/comments/1fixt35/simple_tips_for_every_m_boss_shareable_infographic/?share_id=E9PNOF_5JEyhxG4rpS5C3&utm_content=1&utm_medium=ios_app&utm_name=ioscss&utm_source=share&utm_term=1)
  - [Mythic Dungeon Copy/Paste Instructions from a PUG Tank](https://www.reddit.com/r/wow/comments/1fectof/mythic_dungeon_copypaste_instructions_from_pug/)

- This [awesome WeakAura pack](https://www.reddit.com/r/wow/comments/1fenyjp/weakaura_for_boss_instructions_all_season_1/) sparked the idea for this addon

- The incredible [MythicDungeonTools](https://github.com/Nnoggie/MythicDungeonTools) was referenced for mob data



