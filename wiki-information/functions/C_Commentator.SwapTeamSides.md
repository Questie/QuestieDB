## Title: C_Commentator.SwapTeamSides

**Content:**
Needs summary.
`C_Commentator.SwapTeamSides()`

**Description:**
This function is used in the World of Warcraft API to swap the sides of the teams in a commentator's view. This can be particularly useful in esports broadcasting or in-game events where the commentator needs to switch perspectives for better clarity or to follow the action more effectively.

**Example Usage:**
In a custom addon designed for esports commentary, you might use this function to dynamically change the view of the teams during a live broadcast.

```lua
-- Example usage in a custom addon
if event == "SWAP_SIDES" then
    C_Commentator.SwapTeamSides()
end
```

**Addons Using This Function:**
- **WoW Esports Addon**: This addon might use `C_Commentator.SwapTeamSides` to enhance the viewing experience by allowing commentators to switch team perspectives seamlessly during live matches.