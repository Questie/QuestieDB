## Title: PlaySoundFile

**Content:**
Plays the specified sound by FileDataID or addon file path.
`willPlay, soundHandle = PlaySoundFile(sound)`

**Parameters:**
- `sound`
  - *number|string* - Either a FileDataID, or the path to a sound file from an addon.
    - The file must exist prior to logging in or reloading. Both .ogg and .mp3 formats are accepted.
- `channel`
  - *string?* = SFX - The sound channel.
    - **Channel**
      - **Toggle CVar**
      - **Volume CVar**
      - **Master**
        - `Sound_EnableAllSound` (Sound) Default: 1
        - `Sound_MasterVolume` (Sound) Default: 1.0 master volume (0.0 to 1.0)
      - **Music**
        - `Sound_EnableMusic` (Sound) Default: 1 Enables music
        - `Sound_MusicVolume` Default: 0.4
      - **SFX (Effects)**
        - `Sound_EnableSFX` (Sound) Default: 1
        - `Sound_SFXVolume` (Sound) Default: 1.0 sound volume (0.0 to 1.0)
      - **Ambience**
        - `Sound_EnableAmbience` (Sound) Default: 1 Enable Ambience
        - `Sound_AmbienceVolume` Default: 0.6
      - **Dialog**
        - `Sound_EnableDialog` (Sound) Default: 1 all dialog
        - `Sound_DialogVolume` (Sound) Default: 1.0 Dialog Volume (0.0 to 1.0)
      - **Talking Head**
        - Volume sliders in the interface options

**Returns:**
- `willPlay`
  - *boolean* - true if the sound will be played, nil otherwise (prevented by a muted sound channel, for instance).
- `soundHandle`
  - *number* - identifier for the queued playback.

**Usage:**
- Plays a sound file included with your addon and ignores any sound setting except the master volume slider:
  ```lua
  -- Both slash / or escaped backslashes \\ can be used as file separators.
  PlaySoundFile("Interface\\AddOns\\MyAddOn\\mysound.ogg", "Master")
  ```
- Plays the level up sound:
  ```lua
  -- by file path (dropped in 8.2.0)
  PlaySoundFile("Sound/Spells/LevelUp.ogg")
  -- by FileDataID 569593 (added support in 8.2.0)
  PlaySoundFile(569593)
  -- by SoundKitID 888 (SoundKitName LEVELUP)
  PlaySound(888)
  ```

**Miscellaneous:**
- **File Data IDs**
  - By file name/path, e.g. `Spells/LevelUp,type:ogg` in wow.tools
  - By SoundKitID, e.g. `skit:888` in wow.tools
  - By sound kit name with [wow.tools](https://wow.tools/files/sounds.php)
- **Sound Kit Names/IDs**
  - From the sounds tab for an NPC, for example [Waveblade Shaman](https://www.wowhead.com/npc=154304/waveblade-shaman#sounds)
  - By sound kit name with [Wowhead Sounds](https://www.wowhead.com/sounds) and `SoundKitName.db2`
  - IDs used by the FrameXML are defined in the `SOUNDKIT` table
  - The full list of IDs can be found in `SoundKitEntry.db2`

**Reference:**
- `PlaySound` - Plays a sound by SoundKitID
- `StopSound`
- `MuteSoundFile` - Mutes a sound
- `UnmuteSoundFile`
- `PlaySoundFile` macros - Listing of audio files shipped with the game