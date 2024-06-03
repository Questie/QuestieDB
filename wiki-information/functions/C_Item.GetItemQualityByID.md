## Title: C_Item.GetItemQuality

**Content:**
Needs summary.
```lua
itemQuality = C_Item.GetItemQuality(itemLocation)
itemQuality = C_Item.GetItemQualityByID(itemInfo)
```

**Parameters:**

**GetItemQuality:**
- `itemLocation`
  - *ItemLocationMixin*

**GetItemQualityByID:**
- `itemInfo`
  - *number|string* - Item ID, Link, or Name

**Returns:**
- `itemQuality`
  - *Enum.ItemQuality*
    - `Value`
    - `Field`
    - `GlobalString (enUS)`
    - `0`
      - Poor
      - ITEM_QUALITY0_DESC
    - `1`
      - Common
      - ITEM_QUALITY1_DESC
    - `2`
      - Uncommon
      - ITEM_QUALITY2_DESC
    - `3`
      - Rare
      - ITEM_QUALITY3_DESC
    - `4`
      - Epic
      - ITEM_QUALITY4_DESC
    - `5`
      - Legendary
      - ITEM_QUALITY5_DESC
    - `6`
      - Artifact
      - ITEM_QUALITY6_DESC
    - `7`
      - Heirloom
      - ITEM_QUALITY7_DESC
    - `8`
      - WoW Token
      - ITEM_QUALITY8_DESC

**Reference:**
- `GetItemQualityColor()`

**Example Usage:**
This function can be used to determine the quality of an item, which is useful for addons that need to display item quality or filter items based on their quality. For instance, an addon that manages inventory might use this function to sort items by quality or to highlight high-quality items.

**Addons Using This Function:**
- **Bagnon**: A popular inventory management addon that uses item quality to color-code items in the player's bags.
- **Auctioneer**: An addon that helps players with auction house activities, which might use item quality to determine pricing strategies for different items.