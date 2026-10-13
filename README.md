# Star Citizen Ru — Discord MCP

A local setup so an AI can read the Star Citizen Ru Discord the same way Grok does. Two MCP servers, one bot, REST only.

This repository does not contain a bot token, and one should never be committed.

## What is here

| Path | What it is |
|---|---|
| `discord-embeds/` | Local fork of [glittercowboy/discord-mcp](https://github.com/glittercowboy/discord-mcp) (MIT). Reads message embeds. The upstream `uvx` install is currently broken; use this fork and pin `mcp<2`. |
| `config.example.toml` | Config snippet for Grok or Codex. |
| `PROMPT.md` | Prompt for the AI: channels, the rules model, and what not to do. |

The other server, `discord-mcp`, is installed from npm: `@discord-mcp/cli@0.23.0`. Its source is not in this repo.

## Before you start

- Node 22+
- Python 3.12+
- [uv](https://docs.astral.sh/uv/)
- Access to the **Star Citizen Ru AI** application in the Discord Developer Portal (ask n1ghter to add you to the team). Copy the token yourself: Bot → Reset Token. Do not paste it into chat or git.

The bot is already on the server. Do not invite it again. Do not enable the Gateway: two clients can share one token only over REST.

## Install

1. Clone the repo and note the full path to `discord-embeds`.
2. Store the token in a user environment variable, not in a file:

   Windows PowerShell:

   ```powershell
   [Environment]::SetEnvironmentVariable("DISCORD_BOT_TOKEN", "token-from-the-portal", "User")
   ```

   Restart the terminal and the AI so the variable is picked up.

3. Paste `config.example.toml` into the AI config. In `args`, replace `ПУТЬ/scr-discord-mcp/discord-embeds` with your path. For Grok that file is `~\.grok\config.toml`. For Codex, use the same `[mcp_servers.*]` sections in its `config.toml`.
4. Restart the AI. The MCP list should show `discord-mcp` and `discord-embeds`.
5. Give the AI the text in `PROMPT.md` as the system prompt or as the first message.

Discord writes stay in `preview`. Do not patch the live rules channel.

## Check

Ask the AI to read one message from the rules clone `1551138561024196679` through discord-embeds. An empty `content` with cards present is expected: the text lives in the embeds.
