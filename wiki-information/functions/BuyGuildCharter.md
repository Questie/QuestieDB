## Title: BuyGuildCharter

**Content:**
Purchases a guild charter.
`BuyGuildCharter(guildName)`

**Parameters:**
- `guildName`
  - *string* - Name of the guild you wish to purchase a guild charter for.

**Usage:**
The following purchases a guild charter for "MC Raiders":
```lua
BuyGuildCharter("MC Raiders");
```

**Description:**
There are two preconditions to using BuyGuildCharter:
- Must be talking to a Guild Master NPC.
- Must be on the Purchase a Guild Charter screen.

**Reference:**
- `OfferPetition`
- `TurnInGuildCharter`