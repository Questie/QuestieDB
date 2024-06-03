## Title: C_LossOfControl.GetActiveLossOfControlData

**Content:**
Returns info about an active loss-of-control effect.
```lua
event = C_LossOfControl.GetActiveLossOfControlData(index)
event = C_LossOfControl.GetActiveLossOfControlDataByUnit(unitToken, index)
```

**Parameters:**
- **GetActiveLossOfControlData:**
  - `index`
    - *number* - Ranging from 1 to `C_LossOfControl.GetActiveLossOfControlDataCount()`

- **GetActiveLossOfControlDataByUnit:**
  - `unitToken`
    - *string* : UnitId - Only works while in commentator mode.
  - `index`
    - *number*

**Returns:**
- `event`
  - *LossOfControlData?*
    - `Field`
    - `Type`
    - `Description`
    - `locType`
      - *string* - Effect type, e.g. "SCHOOL_INTERRUPT"
    - `spellID`
      - *number* - Spell ID causing the effect
    - `displayText`
      - *string* - Name of the effect, e.g. "Interrupted"
    - `iconTexture`
      - *number* - FileID
    - `startTime`
      - *number?* - Time at which this effect began, as per `GetTime()`
    - `timeRemaining`
      - *number?* - Number of seconds remaining.
    - `duration`
      - *number?* - Duration of the effect, in seconds.
    - `lockoutSchool`
      - *number* - Locked out spell school identifier; can be fed into `GetSchoolString()` to retrieve school name.
    - `priority`
      - *number*
    - `displayType`
      - *number* - An integer specifying how this event should be displayed to the player, per the Interface-configured options:
        - 0: the effect should not be displayed.
        - 1: the effect should be displayed as a brief alert when it occurs.
        - 2: the effect should be displayed for its full duration.

**Description:**
Loss of Control debuffs that are applied only while standing in an Area of Effect may not include a `startTime`, `timeRemaining` nor `duration` in the table returned. An example of this is Vol'zith the Whisperer's Yawning Gate ability.