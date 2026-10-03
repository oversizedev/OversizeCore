//
// Copyright © 2026 Alexander Romanov
// LogTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

struct LogTests {
    @Test func severityLevels_doNotTrap() {
        Log.trace("trace")
        Log.debug("debug")
        Log.info("info")
        Log.notice("notice")
        Log.warning("warning")
        Log.error("error")
        Log.critical("critical")
        Log.fault("fault")
    }

    @Test func variadicDebug_doesNotTrap() {
        Log.debug(1, "two", 3.0)
        Log.debug(1, 2, separator: " | ")
    }

    @Test func errorWithUnderlyingError_doesNotTrap() {
        Log.error("Operation failed", error: TestError.first)
    }

    @Test func categoryHelpers_doNotTrap() {
        Log.ui("ui")
        Log.network("network")
        Log.security("security")
    }

    @Test func debugWithURL_handlesEveryInput() throws {
        let remote = try #require(URL(string: "https://example.com/path"))
        let file = URL(fileURLWithPath: "/tmp/example.txt")

        Log.debug("message", url: remote)
        Log.debug("message", url: file)
        Log.debug(nil, url: remote)
        Log.debug("message", url: nil)
        Log.debug(url: remote)
        Log.debug(url: file)
        Log.debug(url: nil)
    }

    @available(*, deprecated)
    @Test func legacyGlobalLoggers_doNotTrap() throws {
        let remote = try #require(URL(string: "https://example.com/path"))
        let file = URL(fileURLWithPath: "/tmp/example.txt")
        let optionalObject: Any? = nil

        log(1, "two", 3.0)
        log(optionalObject)
        log("text")
        logWithTime("time")
        logDebug("debug")
        logUI("ui")
        logNotice("notice")
        logNetwork("network")
        logInfo("info")
        logSecurity("security")
        logSuccess("success")
        logSuccess("success", object: 42)
        logWarning("warning")
        logError("error")
        logError("error", error: TestError.first)
        logError("error", TestError.second)
        logError("error", error: "description")
        logDeleted("deleted")
        logCloud("cloud")
        logData("data")
        logUrl("message", url: remote)
        logUrl("message", url: file)
        logUrl(url: remote)
        logUrl(url: nil)
    }
}
