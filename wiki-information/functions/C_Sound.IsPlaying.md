## Title: C_Sound.IsPlaying

**Content:**
Needs summary.
`isPlaying = C_Sound.IsPlaying(soundHandle)`

**Parameters:**
- `soundHandle`
  - *number*

**Returns:**
- `isPlaying`
  - *boolean*

**Example Usage:**
This function can be used to check if a specific sound is currently playing in the game. For instance, if you have a custom addon that plays a sound when a certain event occurs, you can use `C_Sound.IsPlaying` to verify if the sound is still playing before attempting to play it again.

**Addons:**
Many large addons that manage sound effects, such as DBM (Deadly Boss Mods) or WeakAuras, might use this function to ensure that sounds are not played multiple times simultaneously, which can help in managing sound clutter and improving the user experience.