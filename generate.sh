#!/usr/bin/env bash
# Lua-only Generation: Git Bash uses Windows Lua, Linux x64 uses static musl Lua,
# and macOS uses an installed Lua 5.1-compatible interpreter.
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
cd -- "$root"
system=$(uname -s)
lua=${LUA:-}

if [[ -z "$lua" ]]; then
  case "$system" in
    MINGW*|MSYS*|CYGWIN*) lua="$root/tools/lua-binary/lua.exe" ;;
    Linux)
      case "$(uname -m)" in
        x86_64|amd64) lua="$root/tools/lua-binary/linux-x64/lua" ;;
        *) echo 'No bundled Lua for this Linux architecture. Set LUA to an installed Lua 5.1 interpreter.' >&2; exit 2 ;;
      esac
      ;;
    Darwin)
      for candidate in lua5.1 lua luajit; do
        if executable=$(command -v "$candidate") &&
           version=$("$executable" -e 'io.write(_VERSION)' 2>/dev/null) &&
           [[ "$version" == 'Lua 5.1' ]]; then
          lua=$executable
          break
        fi
      done
      if [[ -z "$lua" ]]; then
        echo 'Lua 5.1 is required on macOS. Install it (for example: brew install luajit), or set LUA=/path/to/lua5.1.' >&2
        exit 2
      fi
      ;;
    *) echo "Unsupported platform: $system. Set LUA to an installed Lua 5.1 interpreter." >&2; exit 2 ;;
  esac
fi

# Resolve overrides relative to the checkout. Git Bash needs a POSIX execution path,
# while nested native Windows Lua processes need a Windows path in their LUA variable.
case "$system" in
  MINGW*|MSYS*|CYGWIN*) lua=$(cygpath -u "$lua") ;;
esac
if ! lua=$(command -v "$lua") || [[ ! -x "$lua" ]]; then
  echo 'Lua executable not found. Restore the bundled binary or set LUA to an installed Lua 5.1 interpreter.' >&2
  exit 2
fi
lua_dir=$(CDPATH= cd -- "$(dirname -- "$lua")" && pwd -P)
lua="$lua_dir/${lua##*/}"
if ! version=$("$lua" -e 'io.write(_VERSION)' 2>/dev/null) || [[ "$version" != 'Lua 5.1' ]]; then
  echo "Could not run a Lua 5.1 interpreter at: $lua" >&2
  exit 2
fi
case "$system" in
  MINGW*|MSYS*|CYGWIN*) LUA=$(cygpath -w "$lua") ;;
  *) LUA=$lua ;;
esac
export LUA
exec "$lua" generate.lua "$@"
