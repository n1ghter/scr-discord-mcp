# Star Citizen Ru — Discord MCP

Приватный набор, чтобы свой AI читал сервер Star Citizen Ru так же, как Grok у n1ghter. Два локальных MCP, один бот, только REST.

Токена в этом репозитории нет и не должно появиться.

## Что внутри

| Путь | Что это |
|---|---|
| `discord-embeds/` | Локальный форк [glittercowboy/discord-mcp](https://github.com/glittercowboy/discord-mcp) (MIT). Читает эмбеды. Официальный `uvx` сейчас не ставится: нужен этот форк и `mcp<2`. |
| `config.example.toml` | Кусок конфига для Grok или Codex. |
| `PROMPT.md` | Промпт для AI: каналы, модель правил, чего не делать. |

Второй сервер, `discord-mcp`, ставится с npm: `@discord-mcp/cli@0.23.0`. Его код здесь не лежит.

## Что нужно заранее

- Node 22+
- Python 3.12+
- [uv](https://docs.astral.sh/uv/)
- Доступ в Discord Developer Portal к приложению бота **Star Citizen Ru AI** (n1ghter добавляет в Team). Токен снимаешь там сам: Bot → Reset Token. В чат и в git не клади.

Бот уже на сервере. Второй раз приглашать не надо. Gateway не включай: два клиента с одним токеном живут только на REST.

## Установка

1. Склонируй репозиторий, запомни полный путь к `discord-embeds`.
2. Токен в переменную пользователя, не в файл:

   Windows PowerShell:

   ```powershell
   [Environment]::SetEnvironmentVariable("DISCORD_BOT_TOKEN", "токен-из-портала", "User")
   ```

   Перезапусти терминал и AI, чтобы переменная подхватилась.

3. Вставь `config.example.toml` в конфиг AI. В `args` замени `ПУТЬ/scr-discord-mcp/discord-embeds` на свой путь. Для Grok это `~\.grok\config.toml`. Для Codex — его `config.toml` с теми же секциями `[mcp_servers.*]`.
4. Перезапусти AI. В списке MCP должны быть `discord-mcp` и `discord-embeds`.
5. Первым сообщением или системным промптом отдай текст из `PROMPT.md`.

Запись в Discord остаётся в `preview`. Живой канал правил не патчить.

## Проверка

Попроси AI прочитать одно сообщение клона правил `1551138561024196679` через discord-embeds. Если `content` пустой, а карточки есть — так и должно быть: текст сидит в эмбедах.
