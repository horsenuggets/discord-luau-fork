#!/usr/bin/env -S lune run

--[[

RunTests

Executes all test suites and exits with appropriate status code. Optionally pass a test
name as an argument to run only that test suite.

[Usage] lune run ./Scripts/RunTests.luau [TestName]

--]]

local Testable = require("@devpackages/Testable")
local process = require("@lune/process")
local stdio = require("@lune/stdio")

-- Load environment variables from .env file (optional)
local Dotenv = require("@devpackages/Dotenv")
pcall(Dotenv.load)

-- Disable parallel execution for integration tests that make API calls
-- This prevents rate limiting issues with the Discord API
Testable.configure({
    Parallel = false,
})

-- TODO: Tests need to be migrated from frktest to Testable and updated to use new paths
-- The original tests use old require paths (../src/, ../../../lune_packages/frktest)
-- which no longer exist in the restructured project
local TESTS: { { Name: string, Func: () -> () } } = {}

local function runTests()
    local filterName = process.args[1]

    local testsToRun = {}
    for _, test in TESTS do
        if filterName == nil or test.Name:lower():find(filterName:lower()) then
            table.insert(testsToRun, test)
        end
    end

    if #testsToRun == 0 then
        if filterName then
            print(stdio.color("red") .. `No tests found matching "{filterName}"` .. stdio.color("reset"))
            process.exit(1)
        else
            print(stdio.color("yellow") .. "No tests configured. Tests need to be migrated." .. stdio.color("reset"))
            process.exit(0)
        end
    end

    local suiteLabel = #testsToRun == 1 and "test suite" or "test suites"
    print(`Running {#testsToRun} {suiteLabel}...\n`)

    local passed = 0
    local failed = 0
    local skipped = 0

    for _, test in testsToRun do
        local result = Testable.run(test.Name, test.Func)
        passed += result.Passed
        failed += result.Failed
        skipped += result.Skipped
    end

    print()
    local total = passed + failed + skipped
    local color = failed > 0 and "red" or "green"
    print(
        stdio.color(color)
            .. `{passed}/{total} tests passed, {failed} failed, {skipped} skipped`
            .. stdio.color("reset")
    )

    if failed > 0 then
        process.exit(1)
    end
end

runTests()
