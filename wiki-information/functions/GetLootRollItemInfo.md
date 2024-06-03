## Title: GetLootRollItemInfo

**Content:**
Returns information about the loot event with rollID.
`texture, name, count, quality, bindOnPickUp, canNeed, canGreed, canDisenchant, reasonNeed, reasonGreed, reasonDisenchant, deSkillRequired, canTransmog = GetLootRollItemInfo(rollID)`

**Parameters:**
- `rollID`
  - *number* - The number increments by 1 for each new roll. The count is not reset by reloading the UI.

**Returns:**
- `texture`
  - *string* - The path of the texture of the item icon.
- `name`
  - *string* - The name of the item.
- `count`
  - *number* - The quantity of the item.
- `quality`
  - *number* - The quality of the item. Starting with 1 for common, going up to 5 for legendary.
- `bindOnPickUp`
  - *boolean* - Returns 1 when the item is bind on pickup, nil otherwise.
- `canNeed`
  - *boolean* - Returns 1 when you can roll need on the item, nil otherwise.
- `canGreed`
  - *boolean* - Returns 1 when you can roll greed on the item, nil otherwise.
- `canDisenchant`
  - *boolean* - Returns 1 when you can disenchant the item, nil otherwise.
- `reasonNeed`
  - *number* - See details.
- `reasonGreed`
  - *number* - See details.
- `reasonDisenchant`
  - *number* - See details.
- `deSkillRequired`
  - *number* - Required skill in enchanting to disenchant the item.
- `canTransmog`
  - *boolean* - Returns 1 when you can transmogrify the item, nil otherwise.

**Description:**
The return values `reasonNeed`/`reasonGreed`/`reasonDisenchant` can be numbers from 0 to 5. The following logic is used in FrameXML:
If the player cannot roll need/greed/disenchant, the respective loot button is disabled and gets a tooltip from one of the following global strings, where the number is determined by the return values `reasonNeed`/`reasonGreed`/`reasonDisenchant`:
- `LOOT_ROLL_INELIGIBLE_REASON1`: "Your class may not roll need on this item."
- `LOOT_ROLL_INELIGIBLE_REASON2`: "You already have the maximum amount of this item."
- `LOOT_ROLL_INELIGIBLE_REASON3`: "This item may not be disenchanted."
- `LOOT_ROLL_INELIGIBLE_REASON4`: "You do not have an Enchanter of skill %d in your group."
- `LOOT_ROLL_INELIGIBLE_REASON5`: "Need rolls are disabled for this item."

For example, `NeedButton.reason = _G`. If the player can roll need/greed/disenchant, the respective value of `reasonNeed`/`reasonGreed`/`reasonDisenchant` returns 0.