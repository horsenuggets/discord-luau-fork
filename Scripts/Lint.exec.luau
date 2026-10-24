#!/usr/bin/env -S lune run

--[[

Lint.exec

Runs luau-lsp analyze to report type errors and deprecation warnings.

[Usage] ./Scripts/Lint.exec.luau

--]]

const process = require("@lune/process")

const Lint = {}

function Lint.exec()
    const result = process.exec("luau-lsp", {
        "analyze",
        "--platform=lune",
        "--no-flags-enabled",
        "--enable-new-solver",
        "--ignore=DevPackages/**",
        "--ignore=Packages/**",
        "--ignore=Submodules/**",
        ".",
    })

    if result.stdout ~= "" then
        print(result.stdout)
    end
    if result.stderr ~= "" then
        print(result.stderr)
    end

    if result.ok then
        print("No lint errors found.")
    else
        process.exit(1)
    end
end

Lint.exec()
