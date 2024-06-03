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
    - *boolean* - Indicates if the mount is for Dragonriding.

**Description:**
Current values of the `sourceType` return include:
- 0 - not categorized; includes many mounts that should (and may eventually) be included in one of the other categories

| BATTLE_PET_SOURCE | ID | Constant | Value | Description |
|-------------------|----|----------|-------|-------------|
| 1                 | BATTLE_PET_SOURCE_1 | Drop       | 1 | Drop |
| 2                 | BATTLE_PET_SOURCE_2 | Quest      | 2 | Quest |
| 3                 | BATTLE_PET_SOURCE_3 | Vendor     | 3 | Vendor |
| 4                 | BATTLE_PET_SOURCE_4 | Profession | 4 | Profession |
| 5                 | BATTLE_PET_SOURCE_5 | Pet Battle | 5 | Pet Battle |
| 6                 | BATTLE_PET_SOURCE_6 | Achievement| 6 | Achievement |
| 7                 | BATTLE_PET_SOURCE_7 | World Event| 7 | World Event |
| 8                 | BATTLE_PET_SOURCE_8 | Promotion  | 8 | Promotion |
| 9                 | BATTLE_PET_SOURCE_9 | Trading Card Game | 9 | Trading Card Game |
| 10                | BATTLE_PET_SOURCE_10| In-Game Shop | 10 | In-Game Shop |
| 11                | BATTLE_PET_SOURCE_11| Discovery  | 11 | Discovery |