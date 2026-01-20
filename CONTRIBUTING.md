# Contributing

When contributing to this repository, please first discuss the change you wish to make via issue, email, or any other method with the owners of this repository before making a change.

Please note we have a [code of conduct](CODE_OF_CONDUCT.md), please follow it in all your interactions with the project.

## Development environment setup
1. Git clone the repository *(`git clone https://github.com/horsenuggets/discord-luau-fork.git`)*
2. Install all tools *(`rokit install`)*
3. Install all dependencies *(`wally install`)*
4. Copy `.env.template` to `.env` and fill in your bot token
5. Run tests with `lune run Scripts/RunTests.luau`

## Code Style Guide
- **Classes:** Use PascalCase for classes.
	- A class represents a structure that self regulates some sort of internal state. For instance - a DiscordGuilds state would be information surrounding the guild in question.
- **Variables:** Use camelCase for variables.
- **Constants:** Use LOUD_SNAKE_CASE for constants.
- **Types:** Use PascalCase for types.
- **Files:** Name files using camelCase.
- **Naming:** Follow semi-terse naming; identifiers should be unique and readable without being overly repetitive.
	- instead of naming files `PostgresClient.luau` and `PostgresServer.luau`, group them under a module directory called `postgres` with an `init.luau` that exports both `client.luau` and `server.luau`.
- **Modules:** Prefer grouping modules as a tree. For instance, rather than having separate files like `RobloxInputMouseHandler.luau` and `RobloxInputKeyboardHandler.luau`, structure them as `inputHandlers/roblox/mouse.luau` and `inputHandlers/roblox/keyboard.luau`.
	- another example; use `builders/X.luau` instead of `builders/XBuilder.luau`.
- **Formatting:** Adhere to a maximum line width of 100 characters and follow the default settings of stylua.
- **Variable Naming:** One-word variable names are discouraged, even in closures.
- **Comments:** This project uses Moonwave documentation - ensure your format meets the requirements for Moonwave.

## Issues and feature requests

You've found a bug in the source code, a mistake in the documentation or maybe you'd like a new feature? You can help us by [submitting an issue on GitHub](https://github.com/horsenuggets/discord-luau-fork/issues).

**Even better: Submit a pull request with a fix or new feature!**

### How to submit a Pull Request

1. Fork the project
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Write your code changes
4. Commit your changes (`git commit -m 'Add amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. [Open a Pull Request](https://github.com/horsenuggets/discord-luau-fork/compare?expand=1)
