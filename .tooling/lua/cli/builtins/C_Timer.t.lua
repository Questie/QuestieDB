---@meta

---@class luv
local luv = {}

--- Returns the current high-resolution real time in nanoseconds
---@return number
function luv.hrtime() end

---@class uv_handle_t
---@field close fun(self, callback?: fun())
---@field is_active fun(self):boolean
---@field is_closing fun(self):boolean

---@class uv_timer_t: uv_handle_t
---@field start fun(self, timeout: integer, repeat: integer, callback: function): integer
---@field stop fun(self): integer
---@field again fun(self): integer
---@field set_repeat fun(self, repeat: integer)
---@field get_repeat fun(self): integer

--- Creates and initializes a new timer handle.
---@return uv_timer_t
function luv.new_timer() end

--- Stops the event loop, causing `run()` to end as soon as possible.
function luv.stop() end

--- Runs the event loop.
---
---`"default"`: Runs the event loop until there are no more active and referenced handles or requests. Returns true if uv.stop() was called and there are still active handles or requests. Returns false in all other cases.<br>
---`"once"`: Poll for I/O once. Note that this function blocks if there are no pending callbacks. Returns false when done (no active handles or requests left), or true if more callbacks are expected (meaning you should run the event loop again sometime in the future).<br>
---`"nowait"`: Poll for I/O once but don't block if there are no pending callbacks. Returns false if done (no active handles or requests left), or true if more callbacks are expected (meaning you should run the event loop again sometime in the future).<br>
---@param mode? "default" | "once" | "nowait"
---@return boolean
function luv.run(mode) end

---Walk the list of handles: callback will be executed with each handle.
---@param callback fun(handle: uv_handle_t)
function luv.walk(callback) end

---Request handle to be closed. callback will be called asynchronously after this call. This MUST be called on each handle before memory is released.
---@param handle uv_handle_t
---@param callback? fun()
function luv.close(handle, callback) end

---Returns true if the handle is active, false if it's inactive.
---@param handle uv_handle_t
---@return boolean
function luv.is_active(handle) end

---Returns true if the handle is closing or closed, false otherwise.
---@param handle uv_handle_t
---@return boolean
function luv.is_closing(handle) end

return luv
