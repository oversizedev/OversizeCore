//
// Copyright © 2026 Alexander Romanov
// BoolExtensionsTests.swift
//

@testable import OversizeCore
import Testing

struct BoolAvailabilityTests {
    @Test func availabilityChecks_areMonotonic() {
        if Bool.iOS26 {
            #expect(Bool.iOS18)
        }
        if Bool.iOS18 {
            #expect(Bool.iOS17)
        }
        if Bool.iOS17 {
            #expect(Bool.iOS16)
        }
    }

    @Test func iOS16_isSatisfiedOnSupportedRuntimes() {
        #expect(Bool.iOS16)
    }
}
