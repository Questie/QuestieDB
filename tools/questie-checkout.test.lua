-- Offline integration tests using real Git and a local upstream repository.
-- Run from the repository root: lua5.1 tools/questie-checkout.test.lua

local lib = dofile("generator/lib.lua")

---@param value string
---@return string
local function quote(value)
  return "'" .. value:gsub("'", "'\\''") .. "'"
end

---@param command string
---@return boolean
local function succeeds(command)
  local status = os.execute(command)
  return status == 0 or status == true
end

---@param command string
---@return nil
local function run(command)
  assert(succeeds(command), command)
end

---@param command string
---@return string
local function output(command)
  local pipe = assert(io.popen(command, "r"))
  local value = pipe:read("*a"):gsub("%s+$", "")
  pipe:close()
  return value
end

local root = output("mktemp -d /tmp/questietdb-checkout-XXXXXX")
assert(root:match("^/tmp/questietdb%-checkout%-%w+$"))
local repo = output("pwd -P")
-- Spaces and quotes exercise every shell boundary, not only Git's -C argument.
local sandbox = root .. "/work tree's inputs"
local upstream = root .. "/upstream"
local config = root .. "/gitconfig"
local lua = quote(arg[-1] or "lua5.1")
local env = "env -u QUESTIE_PATH GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_COUNT=0 " ..
  "GIT_CONFIG_GLOBAL=" .. quote(config) .. " GIT_ALLOW_PROTOCOL=file "

---@param code string
---@param extraEnv string?
---@return boolean
local function resolve(code, extraEnv)
  return succeeds("cd " .. quote(sandbox) .. " && " .. env .. (extraEnv or "") ..
    lua .. " -e " .. quote(code) .. " > " .. quote(root .. "/resolve.log") .. " 2>&1")
end

