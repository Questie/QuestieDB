## Title: IsTradeskillTrainer

**Content:**
Returns true if the training window is used for a profession trainer.
`isTradeskillTrainer = IsTradeskillTrainer()`

**Returns:**
- `1` or `True` if the last open trainer skill list was for a trade skill (as opposed to class skills).

**Usage:**
```lua
if (IsTradeskillTrainer()) then
  message('This is a tradeskill trainer');
end
```

**Example Use Case:**
This function can be used in an addon to determine if the player is interacting with a tradeskill trainer, allowing the addon to display relevant information or options specific to tradeskill training.

**Addon Usage:**
Many large addons, such as TradeSkillMaster, use this function to enhance the user interface and provide additional functionality when interacting with tradeskill trainers. For example, TradeSkillMaster might use this function to automatically display crafting options or manage inventory related to tradeskills.