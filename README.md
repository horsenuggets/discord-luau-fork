# discord-luau-fork

A Luau library for creating Discord bots, powered by Lune.

[![Documentation](https://img.shields.io/badge/docs-horsenuggets.github.io-blue)](https://horsenuggets.github.io/discord-luau-fork/)
[![Wally](https://img.shields.io/badge/wally-horsenuggets%2Fdiscord--luau--fork-brightgreen)](https://wally.run/package/horsenuggets/discord-luau-fork)

## Documentation

Full API documentation is available at **[horsenuggets.github.io/discord-luau-fork](https://horsenuggets.github.io/discord-luau-fork/)**.

## Installation

Add to your `wally.toml`:

```toml
[dependencies]
Discord = "horsenuggets/discord-luau-fork@1.0.11"
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

## Features

- Full Discord Gateway support with automatic reconnection
- REST API client for all Discord endpoints
- Slash commands and interactions
- Message components (buttons, select menus, modals)
- **Lavalink audio support** for voice functionality

## Lavalink Audio

This fork includes built-in Lavalink support for Discord voice functionality:

```luau
local Discord = require("@packages/Discord")
local Lavalink = Discord.Lavalink

local bot = Discord.bot.new({ ... })
local lavalink = Lavalink.new(bot)

-- Add a Lavalink node
lavalink:AddNode({
    name = "main",
    host = "localhost",
    port = 2333,
    password = "youshallnotpass",
})

-- Get a player for a guild and play music
local player = lavalink:GetPlayer(guildId)
player:Connect(voiceChannelId)

local result = lavalink:Search("never gonna give you up")
if result.loadType == "search" then
    player:Play(result.data[1])
end
```

**Note:** Lavalink WebSocket connections require a Lune build with WebSocket headers support.

## Development

1. Clone the repository
2. Copy `.env.template` to `.env` and fill in your bot token
3. Run `rokit install` to install tools
4. Run `wally install` to install dependencies
5. Run `lune run Scripts/RunTests.luau` to run tests

## Credits

This is a fork of the original [discord-luau](https://github.com/DiscordLuau/discord-luau) project by [4x8Matrix](https://github.com/4x8Matrix). Special thanks to the original contributors.

## License

MIT
