## Title: UnmuteSoundFile

**Content:**
Unmutes a sound file.
`UnmuteSoundFile(sound)`

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