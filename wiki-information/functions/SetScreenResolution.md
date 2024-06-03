## Title: SetScreenResolution

**Content:**
Returns the index of the current resolution in effect
`SetScreenResolution()`

**Parameters:**
- `index`
  - *number?* - This value specifies the new screen resolution, it must be the index of one of the values yielded by `GetScreenResolutions()`. Passing `nil` will default this argument to 1, the lowest resolution available.

**Usage:**
This sets the screen to 1024x768, if available:
```lua
local resolutions = {GetScreenResolutions()}
for i, entry in resolutions do
  if entry == '1024x768' then
    SetScreenResolution(i)
    break
  end
end
```

**Example Use Case:**
This function can be used in addons or scripts that need to change the screen resolution programmatically, such as during the initial setup of a game environment or when providing users with a custom settings interface.

**Addons:**
While not commonly used in large addons due to the potential disruption of changing screen resolution, it might be found in configuration tools or setup wizards that aim to optimize the game settings for the user's hardware.