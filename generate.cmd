@echo off
setlocal
rem Run from the checkout, including paths opened through a Windows network share.
pushd "%~dp0" || exit /b 1
if not defined LUA set "LUA=%~dp0tools\lua-binary\lua.exe"
"%LUA%" generate.lua %*
set "result=%ERRORLEVEL%"
popd
rem Double-clicking passes no arguments; keep results visible before closing.
if "%~1"=="" pause
exit /b %result%
