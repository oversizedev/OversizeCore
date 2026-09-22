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

    @Test func variadicDebug_joinsItems() {
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
}
