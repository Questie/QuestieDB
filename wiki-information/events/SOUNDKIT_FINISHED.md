## Event: SOUNDKIT_FINISHED

**Title:** SOUNDKIT FINISHED

**Content:**
Indicates a sound has finished playing, but only if the fourth argument in PlaySound(__, __, __, runFinishCallback) was set to true.
`SOUNDKIT_FINISHED: soundHandle`

**Payload:**
- `soundHandle`
  - *number* - The second return value from PlaySound() identifying which sound has finished playing.