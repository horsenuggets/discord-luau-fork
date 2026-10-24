#!/usr/bin/env -S lune run

--[[

ConvertAliasesToRelative.exec

Converts @discordluau/ alias requires to relative paths for Wally compatibility.

[Usage] ./Scripts/ConvertAliasesToRelative.exec.luau

--]]

const fs = require("@lune/fs")

const SOURCE_DIR = "Source/DiscordLuau"

const function getRelativePath(fromFile: string, toModule: string): string
    -- fromFile: Source/DiscordLuau/Bot.luau
    -- toModule: ApiTypes (from @discordluau/ApiTypes)

    const fromDir = fromFile:match("(.+)/[^/]+%.luau$")
    if not fromDir then
        return "./" .. toModule
    end

    -- Count how many directories deep from SOURCE_DIR
    const fromRelative = fromDir:gsub("^" .. SOURCE_DIR .. "/?", "")
    local depth = 0
    for _ in fromRelative:gmatch("/") do
        depth += 1
    end
    if fromRelative ~= "" then
        depth += 1
    end

    if depth == 0 then
        return "./" .. toModule
    else
        const prefix = string.rep("../", depth)
        return prefix .. toModule
    end
end

const function processFile(filePath: string)
    const content = fs.readFile(filePath)
    local modified = false

    const newContent = content:gsub('require%("@discordluau/([^"]+)"%)', function(module)
        modified = true
        const relativePath = getRelativePath(filePath, module)
        return `require("{relativePath}")`
    end)

    if modified then
        fs.writeFile(filePath, newContent)
        print(`Updated {filePath}`)
    end
end

const function processDirectory(dirPath: string)
    for _, entry in fs.readDir(dirPath) do
        const fullPath = `{dirPath}/{entry}`
        if fs.isDir(fullPath) then
            processDirectory(fullPath)
        elseif entry:match("%.luau$") then
            processFile(fullPath)
        end
    end
end

const ConvertAliasesToRelative = {}

function ConvertAliasesToRelative.exec()
    print("Converting @discordluau aliases to relative paths...")
    processDirectory(SOURCE_DIR)
    print("Done!")
end

ConvertAliasesToRelative.exec()
