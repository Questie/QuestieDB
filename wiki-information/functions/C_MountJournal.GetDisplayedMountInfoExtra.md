## Title: C_MountJournal.GetMountInfoExtraByID

**Content:**
Returns extra information about the specified mount.
```lua
creatureDisplayInfoID, description, source, isSelfMount, mountTypeID,
uiModelSceneID, animID, spellVisualKitID, disablePlayerMountPreview
= C_MountJournal.GetMountInfoExtraByID(mountID)
= C_MountJournal.GetDisplayedMountInfoExtra(index)
```

**Parameters:**
- **GetMountInfoExtraByID:**
  - `mountID`
    - *number* : MountID - Returned from `C_MountJournal.GetMountIDs()`

- **GetDisplayedMountInfoExtra:**
  - `index`
    - *number* - Index of the displayed mount in the mount journal list with the current search query and filters. Ranging from 1 to `C_MountJournal.GetNumDisplayedMounts()`

**Returns:**
- `creatureDisplayInfoID`
  - *number* : DisplayID - If nil, then the mount has multiple displayIDs, from `C_MountJournal.GetMountAllCreatureDisplayInfoByID()`. This is not consistent however, since this can be not nil and still have multiple displayIds.
- `description`
  - *string* - flavor text describing the mount
- `source`
  - *string* - information about how the mount is obtained, including vendor name and location, monetary cost, etc.
- `isSelfMount`
  - *boolean* - true if the player transforms into the mount (e.g., Obsidian Nightwing or Sandstone Drake), or false for normal mounts
- `mountTypeID`
  - *number* - a number indicating the capabilities of the mount; known values include:
    - 230 for most ground mounts
    - 231 for 
    - 232 for (was named Abyssal Seahorse prior to Warlords of Draenor)
    - 241 for Blue, Green, Red, and Yellow Qiraji Battle Tank (restricted to use inside Temple of Ahn'Qiraj)
    - 242 for Swift Spectral Gryphon (hidden in the mount journal, used while dead in certain zones)
    - 247 for 
    - 248 for most flying mounts, including those that change capability based on riding skill
    - 254 for 
    - 269 for 
    - 284 for and Chauffeured Mechano-Hog
    - 398 for 
    - 402 for Dragonriding
    - 407 for 
    - 408 for 
    - 412 for Otto and Ottuk
    - 424 for Dragonriding mounts, including mounts that have dragonriding animations but are not yet enabled for dragonriding.
- `uiModelSceneID`
  - *number* : ModelSceneID
- `animID`
  - *number*
- `spellVisualKitID`
  - *number*
- `disablePlayerMountPreview`
  - *boolean*

**Example Usage:**
This function can be used to retrieve detailed information about a specific mount, which can be useful for addons that manage or display mount collections. For example, an addon could use this function to show additional details about a mount when a player hovers over it in their mount journal.

**Addons Using This Function:**
- **Altoholic:** This addon uses `C_MountJournal.GetMountInfoExtraByID` to display detailed mount information across multiple characters, helping players manage their collections more effectively.
- **Mount Journal Enhanced:** This addon enhances the default mount journal by adding more detailed information about each mount, including the extra information retrieved by this function.