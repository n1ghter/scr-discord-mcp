@echo off
setlocal
rem Starts the local glittercowboy fork (discord-embeds) over stdio.
rem The bot token is read from the DISCORD_BOT_TOKEN user environment variable and is never stored here.
rem The server is read-only unless DISCORD_ALLOWED_OPERATIONS widens it (see discord-embeds/src/server.py).
if not defined DISCORD_BOT_TOKEN (
  for /f "usebackq delims=" %%T in (`powershell -NoProfile -NonInteractive -Command "[Environment]::GetEnvironmentVariable('DISCORD_BOT_TOKEN','User')"`) do set "DISCORD_BOT_TOKEN=%%T"
)
if not defined DISCORD_BOT_TOKEN (
  echo DISCORD_BOT_TOKEN is not set for this Windows user. 1>&2
  exit /b 1
)
set "DISCORD_GUILD_ID=93088419634216960"
set "PYTHONUTF8=1"
set "UV_EXE=uv"
if exist "%USERPROFILE%\.local\bin\uv.exe" set "UV_EXE=%USERPROFILE%\.local\bin\uv.exe"
"%UV_EXE%" --quiet --directory "%~dp0..\..\discord-embeds" run python -m src.server
