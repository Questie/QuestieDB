## Title: MuteSoundFile

**Content:**
Mutes a sound file.
`MuteSoundFile(sound)`

**Parameters:**
- `sound`
  - *number|string* - FileID of a game sound or file path to an addon sound.

**Usage:**
Plays the Sound/Spells/LevelUp.ogg sound
```lua
/run PlaySoundFile(569593)
```
Mutes it, the sound won't play
```lua
/run MuteSoundFile(569593); PlaySoundFile(569593)
```
Unmutes it and plays it
```lua
/run UnmuteSoundFile(569593); PlaySoundFile(569593)
```
Addon example:
Mutes the fizzle sounds.
```lua
local sounds = {
    569772, -- sound/spells/fizzle/fizzleholya.ogg
    569773, -- sound/spells/fizzle/fizzlefirea.ogg
    569774, -- sound/spells/fizzle/fizzlenaturea.ogg
    569775, -- sound/spells/fizzle/fizzlefrosta.ogg
    569776, -- sound/spells/fizzle/fizzleshadowa.ogg
}
for _, fdid in pairs(sounds) do
    MuteSoundFile(fdid)
end
```

**Description:**
Muted sound settings only persist through relogging and /reload. They have to be muted again after restarting the game client.
This works on all internal game sounds, addon sounds, and sounds played manually by `PlaySoundFile()`.
There is no API to replace sound files.

**Miscellaneous:**
- **File Data IDs**
  - By file name/path, e.g. `Spells/LevelUp,type:ogg` in [wow.tools](https://wow.tools)
  - By SoundKitID, e.g. `skit:888` in [wow.tools](https://wow.tools)
  - By sound kit name with [wow.tools](https://wow.tools/files/sounds.php)
- **Sound Kit Names/IDs**
  - From the sounds tab for an NPC, for example [Waveblade Shaman](https://www.wowhead.com/npc=154304/waveblade-shaman#sounds)
  - By sound kit name with [Wowhead Sounds](https://www.wowhead.com/sounds) and `SoundKitName.db2`
  - IDs used by the FrameXML are defined in the `SOUNDKIT` table
  - The full list of IDs can be found in `SoundKitEntry.db2`