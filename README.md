# discord-luau-fork

A Luau library for creating Discord bots, powered by Lune. Forked from [DiscordLuau/discord-luau](https://github.com/DiscordLuau/discord-luau).

## Installation

Add to your `wally.toml`:

```toml
[dependencies]
Discord = "horsenuggets/discord-luau-fork@1.0.9"
```

## Quick Start

```luau
local Discord = require("@packages/Discord")
local process = require("@lune/process")

-- Load environment variables
local Dotenv = require("@devpackages/Dotenv")
Dotenv.load()

local bot = Discord.bot.new({
    token = process.env.DISCORD_BOT_TOKEN,
    intents = 513, -- Guild, GuildMessages
})

bot:connectAsync():await()

print(`Bot connected as {bot.user.username}`)
```

## Development

1. Clone the repository
2. Copy `.env.template` to `.env` and fill in your bot token
3. Run `rokit install` to install tools
4. Run `wally install` to install dependencies
5. Run `lune run Scripts/RunTests.luau` to run tests

## Credits

This is a fork of the original [discord-luau](https://github.com/DiscordLuau/discord-luau) project. Special thanks to the original contributors.

## License

MIT
