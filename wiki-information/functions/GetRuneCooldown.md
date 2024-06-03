## Title: GetRuneCooldown

**Content:**
Returns the Death Knight's cooldown info for the specified rune.
`start, duration, runeReady = GetRuneCooldown(id)`

**Parameters:**
- `id`
  - *number* - The rune index, ranging between 1 and 6.

**Returns:**
- `start`
  - *number* - The value of `GetTime()` when the rune's cooldown began (or 0 if the rune is off cooldown).
- `duration`
  - *number* - The duration of the rune's cooldown (regardless of whether or not it's on cooldown).
- `runeReady`
  - *boolean* - Whether or not the rune is off cooldown. True if ready, false if not.

**Usage:**
This will print the number of runes you have ready to cast.
```lua
local amount = 0
for i = 1, 6 do
    local start, duration, runeReady = GetRuneCooldown(i)
    if runeReady then
        amount = amount + 1
    end
end
print("Available Runes: " .. amount)
```