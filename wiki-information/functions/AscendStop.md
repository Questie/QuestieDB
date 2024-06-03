## Title: AscendStop

**Content:**
Called when the player releases the jump key.
`AscendStop()`

**Description:**
This doesn't appear to affect the actual jump at all, but may be hooked to monitor when the jump key is released.
Called as the jump key is released, regardless if you are in the middle of the jump or held it down until the jump finished.

**Usage:**
Prints "Jump Released" when releasing the jump key.
```lua
hooksecurefunc("AscendStop", function()
    DEFAULT_CHAT_FRAME:AddMessage("Jump Released")
end)
```

**Reference:**
`JumpOrAscendStart`