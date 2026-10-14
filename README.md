# Star Citizen Ru — Discord MCP

A local setup so an AI can read the Star Citizen Ru Discord the same way Grok does. Two MCP servers, one bot, REST only.

## What is here

| Path | What it is |
|---|---|
| `discord-embeds/` | Local fork of [glittercowboy/discord-mcp](https://github.com/glittercowboy/discord-mcp) (MIT). Reads message embeds. The upstream `uvx` install is currently broken; use this fork and pin `mcp<2`. Its own `README.md` is the upstream manual (kick, ban, full admin). Ignore it. Install from this page. |
| `config.example.toml` | Config snippet for Grok or Codex. |
| `PROMPT.md` | Prompt for the AI: channels, the rules model, and what not to do. |
| `skills/discord-audit/SKILL.md` | Router: cappyeo for structure and plain text, glittercowboy for embed cards. |

The other server, `discord-mcp`, is installed from npm: `@discord-mcp/cli@0.23.0`. Its source is not in this repo.

## Before you start

- Node 22+
- Python 3.12+
- [uv](https://docs.astral.sh/uv/)
- The bot token from n1ghter, in a direct message. Do not click Reset Token. That kills the token he is already using. Do not paste it into chat or git.

The bot is already on the server. Do not invite it again. Do not enable the Gateway: two clients can share one token only over REST.

## Install

1. Clone the repo and note the full path to `discord-embeds`.
2. Store the token in a user environment variable, not in a file:

   Windows PowerShell:

   ```powershell
   [Environment]::SetEnvironmentVariable("DISCORD_BOT_TOKEN", "token-from-the-portal", "User")
   ```

   Restart the terminal and the AI so the variable is picked up.

3. Paste `config.example.toml` into the AI config. In `args`, replace `PATH/scr-discord-mcp/discord-embeds` with your path. For Grok that file is `~\.grok\config.toml`. For Codex, use the same `[mcp_servers.*]` sections in its `config.toml`.
4. Restart the AI. The MCP list should show `discord-mcp` and `discord-embeds`.
5. Give the AI the text in `PROMPT.md` as the system prompt or as the first message.
6. If the AI loads skills from disk (Grok), copy `skills/discord-audit` to `~\.grok\skills\discord-audit`. That file is the router between the two MCP servers. Codex and others should be told to follow `skills/discord-audit/SKILL.md`.

Discord writes stay in `preview`. Do not patch the live rules channel.

## Claude Desktop and Claude Code (Windows)

`scripts/windows/discord-mcp.cmd` and `scripts/windows/discord-embeds.cmd` start the two servers with the same settings as `config.example.toml`. They read `DISCORD_BOT_TOKEN` from the user environment, so no token goes into any config file.

1. Add both to `%APPDATA%\Claude\claude_desktop_config.json` (Claude Desktop) and to the top-level `mcpServers` of `%USERPROFILE%\.claude.json` (Claude Code, add `"type": "stdio"`):

   ```json
   "mcpServers": {
     "discord-mcp": { "command": "cmd", "args": ["/c", "C:\\path\\to\\scr-discord-mcp\\scripts\\windows\\discord-mcp.cmd"] },
     "discord-embeds": { "command": "cmd", "args": ["/c", "C:\\path\\to\\scr-discord-mcp\\scripts\\windows\\discord-embeds.cmd"] }
   }
   ```

2. Block cappyeo writes in Claude Code with `permissions.deny` in `%USERPROFILE%\.claude\settings.json`: `mcp__discord-mcp__mcp_tools_write`, `mcp__discord-mcp__mcp_tools_destructive`, `mcp__discord-mcp__build_discord_server`, `mcp__discord-mcp__guild_blueprint_apply`.
3. Quit Claude Desktop from the tray icon and start it again. Closing the window is not enough.

`discord-embeds` is read-only in this fork: `discord_execute` runs only the operations in `DISCORD_ALLOWED_OPERATIONS` (default: `messages.list`, `messages.get`, `messages.list_pins`, `channels.list`, `channels.get`, `roles.list`, `roles.get`, `guild.get`, `members.get`, `members.search`, `audit_log.list`, `onboarding.get`). `messages.list` also accepts `before`, `after` or `around` for paging.

## Check

Ask the AI to read one message from the rules clone `1551138561024196679` through discord-embeds. An empty `content` with cards present is expected: the text lives in the embeds.
