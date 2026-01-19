--[[

ConvertAliasesToRelative

Converts @discordluau/ alias requires to relative paths for Wally compatibility.

--]]

local fs = require("@lune/fs")
local process = require("@lune/process")

local SOURCE_DIR = "Source/DiscordLuau"

local function getRelativePath(fromFile: string, toModule: string): string
    -- fromFile: Source/DiscordLuau/Bot.luau
    -- toModule: ApiTypes (from @discordluau/ApiTypes)

    local fromDir = fromFile:match("(.+)/[^/]+%.luau$")
    if not fromDir then
        return "./" .. toModule
    end

    local fileName = fromFile:match("([^/]+)%.luau$")
    local isInitFile = fileName == "init"

    -- Count how many directories deep from SOURCE_DIR
    local fromRelative = fromDir:gsub("^" .. SOURCE_DIR .. "/?", "")
    local depth = 0
    for _ in fromRelative:gmatch("/") do
        depth += 1
    end
    if fromRelative ~= "" then
        depth += 1
    end

    -- For init.luau files, ./ resolves to the parent directory (where module is imported from)
    -- So we need one less level of ../ compared to regular files
    if isInitFile and depth > 0 then
        depth -= 1
    end

    if depth == 0 then
        return "./" .. toModule
    else
        local prefix = string.rep("../", depth)
        return prefix .. toModule
    end
end

local function processFile(filePath: string)
    local content = fs.readFile(filePath)
    local modified = false

    local newContent = content:gsub('require%("@discordluau/([^"]+)"%)', function(module)
        modified = true
        local relativePath = getRelativePath(filePath, module)
        return `require("{relativePath}")`
    end)

    if modified then
        fs.writeFile(filePath, newContent)
        print(`Updated {filePath}`)
    end
end

local function processDirectory(dirPath: string)
    for _, entry in fs.readDir(dirPath) do
        local fullPath = `{dirPath}/{entry}`
        if fs.isDir(fullPath) then
            processDirectory(fullPath)
        elseif entry:match("%.luau$") then
            processFile(fullPath)
        end
    end
end

local function convertAliasesToRelative()
    print("Converting @discordluau aliases to relative paths...")
    processDirectory(SOURCE_DIR)
    print("Done!")
end

convertAliasesToRelative()
