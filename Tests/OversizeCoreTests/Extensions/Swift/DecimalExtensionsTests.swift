//
// Copyright © 2026 Alexander Romanov
// DecimalExtensionsTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

struct DecimalExtensionTests {
    @Test func toString_keepsExactRepresentation() throws {
        let value = try #require(Decimal(string: "123.456"))
        #expect(value.toString == "123.456")
    }

    @Test func toString_withWholeNumber_dropsFraction() {
        #expect(Decimal(42).toString == "42")
    }

    @Test func rounded_withPlainMode_roundsHalfAway() throws {
        let value = try #require(Decimal(string: "1.2345"))
        #expect(value.rounded(2) == Decimal(string: "1.23"))
        #expect(value.rounded(3) == Decimal(string: "1.235"))
    }

    @Test func rounded_withUpMode_roundsTowardsInfinity() throws {
        let value = try #require(Decimal(string: "1.2341"))
        #expect(value.rounded(2, roundingMode: .up) == Decimal(string: "1.24"))
    }

    @Test func rounded_withDownMode_truncates() throws {
        let value = try #require(Decimal(string: "1.2399"))
        #expect(value.rounded(2, roundingMode: .down) == Decimal(string: "1.23"))
    }

    @Test func rounded_withBankersMode_roundsToEven() throws {
        #expect(try #require(Decimal(string: "1.25")).rounded(1, roundingMode: .bankers) == Decimal(string: "1.2"))
        #expect(try #require(Decimal(string: "1.35")).rounded(1, roundingMode: .bankers) == Decimal(string: "1.4"))
    }

    @Test func rounded_withZeroScale_returnsInteger() throws {
        let value = try #require(Decimal(string: "1.6"))
        #expect(value.rounded(0) == Decimal(2))
    }
}
