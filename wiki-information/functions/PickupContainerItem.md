## Title: PickupContainerItem

**Content:**
Wildcard function usually called when a player left clicks on a slot in their bags. Functionality includes picking up the item from a specific bag slot, putting the item into a specific bag slot, and applying enchants (including poisons and sharpening stones) to the item in a specific bag slot, except if one of the Modifier Keys is pressed.
`PickupContainerItem(bagID, slot)`

**Parameters:**
- `bagID`
  - *number* - id of the bag the slot is located in.
- `slot`
  - *number* - slot inside the bag (top left slot is 1, slot to the right of it is 2).

**Description:**
The function behaves differently depending on what is currently on the cursor:
- If the cursor currently has nothing, calling this will pick up an item from your backpack.
- If the cursor currently contains an item (check with `CursorHasItem()`), calling this will place the item currently on the cursor into the specified bag slot. If there is already an item in that bag slot, the two items will be exchanged.
- If the cursor is set to a spell (typically enchanting and poisons, check with `SpellIsTargeting()`), calling this specifies that you want to cast the spell on the item in that bag slot.

Trying to pickup the same item twice in the same "time tick" does not work (client seems to flag the item as "locked" and waits for the server to sync). This is only a problem if you might move a single item multiple times (i.e., if you are changing your character's equipped armor, you are not likely to move a single piece of armor more than once). If you might move an object multiple times in rapid succession, you can check the item's 'locked' flag by calling `GetContainerItemInfo`. If you want to do this, you should leverage `OnUpdate` to help you. Avoid constantly checking the lock status inside a tight loop. If you do, you risk getting into a race condition. Once the repeat loop starts running, the client will not get any communication from the server until it finishes. However, it will not finish until the server tells it that the item is unlocked. Here is some sample code that illustrates the problem.

```lua
function DangerousSwapItems(bag1, slot1, bag2, slot2)
  ClearCursor()
  repeat
    local _, _, locked1 = GetContainerItemInfo(bag1, slot1)
    local _, _, locked2 = GetContainerItemInfo(bag2, slot2)
    --[[ DANGER! At this point, locked1 and locked2 will not change. They will not change 
    until the server tells us that the items in question have become unlocked, and that 
    will not happen until we finish this call stack (i.e. return from this function,
    then his caller, then his caller, all the way up our lua code). ]]
  until not (locked1 or locked2)
  PickupContainerItem(bag1, slot1)
  PickupContainerItem(bag2, slot2)
end

DangerousSwapItems(1, 1, 1, 2)
DangerousSwapItems(1, 2, 1, 3) --DANGER! Item in (1, 2) is likely still locked, and this function will never return!
```

A potentially better way to do this is to use coroutines:

```lua
function SaferSwapItems(bag1, slot1, bag2, slot2)
  ClearCursor()
  repeat
    local _, _, locked1 = GetContainerItemInfo(bag1, slot1)
    local _, _, locked2 = GetContainerItemInfo(bag2, slot2)
    if locked1 or locked2 then
      coroutine.yield()
    end
  until not (locked1 or locked2)
  PickupContainerItem(bag1, slot1)
  PickupContainerItem(bag2, slot2)
end

co = coroutine.create(SaferSwapItems)

function OnUpdate()
  coroutine.resume(co) -- We should actually look at the return value from resume, because 
  -- it will be false when the coroutine is actually finished
end
```

You can also use the event `ITEM_LOCK_CHANGED` instead of `OnUpdate`.

**Reference:**
- `GetContainerItemInfo`