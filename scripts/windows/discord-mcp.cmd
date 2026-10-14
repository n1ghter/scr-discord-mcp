@echo off
setlocal
rem Starts the cappyeo Discord MCP server (@discord-mcp/cli) over stdio.
rem The bot token is read from the DISCORD_BOT_TOKEN user environment variable and is never stored here.
rem Nothing may be printed to stdout before the server starts: stdout is the MCP channel.
if not defined DISCORD_BOT_TOKEN (
  for /f "usebackq delims=" %%T in (`powershell -NoProfile -NonInteractive -Command "[Environment]::GetEnvironmentVariable('DISCORD_BOT_TOKEN','User')"`) do set "DISCORD_BOT_TOKEN=%%T"
)
if not defined DISCORD_BOT_TOKEN (
  echo DISCORD_BOT_TOKEN is not set for this Windows user. 1>&2
  exit /b 1
)
set "DISCORD_TOKEN=%DISCORD_BOT_TOKEN%"
set "ALLOWED_GUILDS=93088419634216960"
set "DISCORD_DEFAULT_GUILD_ID=93088419634216960"
set "MCP_TOOL_SURFACE=progressive"
set "MCP_WRITE_MODE=preview"
set "MCP_CATEGORIES=messages,channels,threads,members,roles,permissions,guild,audit_log,invites,onboarding,users"
npx -y @discord-mcp/cli@0.23.0 serve
