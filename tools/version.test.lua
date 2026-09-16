#!/usr/bin/env lua
-- tools/version.test.lua
--
-- Version validation and real TOC Generation in an isolated directory. No network calls or
-- writes to the checkout's Source/Baked TOCs.
-- Usage: lua5.1 tools/version.test.lua

local lib = dofile("generator/lib.lua")
local version = dofile("generator/version.lua")
local checks = 0

---@param condition boolean
---@param message string
---@return nil
local function check(condition, message)
  checks = checks + 1
  assert(condition, message)
end

---@param value string
---@return string quoted
local function shellQuote(value)
  return "'" .. value:gsub("'", "'\\''") .. "'"
end

---@param command string
---@return boolean succeeded
local function run(command)
  local status = os.execute(command)
  return status == 0 or status == true
end

local pwd = assert(io.popen("pwd", "r"))
local repo = pwd:read("*l")
pwd:close()
local root = os.tmpname()
os.remove(root)
assert(run("mkdir -p " .. shellQuote(root .. "/bin")))
local sourcePath = root .. "/QuestieDB.toc"

---@return nil
local function testVersions()
  for _, value in ipairs({ "0.0.0", "0.1.0", "12.34.567" }) do
    lib.writeAll(sourcePath, "## Version: " .. value .. "\r\n")
    check(version.read(sourcePath) == value, "reads canonical version " .. value)
  end
  for _, content in ipairs({
    "## Title: No version\n",
    "## Version: 1.2.3\n## Version: 1.2.3\n",
    "## Version: 1.2.3\n## version: 4.5.6\n",
    "## Version: 01.2.3\n",
    "## Version: 1.02.3\n",
    "## Version: 1.2.03\n",
    "## Version: 1.2\n",
    "## Version: v1.2.3\n",
    "## Version: 1.2.3-beta\n",
    "## Version: \n",
  }) do
    lib.writeAll(sourcePath, content)
    check(not pcall(version.read, sourcePath), "rejects malformed or ambiguous version")
    check(lib.readAll(sourcePath) == content, "validation does not alter the TOC")
  end
  os.remove(sourcePath)
  check(not pcall(version.read, sourcePath), "missing Source TOC cannot invent a version")

  local commit = "1234567" .. string.rep("a", 33)
  check(version.baked("1.2.3", commit, "true") == "1.2.3", "full release version")
  for _, flag in ipairs({ "", "false" }) do
    check(version.baked("1.2.3", commit, flag) == "1.2.3-dev.1234567", "development flag")
  end
  check(version.baked("1.2.3", commit) == "1.2.3-dev.1234567", "default development version")
  check(version.baked("1.2.3", string.rep("0", 40)) == "1.2.3-dev.0000000",
    "unavailable Git preserves a recognizable development version")
  for _, flag in ipairs({ "TRUE", "1", "yes", " false " }) do
    check(not pcall(version.baked, "1.2.3", commit, flag), "rejects invalid release flag")
  end

  -- Only Git provenance is substituted. The generator, file lists, entity inputs and output
  -- writer are real; every path that can be written belongs to the temporary directory.
  for _, path in ipairs({ "generator", "src", "data", "support" }) do
    assert(run("ln -s " .. shellQuote(repo .. "/" .. path) .. " " .. shellQuote(root .. "/" .. path)))
  end
  lib.writeAll(root .. "/bin/git", "#!/bin/sh\n" ..
    "[ \"$*\" = 'rev-parse HEAD' ] || exit 7\n" ..
    "printf '%s\\n' '" .. commit .. "'\n")
  assert(run("chmod +x " .. shellQuote(root .. "/bin/git")))

  ---@param arguments string
  ---@param releaseFlag string
  ---@return boolean succeeded
  local function generate(arguments, releaseFlag)
    return run("cd " .. shellQuote(root) .. " && env QUESTIE_PATH= QUESTIEDB_RELEASE=" ..
      shellQuote(releaseFlag) .. " PATH=" .. shellQuote(root .. "/bin") .. ":\"$PATH\" " ..
      shellQuote(os.getenv("LUA") or "lua5.1") .. " " .. shellQuote(repo .. "/generate.lua") ..
      " " .. arguments .. " > " .. shellQuote(root .. "/output.log") .. " 2>&1")
  end

  lib.writeAll(sourcePath, "## Version: 12.34.567\n")
  check(generate("toc --quiet", "false"), "Source TOC Generation: " .. lib.readAll(root .. "/output.log"))
  check(version.read(sourcePath) == "12.34.567", "Source TOC Generation preserves maintained version")
  local source = lib.readAll(sourcePath)
  check(generate("toc --quiet", "true"), "Source TOC Generation in full-release mode")
  check(lib.readAll(sourcePath) == source, "release mode does not change the Source TOC")

  local arguments = "Vanilla --no-l10n --no-base-toc --types=Quest --fields=name --quiet"
  local bakedPath = root .. "/QuestieDB_Vanilla.toc"
  check(generate(arguments, "false"), "development Generation: " .. lib.readAll(root .. "/output.log"))
  check(lib.readAll(bakedPath):find("## Version: 12.34.567-dev.1234567\n", 1, true) ~= nil,
    "real Baked header includes source version and commit")
  check(generate(arguments, "true"), "full-release Generation: " .. lib.readAll(root .. "/output.log"))
  check(lib.readAll(bakedPath):find("## Version: 12.34.567\n", 1, true) ~= nil,
    "real Baked header uses exact release version")
  check(lib.readAll(sourcePath) == source, "parallel-safe Generation leaves Source TOC unchanged")

  local baked = lib.readAll(bakedPath)
  check(not generate(arguments, "yes"), "invalid release flag fails before artifact Generation")
  check(lib.readAll(bakedPath) == baked, "invalid flag preserves existing Baked output")
  lib.writeAll(sourcePath, "## Version: invalid\n")
  check(not generate("toc --quiet", "false"), "invalid Source version prevents TOC regeneration")
  check(lib.readAll(sourcePath) == "## Version: invalid\n", "invalid Source TOC is not truncated")
  check(not generate(arguments, "false"), "invalid Source version prevents Baked Generation")
  check(lib.readAll(bakedPath) == baked, "invalid Source version preserves existing Baked output")
end

local ok, err = pcall(testVersions)
assert(run("rm -rf " .. shellQuote(root)))
if not ok then error(err, 0) end
print("PASS version: " .. checks .. " checks")
