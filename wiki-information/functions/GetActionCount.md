## Title: GetActionCount

**Content:**
Returns the available number of uses for an action.
`text = GetActionCount(actionSlot)`

**Parameters:**
- `actionSlot`
  - *number* - An action slot ID.

**Returns:**
- `text`
  - *number* - How often an item-based action (see details) may be performed; or always zero for other action types.

**Description:**
Use with `IsConsumableAction()` and `IsStackableAction()` to confirm that 'zero' is due to having zero uses of an item-based action, rather than always returning zero.
In Classic, use with `IsItemAction()` to ignore abilities that require a reagent; or alternatively use with `GetItemCount(itemID)` if the itemID of a reagent is known.
In Retail, use with `GetActionCharges()` for abilities with multiple charges.

**Usage:**
The following example originates from an older version of FrameXML/ActionButton.lua to display a number on each action button if applicable.
```lua
function ActionButton_UpdateCount (self)
    local text = _G;
    local action = self.action;
    if ( IsConsumableAction(action) or IsStackableAction(action) or (not IsItemAction(action) and GetActionCount(action) > 0) ) then
        local count = GetActionCount(action);
        if ( count > (self.maxDisplayCount or 9999 ) ) then
            text:SetText("*");
        else
            text:SetText(count);
        end
    else
        local charges, maxCharges, chargeStart, chargeDuration = GetActionCharges(action);
        if (maxCharges > 1) then
            text:SetText(charges);
        else
            text:SetText("");
        end
    end
end
```