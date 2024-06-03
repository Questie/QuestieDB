## Title: FlashClientIcon

**Content:**
Flashes the game client icon in the Operating System.
`FlashClientIcon()`

**Usage:**
Flashes the client icon after 5 seconds.
```lua
/run C_Timer.After(5, FlashClientIcon)
```
Prevents flashing the client icon by NOP'ing it.
```lua
FlashClientIcon = function() end
```