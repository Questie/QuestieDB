## Title: GetXPExhaustion

**Content:**
Returns the amount of current rested XP for the character.
`exhaustion = GetXPExhaustion()`

**Returns:**
- `exhaustion`
  - *number* - The exhaustion threshold. Returns nil if player is not rested.

**Description:**
This is the total and not the amount added. For example, if this says 5000 then the next 5000 XP gained from mobs will occur at double rate. The game actually gives double XP for mobs while rested as an add on. An example, a mob worth 98 XP is killed, XP gained is 98 + 98 rested XP bonus which reduces your 5000 by 196. If you take 1/2 the number then this is the XP bonus you are eligible for. i.e., you will get +2500 rested bonus for earning 2500 XP from mobs for a total XP gain of 5000 during that time. When you hit 0 the bonus is small, for example, say you have 20 left and you kill a mob worth 98 then you get 98 + 10 rested bonus and go to the 'normal' non-rested state. So if you rest in an inn and get this up to 2 then you will receive +1 bonus XP from your next mob and not double XP from the mob.