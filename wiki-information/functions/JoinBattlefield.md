## Title: JoinBattlefield

**Content:**
Joins the battleground queue solo or as a group.
`JoinBattlefield(index)`

**Parameters:**
- `index`
  - *number* - Which battlefield instance to queue for (0 for first available), or which arena bracket to queue for.
- `asGroup`
  - *boolean* - If true-equivalent, the player's group is queued for the battlefield, otherwise, only the player is queued.
- `isRated`
  - *boolean* - If true-equivalent, and queueing for an arena bracket, the group is queued for a rated match as opposed to a skirmish.

**Description:**
The function requests the player to be added to a queue for a particular instance of the currently selected battleground type, as set by `RequestBattlegroundInstanceInfo(index)`. You CANNOT queue immediately after a `RequestBattlegroundInstanceInfo` call, and must instead capture the event that indicates that the instance list is available.

**Details:**
When the Arena Battlemaster window is open, index 1 is 2vs2, index 2 is 3vs3 and index 3 is 5vs5.

**Usage:**
The following code creates a utility function, `JoinBattlegroundType`, which allows you to queue for the first available instance of a specific battleground type.
```lua
do
  local f, aG, iR = CreateFrame("FRAME");
  f:SetScript("OnEvent", function(self, event)
    JoinBattlefield(0, aG, iR);
    self:UnregisterEvent("PVPQUEUE_ANYWHERE_SHOW");
  end);
  function JoinBattlegroundType(index, asGroup, isRated)
    if f:IsEventRegistered("PVPQUEUE_ANYWHERE_SHOW") then
      error("A join battleground request is already being processed");
    end
    f:RegisterEvent("PVPQUEUE_ANYWHERE_SHOW");
    aG, iR = asGroup, isRated;
    RequestBattlegroundInstanceInfo(index);
  end
end
```

**Reference:**
- `CanJoinBattlefieldAsGroup`