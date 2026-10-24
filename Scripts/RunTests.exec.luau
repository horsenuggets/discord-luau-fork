#!/usr/bin/env -S lune run

--[[

RunTests.exec

Executes all test suites and exits with appropriate status code. Optionally pass a test
name as an argument to run only that test suite.

[Usage] ./Scripts/RunTests.exec.luau [TestName]

--]]

const Dotenv = require("@devpackages/Dotenv")
const Testable = require("@devpackages/Testable")
const process = require("@lune/process")
const stdio = require("@lune/stdio")

-- TODO: Tests need to be migrated from frktest to Testable and updated to use new paths
-- The original tests use old require paths (../src/, ../../../lune_packages/frktest)
-- which no longer exist in the restructured project
const TESTS: { { Name: string, Func: () -> () } } = {}

const RunTests = {}

function RunTests.exec()
    -- Load environment variables from .env file (optional)
    pcall(Dotenv.load)

    -- Disable parallel execution for integration tests that make API calls
    -- This prevents rate limiting issues with the Discord API
    Testable.configure({
        Parallel = false,
    })

    const filterName = process.args[1]

    const testsToRun = {}
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

    const suiteLabel = #testsToRun == 1 and "test suite" or "test suites"
    print(`Running {#testsToRun} {suiteLabel}...\n`)

    local passed = 0
    local failed = 0
    local skipped = 0

    for _, test in testsToRun do
        const result = Testable.run(test.Name, test.Func)
        passed += result.Passed
        failed += result.Failed
        skipped += result.Skipped
    end

    print()
    const total = passed + failed + skipped
    const color = failed > 0 and "red" or "green"
    print(
        stdio.color(color)
            .. `{passed}/{total} tests passed, {failed} failed, {skipped} skipped`
            .. stdio.color("reset")
    )

    if failed > 0 then
        process.exit(1)
    end
end

RunTests.exec()
