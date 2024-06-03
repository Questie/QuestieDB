## Title: C_Item.GetItemQuality

**Content:**
Needs summary.
`itemQuality = C_Item.GetItemQuality(itemLocation)`
`itemQuality = C_Item.GetItemQualityByID(itemInfo)`

**Parameters:**
- **GetItemQuality:**
  - `itemLocation`
    - *ItemLocationMixin*

- **GetItemQualityByID:**
  - `itemInfo`
    - *number|string* : Item ID, Link or Name

**Returns:**
- `itemQuality`
  - *Enum.ItemQuality*
    - **Value**
    - **Field**
    - **GlobalString (enUS)**
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
`GetItemQualityColor()`