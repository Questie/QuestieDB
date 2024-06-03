## Title: C_Container.ContainerIDToInventoryID

**Content:**
Needs summary.
`inventoryID = C_Container.ContainerIDToInventoryID(containerID)`

**Parameters:**
- `containerID`
  - *number* : Enum.BagIndex

**Values:**
| Description   | containerID | inventoryID |
|---------------|-------------|-------------|
| Backpack      | 0           | nil         |
| Bag 1         | 1           | 31          |
| Bag 2         | 2           | 32          |
| Bag 3         | 3           | 33          |
| Bag 4         | 4           | 34          |
| Reagent bag   | N/A         | 35          |
| Bank bag 1    | 5           | 76          |
| Bank bag 2    | 6           | 77          |
| Bank bag 3    | 7           | 78          |
| Bank bag 4    | 8           | 79          |
| Bank bag 5    | 9           | 80          |
| Bank bag 6    | 10          | 81          |
| Bank bag 7    | N/A         | 82          |
| Bank          | -1          | nil         |
| Keyring       | -2          | nil         |
| Reagent bank  | -3          | nil         |
| Bank bags     | -4          | nil         |

**Returns:**
- `inventoryID`
  - *number* : inventorySlotID