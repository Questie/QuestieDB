## Title: C_MountJournal.GetMountInfoByID

**Content:**
Returns information about the specified mount.
```lua
name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID, isForDragonriding = C_MountJournal.GetMountInfoByID(mountID)
name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID, isForDragonriding = C_MountJournal.GetDisplayedMountInfo(displayIndex)
```

**Parameters:**
- **GetMountInfoByID:**
  - `mountID`
    - *number* : MountID - Returned from `C_MountJournal.GetMountIDs()`

- **GetDisplayedMountInfo:**
  - `displayIndex`
    - *number* - Index of the displayed mount in the mount journal list with the current search query and filters. Ranging from 1 to `C_MountJournal.GetNumDisplayedMounts()`

**Returns:**
1. `name`
   - *string* - The name of the mount.
2. `spellID`
   - *number* - The ID of the spell that summons the mount.
3. `icon`
   - *number* : FileID - Icon texture used by the mount.
4. `isActive`
   - *boolean* - Indicates if the player is currently mounted on the mount.
5. `isUsable`
   - *boolean* - Indicates if the mount is usable based on the player's current location, riding skill, profession skill, class, etc.
6. `sourceType`
   - *number* - Indicates generally how the mount may be obtained; a localized string describing the acquisition method is returned by `C_MountJournal.GetMountInfoExtraByID`.
7. `isFavorite`
   - *boolean* - Indicates if the mount is currently marked as a favorite.
8. `isFactionSpecific`
   - *boolean* - true if the mount is only available to one faction, false otherwise.
9. `faction`
   - *number?* - 0 if the mount is available only to Horde players, 1 if the mount is available only to Alliance players, or nil if the mount is not faction-specific.
10. `shouldHideOnChar`
    - *boolean* - Indicates if the mount should be hidden in the player's mount journal (includes Swift Spectral Gryphon and mounts specific to the opposite faction).
11. `isCollected`
    - *boolean* - Indicates if the player has learned the mount.
12. `mountID`
    - *number* - ID of the mount.
13. `isForDragonriding`
    - *boolean* - Indicates if the mount is used for Dragonriding.

**Description:**
Current values of the `sourceType` return include:
- 0 - not categorized; includes many mounts that should (and may eventually) be included in one of the other categories

| BATTLE_PET_SOURCE | ID | Constant | Value | Description |
|-------------------|----|----------|-------|-------------|
| 1                 | 1  | BATTLE_PET_SOURCE_1 | Drop       | Drop        |
| 2                 | 2  | BATTLE_PET_SOURCE_2 | Quest      | Quest       |
| 3                 | 3  | BATTLE_PET_SOURCE_3 | Vendor     | Vendor      |
| 4                 | 4  | BATTLE_PET_SOURCE_4 | Profession | Profession  |
| 5                 | 5  | BATTLE_PET_SOURCE_5 | Pet Battle | Pet Battle  |
| 6                 | 6  | BATTLE_PET_SOURCE_6 | Achievement| Achievement |
| 7                 | 7  | BATTLE_PET_SOURCE_7 | World Event| World Event |
| 8                 | 8  | BATTLE_PET_SOURCE_8 | Promotion  | Promotion   |
| 9                 | 9  | BATTLE_PET_SOURCE_9 | Trading Card Game | Trading Card Game |
| 10                | 10 | BATTLE_PET_SOURCE_10| In-Game Shop | In-Game Shop |
| 11                | 11 | BATTLE_PET_SOURCE_11| Discovery  | Discovery   |