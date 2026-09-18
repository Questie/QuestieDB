-- Version semantics live beside the Python integration driver, not inside Python strings.
-- Run from its disposable fixture root, passing a scratch path that does not exist.
local lib = dofile("generator/lib.lua")
local version = dofile("generator/version.lua")
local path = assert(arg[1], "version.test.lua requires a nonexisting scratch-file path")
assert(not lib.fileExists(path), "refusing to overwrite an existing version-test fixture: " .. path)

-- Reading a version must preserve authored bytes, including rejected input.
for _, value in ipairs({ "0.0.0", "0.1.0", "12.34.567" }) do
  lib.writeAll(path, "## Version: " .. value .. "\r\n")
  assert(version.read(path) == value)
end
for _, content in ipairs({
  "## Title: No version\n",
  "## Version: 1.2.3\n## Version: 1.2.3\n",
  "## Version: 1.2.3\n## version: 4.5.6\n",
  "## Version: 01.2.3\n", "## Version: 1.02.3\n", "## Version: 1.2.03\n",
  "## Version: 1.2\n", "## Version: v1.2.3\n", "## Version: 1.2.3-beta\n", "## Version: \n",
}) do
  lib.writeAll(path, content)
  assert(not pcall(version.read, path), "accepted malformed version: " .. content)
  assert(lib.readAll(path) == content, "validation altered the TOC")
end
assert(os.remove(path))
assert(not pcall(version.read, path), "missing TOC invented a version")

-- Only the explicit release flag removes development provenance.
local commit = "1234567" .. string.rep("a", 33)
assert(version.baked("1.2.3", commit, "true") == "1.2.3")
assert(version.baked("1.2.3", commit) == "1.2.3-dev.1234567")
for _, flag in ipairs({ "", "false" }) do
  assert(version.baked("1.2.3", commit, flag) == "1.2.3-dev.1234567")
end
assert(version.baked("1.2.3", string.rep("0", 40)) == "1.2.3-dev.0000000")
for _, flag in ipairs({ "TRUE", "1", "yes", " false " }) do
  assert(not pcall(version.baked, "1.2.3", commit, flag), "accepted invalid release flag")
end
