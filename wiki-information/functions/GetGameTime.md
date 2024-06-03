## Title: GetGameTime

**Content:**
Returns the realm's current time in hours and minutes.
`hours, minutes = GetGameTime()`

**Returns:**
- `hours`
  - *number* - The current hour (0-23).
- `minutes`
  - *number* - The minutes passed in the current hour (0-59).

**Description:**
This function can unexpectedly return results inconsistent with actual realm server time. The value returned is from the physical instance server you are actually playing on, and not that of the world instance server (realm server) you log into. Servers for instances such as for raids and PvP are often shared between login world servers, and instance servers are not always running using the same timezone as the login realm server. This is particularly noticeable for Oceanic and other low population world servers.

**Usage:**
```lua
/dump GetGameTime() -- 18, 41
```

**Miscellaneous:**
When in a EU time zone CEST (UTC+2) and playing on Moon Guard US, CDT (UTC-5). The examples were taken at the same time. Note that `time()` and `date()` are tied to your system's clock which can be manually changed.
```lua
-- unix time
time() -- 1596157547
GetServerTime() -- 1596157549
-- local time, same as `date(nil, time())`
date() -- "Fri Jul 31 03:05:47 2020"
-- realm time
GetGameTime() -- 20, 4
C_DateAndTime.GetCurrentCalendarTime() -- hour:20, minute:4
C_DateAndTime.GetServerTimeLocal() -- 1596139440 unix time offset by the server's time zone (e.g. UTC minus 5 hours)
```

**Reference:**
- `time()`
- `GetTime()`

### Example Usage
This function can be used in addons to display the current realm time, which can be useful for scheduling events or displaying time-sensitive information.

### Addons Using This Function
- **DBM (Deadly Boss Mods):** Uses `GetGameTime` to synchronize raid timers with the realm time.
- **ElvUI:** Utilizes `GetGameTime` to display the current realm time on the user interface.