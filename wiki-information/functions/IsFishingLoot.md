## Title: IsFishingLoot

**Content:**
This function is only for determining if the loot window is related to fishing.

**Returns:**
- `isTrue`
  - *boolean* - is it true

**Usage:**
This will identify that the loot window should display the fish graphic, then play the sound and update the image.
```lua
if IsFishingLoot() then
  PlaySound("FISHING REEL IN")
  LootFramePortraitOverlay:SetTexture("Interface\\LootFrame\\FishingLoot-Icon")
end
```

**Example Use Case:**
- **Fishing Addons:** Many fishing-related addons, such as Fishing Buddy, use this function to customize the loot window when the player is fishing. This enhances the user experience by providing visual and audio feedback specific to fishing activities.