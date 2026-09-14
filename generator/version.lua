-- generator/version.lua
--
-- The committed Source TOC owns the release version. Baked artifacts add commit provenance
-- unless publication explicitly requests a full release.

---@class GeneratorVersion
local version = {}

---Read exactly one canonical X.X.X version before a caller opens any output file.
---@param path string Source TOC path.
---@return string value
function version.read(path)
  local file = assert(io.open(path, "rb"), "Cannot read version from " .. path)
  local value, count = nil, 0
  for line in file:lines() do
    local key, candidate = line:match("^##%s+([^:]+):%s*(.-)%s*$")
    if key and key:gsub("%s+$", ""):lower() == "version" then
      count = count + 1
      value = candidate
    end
  end
  file:close()

  local major, minor, patch
  if value then major, minor, patch = value:match("^(%d+)%.(%d+)%.(%d+)$") end
  if count ~= 1 or not major or
     (#major > 1 and major:sub(1, 1) == "0") or
     (#minor > 1 and minor:sub(1, 1) == "0") or
     (#patch > 1 and patch:sub(1, 1) == "0") then
    error(path .. " must contain exactly one ## Version: X.X.X with no leading zeros", 0)
  end
  return value
end

---Only the explicit workflow flag removes development provenance from Baked versions.
---@param sourceVersion string Validated Source TOC version.
---@param commit string Git commit, or forty zeros when unavailable.
---@param releaseFlag string? QUESTIETDB_RELEASE environment value.
---@return string value
function version.baked(sourceVersion, commit, releaseFlag)
  if releaseFlag == "true" then return sourceVersion end
  if releaseFlag ~= nil and releaseFlag ~= "" and releaseFlag ~= "false" then
    error("QUESTIETDB_RELEASE must be true or false", 0)
  end
  return sourceVersion .. "-dev." .. commit:sub(1, 7)
end

return version
