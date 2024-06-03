## Title: IsMoviePlayable

**Content:**
Returns true if the specified movie exists and can be played.
`playable = IsMoviePlayable(movieID)`

**Parameters:**
- `movieID`
  - *number*

**Returns:**
- `playable`
  - *boolean*

**Example Usage:**
```lua
local movieID = 1 -- Example movie ID
if IsMoviePlayable(movieID) then
    print("The movie is playable.")
else
    print("The movie is not playable.")
end
```

**Description:**
The `IsMoviePlayable` function is used to check if a specific in-game cinematic or movie can be played. This can be useful for addons that manage or display in-game cinematics, ensuring that the movie exists before attempting to play it.