## Title: UnitInParty

**Content:**
Returns true if the unit is a member of your party.
`inParty = UnitInParty(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Returns:**
- `inParty`
  - *boolean* - if the unit is in your party

**Usage:**
```lua
if UnitInParty("target") then
  print("Your target is in your party.")
else
  print("Your target is not in your party.")
end
```

**Description:**
- Pets are not considered to be part of your party (but see `UnitPlayerOrPetInParty`).
- Battleground raid/party members are also not considered to be part of your party.
- `UnitInParty("player")` returns nil when you are not in a party.
- As of 2.0.3, `UnitInParty("player")` always returns 1, even when you are not in a party.
- `UnitInParty("player")` should return nil. (since patch 1.11.2, always returned 1 before)
- Use `GetNumPartyMembers` and `GetNumRaidMembers` to determine if you are in a party or raid.

**Reference:**
- `UnitInRaid`