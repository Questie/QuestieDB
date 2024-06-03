## Title: C_ChatInfo.IsAddonMessagePrefixRegistered

**Content:**
Returns whether the prefix is registered.
`isRegistered = C_ChatInfo.IsAddonMessagePrefixRegistered(prefix)`

**Parameters:**
- `prefix`
  - *string*

**Returns:**
- `isRegistered`
  - *boolean*

**Reference:**
- `C_ChatInfo.GetRegisteredAddonMessagePrefixes()`
- `C_ChatInfo.RegisterAddonMessagePrefix()`

### Example Usage:
This function can be used to check if a specific prefix for addon communication is already registered before attempting to register it again. This is useful in preventing duplicate registrations which can lead to errors or unexpected behavior.

### Addon Usage:
Many large addons, such as WeakAuras, use this function to manage their communication channels. For instance, WeakAuras uses custom prefixes to send data between players, ensuring that the prefix is registered before sending messages to avoid conflicts.