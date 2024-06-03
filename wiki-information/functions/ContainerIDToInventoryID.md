## Title: ContainerIDToInventoryID

**Content:**
`bagID = ContainerIDToInventoryID(containerID)`

**Parameters:**
- `bagID`
  - *number* - BagID between 1 and NUM_BAG_SLOTS + NUM_BANKBAGSLOTS

**Values:**
| ID | Vanilla1.13.7 | Vanilla1.14.0 | TBC2.5.2 | Retail | Description |
|----|---------------|---------------|----------|--------|-------------|
| 1  | 20            |               |          |        | 1st character bag |
| 2  | 21            |               |          |        | 2nd character bag |
| 3  | 22            |               |          |        | 3rd character bag |
| 4  | 23            |               |          |        | 4th character bag |
| 48-71 | 48-71      | 48-75         | 52-79    |        | bank slots (vanilla: 24, bcc/retail: 28) |
| 5  | 72            | 76            | 76       | 80     | 1st bank bag |
| 6  | 73            | 77            | 77       | 81     | 2nd bank bag |
| 7  | 74            | 78            | 78       | 82     | 3rd bank bag |
| 8  | 75            | 79            | 79       | 83     | 4th bank bag |
| 9  | 76            | 80            | 80       | 84     | 5th bank bag |
| 10 | 77            | 81            | 81       | 85     | 6th bank bag |
| 11 |               | 82            | 86       |        | 7th bank bag |

**Returns:**
- `inventoryID`
  - *number* - InventorySlotId used in functions like `PutItemInBag()` and `GetInventoryItemLink()`

**Usage:**
Prints all bag container IDs and their respective inventory IDs (You need to be at the bank for bank inventory IDs to return valid results):
```lua
for i = 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
  local invID = ContainerIDToInventoryID(i)
  print(i, invID, GetInventoryItemLink("player", invID))
end
```