local ok, err = pcall(function()
  run("mkdir -p " .. quote(sandbox) .. " " .. quote(upstream .. "/Database") .. " " ..
    quote(upstream .. "/Localization/lookups") .. " " .. quote(upstream .. "/Textures"))
  lib.writeAll(config, "")
  local git = env .. "git -C " .. quote(upstream) .. " "
  run(git .. "init --quiet")
  run(git .. "config user.name Fixture")
  run(git .. "config user.email fixture@example.invalid")
  run(git .. "config commit.gpgsign false")
  lib.writeAll(upstream .. "/Database/questDB.lua", "schema fixture\n")
  lib.writeAll(upstream .. "/Localization/lookups/lookupOverrides.lua", "lookup fixture\n")
  lib.writeAll(upstream .. "/Textures/texture.txt", "Full snapshot fixture.\n")
  local lookupDir = upstream .. "/Localization/lookups/Classic/lookupObjects"
  run("mkdir -p " .. quote(lookupDir))
  for _, locale in ipairs(dofile("src/config.lua").locales) do
    lib.writeAll(lookupDir .. "/" .. locale .. ".lua",
      "QuestieLoader:ImportModule('l10n').objectLookup[GetLocale()] = { [31] = 'Fixture translation' }\n")
  end
  run(git .. "add . && " .. git .. "commit --quiet -m first")
  local first = lib.gitCommit(upstream)
  lib.writeAll(upstream .. "/Database/questDB.lua", "pinned schema\n")
  run(git .. "commit --quiet -am pinned")
  local pinned = lib.gitCommit(upstream)
  lib.writeAll(upstream .. "/Database/questDB.lua", "newer, unreviewed schema\n")
  run(git .. "commit --quiet -am latest && " .. git .. "tag latest")
  local latest = lib.gitCommit(upstream)
  run(env .. "git config --file " .. quote(config) .. " " ..
    quote("url.file://" .. upstream .. ".insteadOf") .. " https://github.com/Questie/Questie.git")

  for _, path in ipairs({ "generator", "src", "data", "support", "generate.lua" }) do
    run("ln -s " .. quote(repo .. "/" .. path) .. " " .. quote(sandbox .. "/" .. path))
  end
  lib.writeAll(sandbox .. "/QUESTIE_COMMIT", pinned .. "\n")
  lib.writeAll(sandbox .. "/QuestieTDB.toc", "base canary")
  lib.writeAll(sandbox .. "/QuestieTDB_Vanilla.toc", "baked canary")

  -- The real driver must bootstrap before localization preflight, without opening output.
  assert(not succeeds("cd " .. quote(sandbox) .. " && " .. env .. lua ..
    " generate.lua Vanilla --types=Quest > " .. quote(root .. "/driver.log") .. " 2>&1"))
  assert(lib.readAll(root .. "/driver.log"):find("required Questie lookup files are missing", 1, true))
  assert(lib.readAll(sandbox .. "/QuestieTDB.toc") == "base canary")
  assert(lib.readAll(sandbox .. "/QuestieTDB_Vanilla.toc") == "baked canary")

  local cached = sandbox .. "/.cache/questie/" .. pinned
  assert(lib.gitCommit(cached) == pinned, "must fetch the pin, not the remote tip")
  local cachedGit = env .. "git -C " .. quote(cached) .. " "
  assert(output(cachedGit .. "rev-list --count HEAD") == "1", "history must have depth 1")
  assert(output(cachedGit .. "tag --list") == "", "no tags")
  assert(output(cachedGit .. "branch -r") == "", "no remote branch tips")
  assert(lib.readAll(cached .. "/Database/questDB.lua") == "pinned schema\n")
  assert(lib.fileExists(cached .. "/Localization/lookups/lookupOverrides.lua"))
  assert(lib.readAll(cached .. "/Textures/texture.txt") == "Full snapshot fixture.\n",
    "the checkout includes files outside the generator's inputs")

  run("cd " .. quote(sandbox) .. " && " .. env .. lua ..
    " generate.lua Vanilla --types=Object --no-base-toc --quiet")
  local artifact = lib.readAll(sandbox .. "/QuestieTDB_Vanilla.toc")
  assert(artifact:find("## X-QUESTIE-COMMIT: " .. pinned, 1, true), "provenance must use the fetched pin")
  assert(artifact:find("## X-l10n-deDE-Object:", 1, true), "the resolved checkout must supply translations")
  assert(lib.readAll(sandbox .. "/QuestieTDB.toc") == "base canary")

  local call = "local path, commit = dofile('generator/questie.lua').resolve(); " ..
    "assert(commit == dofile('generator/lib.lua').readQuestiePin()); assert(path:find(commit, 1, true))"
  run("mv " .. quote(upstream) .. " " .. quote(upstream .. ".offline"))
  assert(resolve(call), "cached use must not contact the remote")

  -- A missing remote must leave no published or temporary checkout; retry then succeeds.
  lib.writeAll(sandbox .. "/QUESTIE_COMMIT", first .. "\n")
  assert(not resolve(call), "uncached pin cannot succeed offline")
  assert(not lib.fileExists(sandbox .. "/.cache/questie/" .. first))
  assert(output("ls -A " .. quote(sandbox .. "/.cache/questie")) == pinned, "failed staging is cleaned")
  run("mv " .. quote(upstream .. ".offline") .. " " .. quote(upstream))
  assert(resolve(call), lib.readAll(root .. "/resolve.log"))
  assert(lib.gitCommit(cached) == pinned, "advancing or reverting pins never resets another cache entry")

  -- Explicit paths, including the environment override, retain the strict pin check.
  lib.writeAll(sandbox .. "/QUESTIE_COMMIT", pinned .. "\n")
  assert(not resolve("dofile('generator/questie.lua').resolve()", "QUESTIE_PATH=" .. quote(upstream) .. " "))
  assert(lib.gitCommit(upstream) == latest, "never switch the user's checkout")
  assert(resolve("local p = " .. string.format("%q", cached) ..
    "; assert(dofile('generator/questie.lua').resolve(p) == p)", "QUESTIE_PATH=" .. quote(upstream) .. " "))
  assert(resolve("assert(dofile('generator/questie.lua').resolve() == os.getenv('QUESTIE_PATH'))",
    "QUESTIE_PATH=" .. quote(cached) .. " "))

  -- Modes that do not read Questie must not need a valid pin or network access.
  lib.writeAll(sandbox .. "/QUESTIE_COMMIT", "not-a-sha\n")
  assert(not resolve(call))
  assert(lib.readAll(root .. "/resolve.log"):find("40-character Git SHA", 1, true))
  run("cd " .. quote(sandbox) .. " && " .. env .. lua .. " generate.lua toc --quiet")
  run("cd " .. quote(sandbox) .. " && " .. env .. lua ..
    " generate.lua Vanilla --types=Object --no-l10n --no-base-toc --quiet")
  assert(lib.readAll(sandbox .. "/QuestieTDB_Vanilla.toc"):find("## X-QUESTIE-COMMIT: " .. string.rep("0", 40), 1, true))
end)

run("rm -rf -- " .. quote(root))
if not ok then error(err, 0) end
print("Questie checkout integration tests passed")
