## Title: OfferPetition

**Content:**
Offers a petition to your target.
`OfferPetition()`

**Usage:**
You can efficiently ask for petition signatures with a macro like this one:
```lua
#showtooltip
/use item:5863
/run local s,t={},UnitName("target")for i=1,GetNumPetitionNames()do s=1 end if GetPetitionInfo()and t and not sthen OfferPetition()end
```

**Example Use Case:**
This function can be used when you need to gather signatures for a guild charter or arena team charter. By using the provided macro, you can streamline the process of offering the petition to your target, making it easier to collect the necessary signatures.

**Addons:**
While not commonly used in large addons, this function is particularly useful for players who are forming new guilds or arena teams and need to gather signatures quickly and efficiently.