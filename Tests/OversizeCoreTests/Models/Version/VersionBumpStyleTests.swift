//
// Copyright © 2026 Alexander Romanov
// VersionBumpStyleTests.swift
//

@testable import OversizeCore
import Testing

struct VersionBumpStyleTests {
    @Test func shortStyle_omitsPatchComponent() {
        #expect(Version(1, 2, 3).nextMajor(.short).description == "2.0")
        #expect(Version(1, 2, 3).nextMinor(.short).description == "1.3")
    }

    @Test func fullStyle_includesPatchComponent() {
        #expect(Version(1, 2, 3).nextMajor(.full).description == "2.0.0")
        #expect(Version(1, 2, 3).nextMinor(.full).description == "1.3.0")
    }

    @Test func defaultStyle_isShort() {
        #expect(Version(1, 2, 3).nextMajor().description == Version(1, 2, 3).nextMajor(.short).description)
        #expect(Version(1, 2, 3).nextMinor().description == Version(1, 2, 3).nextMinor(.short).description)
    }
}
