## Title: PlayMusic

**Content:**
Plays the specified sound file on loop to the "Music" sound channel.
`willPlay = PlayMusic(sound)`

**Parameters:**
- `sound`
  - *number|string* - FileDataID of a game sound or file path to an addon sound.

**Returns:**
- `willPlay`
  - *boolean* - Seems to always return true even for invalid file paths or FileDataIDs.

**Usage:**
Plays Stormstout Brew from the Mists of Pandaria Soundtrack
```lua
-- by file path (dropped in 8.2.0)
PlayMusic("sound/music/pandaria/mus_50_toast_b_03.mp3")
-- by FileDataID 642878 (added support in 8.2.0)
PlayMusic(642878)
```

**Description:**
If any of the built-in music is playing when you call this function (e.g. Stormwind background music), it will fade out.
The playback loops until it is stopped with `StopMusic()`, when the user interface is reloaded, or upon logout. Playing a different sound file will also cause the current song to stop playing. It cannot be paused.
OggVorbis (.ogg) files are supported since World of Warcraft uses the FMOD sound engine.
You can find a full list here: [WoW Tools - Sound/Music](https://wow.tools/files/#search=sound/music)