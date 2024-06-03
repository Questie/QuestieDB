## Title: C_UI.Reload

**Content:**
Reloads the User Interface.
`C_UI.Reload()`

**Description:**
Reloading the interface saves the current settings to disk, and updates any addon files previously loaded by the game. In order to load new files (or addons), the game must be restarted.
You can also use the `/reload` slash command; or the console equivalent: `/console ReloadUI`.

**Example Usage:**
This function is commonly used by addon developers to quickly test changes to their addons without needing to restart the game. For instance, after modifying an addon's Lua or XML files, calling `C_UI.Reload()` will apply those changes immediately.

**Popular Addons Using This Function:**
Many popular addons, such as ElvUI and WeakAuras, provide a button or command to reload the UI, leveraging this function to help users apply configuration changes or updates without restarting the game.