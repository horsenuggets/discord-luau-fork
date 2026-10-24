#!/usr/bin/env -S lune run

--[[

CountAliases.exec

Prints every file in a package directory that requires a module through an alias.

[Usage] ./Scripts/CountAliases.exec.luau <packageDir>

--]]

local fs = require("@lune/fs")
local process = require("@lune/process")

local function patchFile(dir, fileName)
    local fileData = fs.readFile(`{dir}/{fileName}`)

    for requirePath: string in fileData.gmatch(fileData, 'local %S+ = require%("(%S+)"%)') do
        if string.sub(requirePath, 1, 1) == "@" then
            print(`{dir}/{fileName}`)
        end
    end
end

local function readFolder(dir)
    for _, object in fs.readDir(dir) do
        if fs.isDir(`{dir}/{object}`) then
            readFolder(`{dir}/{object}`)
        else
            patchFile(dir, object)
        end
    end
end

local CountAliases = {}

function CountAliases.exec()
    local packageDir = process.args[1]

    readFolder(packageDir)
end

CountAliases.exec()
