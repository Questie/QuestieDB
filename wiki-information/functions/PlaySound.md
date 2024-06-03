## Title: PlaySound

**Content:**
Plays the specified sound by SoundKitID.
`willPlay, soundHandle = PlaySound(soundKitID)`

**Parameters:**
- `soundKitID`
  - *number* - Sound Kit ID in SoundKitEntry.db2. Sounds used in FrameXML are defined in the SOUNDKIT table.
- `channel`
  - *string? = SFX* - The sound channel.
    - **Channel**
      - **Toggle CVar**
      - **Volume CVar**
      - **Master**
        - `Sound_EnableAllSound` - Default: 1
        - `Sound_MasterVolume` - Default: 1.0 (master volume, 0.0 to 1.0)
      - **Music**
        - `Sound_EnableMusic` - Default: 1 (Enables music)
        - `Sound_MusicVolume` - Default: 0.4
      - **SFX (Effects)**
        - `Sound_EnableSFX` - Default: 1
        - `Sound_SFXVolume` - Default: 1.0 (sound volume, 0.0 to 1.0)
      - **Ambience**
        - `Sound_EnableAmbience` - Default: 1 (Enable Ambience)
        - `Sound_AmbienceVolume` - Default: 0.6
      - **Dialog**
        - `Sound_EnableDialog` - Default: 1 (all dialog)
        - `Sound_DialogVolume` - Default: 1.0 (Dialog Volume, 0.0 to 1.0)
      - **Talking Head**
        - Volume sliders in the interface options
- `forceNoDuplicates`
  - *boolean? = true* - Allows duplicate sounds if false.
- `runFinishCallback`
  - *boolean? = false* - Fires SOUNDKIT_FINISHED when the sound has finished playing, arg1 will be soundHandle.

**Returns:**
- `willPlay`
  - *boolean* - true if the sound will be played, nil otherwise (prevented by a muted sound channel, for instance).
- `soundHandle`
  - *number* - identifier for the queued playback.

**Usage:**
Plays the ready check sound file (sound/interface/levelup2.ogg)
```lua
PlaySound(SOUNDKIT.READY_CHECK) -- by SOUNDKIT key
PlaySound(8960) -- by SoundKitID
PlaySoundFile(567478) -- by FileDataID
```

**Description:**
Sound Kit IDs are used to play a set of random sounds. For example, the human female NPC greeting sound kit refers to 5 different sounds.
```lua
/run PlaySound(5980) -- will play one of these sounds
/run PlaySoundFile(552133) -- sound/creature/humanfemalestandardnpc/humanfemalestandardnpcgreeting01.ogg
/run PlaySoundFile(552141) -- sound/creature/humanfemalestandardnpc/humanfemalestandardnpcgreeting02.ogg
/run PlaySoundFile(552137) -- sound/creature/humanfemalestandardnpc/humanfemalestandardnpcgreeting03.ogg
/run PlaySoundFile(552142) -- sound/creature/humanfemalestandardnpc/humanfemalestandardnpcgreeting04.ogg
/run PlaySoundFile(552144) -- sound/creature/humanfemalestandardnpc/humanfemalestandardnpcgreeting05.ogg
```

**Miscellaneous:**
Finding Sound IDs:
- **File Data IDs**
  - By file name/path, e.g. Spells/LevelUp, type:ogg in wow.tools
  - By SoundKitID, e.g. skit:888 in wow.tools
  - By sound kit name with [wow.tools](https://wow.tools/files/sounds.php)
- **Sound Kit Names/IDs**
  - From the sounds tab for an NPC, for example [Waveblade Shaman](https://www.wowhead.com/npc=154304/waveblade-shaman#sounds)
  - By sound kit name with [Wowhead Sounds](https://www.wowhead.com/sounds) and SoundKitName.db2
  - IDs used by the FrameXML are defined in the SOUNDKIT table
  - The full list of IDs can be found in SoundKitEntry.db2

**Reference:**
- `PlaySoundFile` - Accepts FileDataIDs and addon file paths.
- `StopSound`