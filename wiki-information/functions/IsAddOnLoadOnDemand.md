## Title: IsAddOnLoadOnDemand

**Content:**
Returns true if the specified addon is load-on-demand.
`loadDemand = IsAddOnLoadOnDemand(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to GetNumAddOns. The state of Blizzard addons can only be queried by name.

**Returns:**
- `loadDemand`
  - *boolean* - True if the specified addon is loaded on demand.

**Usage:**
Loads every LoD addon.
```lua
for i = 1, GetNumAddOns() do
  if IsAddOnLoadOnDemand(i) then
    LoadAddOn(i)
  end
end
```