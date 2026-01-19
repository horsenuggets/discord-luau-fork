# Changelog

## 1.0.6
- Fixed init.luau relative paths (reverted incorrect ./ to ../ for subdirectory modules)

## 1.0.5
- Updated luau-futures dependency to use forked version with proper Wally packaging
- Fixed init.luau relative paths for proper module resolution

## 1.0.4
- Fixed Wally package compatibility by converting internal @discordluau aliases to relative paths
- Fixed CI workflows to use luau-cicd submodule scripts
- Fixed .luaurc to use correct Lune typedefs path for horse fork
- Added Roblox globals (game, workspace) to .luaurc for static analysis
- Temporarily disabled tests pending migration from frktest to Testable

## 1.0.3
- Fixed CI workflows to use luau-cicd submodule scripts
- Added version-match check to release workflow

## 1.0.2
- Fixed Wally auth configuration format

## 1.0.1
- Added Wally package publishing to release workflow
- Fixed submodule checkout in publish workflow

## 1.0.0
- Initial release based on DiscordLuau/discord-luau fork
- Restructured to use PascalCase directory naming
- Consolidated packages under Source/DiscordLuau
- Added CI/CD workflows for automated testing and releases
- Added Wally package publishing support
