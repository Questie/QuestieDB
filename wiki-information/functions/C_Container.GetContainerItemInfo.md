## Title: C_Container.GetContainerItemInfo

**Content:**
Needs summary.
`containerInfo = C_Container.GetContainerItemInfo(containerIndex, slotIndex)`

**Parameters:**
- `containerIndex`
  - *number*
- `slotIndex`
  - *number*

**Returns:**
- `containerInfo`
  - *ContainerItemInfo?* - Returns nil if the container slot is empty.
    - `Field`
    - `Type`
    - `Description`
    - `iconFileID`
      - *number*
    - `stackCount`
      - *number*
    - `isLocked`
      - *boolean*
    - `quality`
      - *Enum.ItemQuality?*
    - `isReadable`
      - *boolean*
    - `hasLoot`
      - *boolean*
    - `hyperlink`
      - *string*
    - `isFiltered`
      - *boolean*
    - `hasNoValue`
      - *boolean*
    - `itemID`
      - *number*
    - `isBound`
      - *boolean*

**Example Usage:**
This function can be used to retrieve detailed information about a specific item in a player's bag. For instance, an addon could use this to display additional information about items when the player hovers over them in their inventory.

**Addon Usage:**
Large addons like Bagnon use this function to manage and display inventory items. Bagnon, for example, uses it to fetch item details to show item icons, stack counts, and other relevant information in a unified inventory interface.