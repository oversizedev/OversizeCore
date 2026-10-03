//
// Copyright © 2026 Alexander Romanov
// OptionalExtensionsTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

struct OptionalExtensionTests {
    @Test func stringValueOrEmpty_withValue_returnsValue() {
        let value: String? = "John"
        #expect(value.valueOrEmpty == "John")
    }

    @Test func stringValueOrEmpty_withNil_returnsEmptyString() {
        let value: String? = nil
        #expect(value.valueOrEmpty == "")
    }

    @Test func dateValueOrEmpty_withValue_returnsValue() {
        let date = Date(timeIntervalSince1970: 1_000_000)
        let value: Date? = date
        #expect(value.valueOrEmpty == date)
    }

    @Test func dateValueOrEmpty_withNil_returnsCurrentDate() {
        let value: Date? = nil
        #expect(abs(value.valueOrEmpty.timeIntervalSinceNow) < 5)
    }

    @Test func floatValueOrEmpty_withValue_returnsValue() {
        let value: Float? = 19.99
        #expect(value.valueOrEmpty == 19.99)
    }

    @Test func floatValueOrEmpty_withNil_returnsZero() {
        let value: Float? = nil
        #expect(value.valueOrEmpty == 0)
    }

    @Test func doubleValueOrEmpty_withValue_returnsValue() {
        let value: Double? = 95.5
        #expect(value.valueOrEmpty == 95.5)
    }

    @Test func doubleValueOrEmpty_withNil_returnsZero() {
        let value: Double? = nil
        #expect(value.valueOrEmpty == 0)
    }

    @Test func boolValueOrFalse_withValue_returnsValue() {
        let value: Bool? = true
        #expect(value.valueOrFalse)
    }

    @Test func boolValueOrFalse_withNil_returnsFalse() {
        let value: Bool? = nil
        #expect(!value.valueOrFalse)
    }

    @Test func boolValueOrTrue_withValue_returnsValue() {
        let value: Bool? = false
        #expect(!value.valueOrTrue)
    }

    @Test func boolValueOrTrue_withNil_returnsTrue() {
        let value: Bool? = nil
        #expect(value.valueOrTrue)
    }
}
