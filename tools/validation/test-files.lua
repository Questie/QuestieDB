-- tools/validation/test-files.lua
--
-- The three filesystem operations the offline tests need and plain Lua lacks: list files,
-- make a temporary directory, remove a tree. Each uses the platform's own shell command,
-- exactly like lib.mkdirp, so `lua test.lua` needs nothing beyond the interpreter.
-- Paths go in and come out with forward slashes; Lua's io accepts those on Windows too.
local lib = dofile("generator/lib.lua")
local files = {}

---@param command string
---@return string[] lines Non-empty output lines, without line endings.
local function outputLines(command)
  local pipe = assert(lib.popen(command .. " 2>" .. lib.nullDevice), "Cannot run: " .. command)
  local lines = {}
  for line in pipe:lines() do
    line = line:gsub("\r$", "")
    if line ~= "" then lines[#lines + 1] = line end
  end
  pipe:close()
  return lines
end

---@param command string
---@return boolean succeeded
local function succeeds(command)
  local status = lib.execute(command)
  return status == 0 or status == true
end

---Files under `path`, sorted, as forward-slash paths that keep `path` as their prefix.
---@param path string
---@param recursive boolean
---@param suffixes string[] Keep only names ending in one of these non-empty strings; an empty list keeps every file.
---@return string[] paths
function files.list(path, recursive, suffixes)
  local found
  if lib.isWindows then
    local native = path:gsub("/", "\\")
    if recursive then
      -- `dir /s` prints absolute paths; strip the working directory to get back to `path`.
      -- `cd` already ends in a backslash at a drive root, and the filesystem is case-insensitive.
      local prefix = outputLines("cd")[1] or ""
      if prefix:sub(-1) ~= "\\" then prefix = prefix .. "\\" end
      found = outputLines("dir /s /b /a-d " .. lib.shellQuote(native, false))
      for index, absolute in ipairs(found) do
        if absolute:sub(1, #prefix):lower() == prefix:lower() then found[index] = absolute:sub(#prefix + 1) end
      end
    else
      found = outputLines("dir /b /a-d " .. lib.shellQuote(native, false))
      for index, name in ipairs(found) do found[index] = native .. "\\" .. name end
    end
    for index, entry in ipairs(found) do found[index] = (entry:gsub("\\", "/")) end
  else
    found = outputLines("find " .. lib.shellQuote(path) .. (recursive and "" or " -maxdepth 1") .. " -type f")
  end

  local selected = {}
  for _, entry in ipairs(found) do
    local keep = #suffixes == 0
    for _, suffix in ipairs(suffixes) do
      if entry:sub(-#suffix) == suffix then keep = true; break end
    end
    if keep then selected[#selected + 1] = entry end
  end
  table.sort(selected)
  return selected
end

---A fresh, empty directory the caller owns and removes with `removeTree`.
---@return string path
function files.temporaryDirectory()
  local path
  if lib.isWindows then
    -- Lua's os.tmpname targets the drive root on Windows, which is rarely writable.
    local base = os.getenv("TEMP") or os.getenv("TMP") or "."
    path = base:gsub("\\", "/") .. "/questiedb-test-" .. os.time() .. "-" .. tostring(os.clock()):gsub("%.", "")
    assert(succeeds("mkdir " .. lib.shellQuote((path:gsub("/", "\\")), false)),
      "Cannot create temporary directory: " .. path)
  else
    -- os.tmpname creates a file; reuse its unique name for a directory.
    path = os.tmpname()
    os.remove(path)
    assert(succeeds("mkdir " .. lib.shellQuote(path)), "Cannot create temporary directory: " .. path)
  end
  return path
end

---Remove a file or directory tree. A missing path is not an error.
---@param path string
---@return nil
function files.removeTree(path)
  local command
  if lib.isWindows then
    local native = path:gsub("/", "\\")
    local quoted = lib.shellQuote(native, false)
    -- `if exist "dir\"` is cmd's directory test; a plain `if exist` matches files as well.
    -- `del` never sets an exit code, so success is proven by the path being gone afterwards.
    command = "if exist " .. lib.shellQuote(native .. "\\", false) .. " (rmdir /s /q " .. quoted ..
      ") else (if exist " .. quoted .. " del /f /q " .. quoted .. ") & if exist " .. quoted .. " exit 1"
  else
    command = "rm -rf -- " .. lib.shellQuote(path)
  end
  assert(succeeds(command), "Cannot remove: " .. path)
end

return files
