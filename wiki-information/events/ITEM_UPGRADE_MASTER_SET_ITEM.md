## Event: ITEM_UPGRADE_MASTER_SET_ITEM

**Title:** ITEM UPGRADE MASTER SET ITEM

**Content:**
Fires after adding or removing items in the ItemUpgradeFrame used for item upgrading.
`ITEM_UPGRADE_MASTER_SET_ITEM`

**Payload:**
- `None`

**Content Details:**
Fires up to twice when the ItemUpgradeFrame closes; presumably forcing the slot clear.
Causes the frame to update its appearance using information provided in GetItemUpgradeItemInfo()