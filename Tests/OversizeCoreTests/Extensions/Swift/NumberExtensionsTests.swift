//
// Copyright © 2026 Alexander Romanov
// NumberExtensionsTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

// MARK: - Int

struct IntExtensionTests {
    private let titles = ["товар", "товара", "товаров"]

    @Test func toString_returnsDecimalRepresentation() {
        #expect(42.toString == "42")
        #expect((-7).toString == "-7")
    }

    @Test(arguments: [
        (1, "товар"),
        (2, "товара"),
        (4, "товара"),
        (5, "товаров"),
        (11, "товаров"),
        (14, "товаров"),
        (21, "товар"),
        (22, "товара"),
        (111, "товаров"),
        (0, "товаров"),
    ])
    func wordFormat_followsSlavicPluralRules(_ value: Int, _ expected: String) {
        #expect(value.wordFormat(titles: titles) == expected)
    }

    @Test(arguments: [-1, -2, -5, -11, -21])
    func wordFormat_withNegativeValue_matchesAbsoluteValue(_ value: Int) {
        #expect(value.wordFormat(titles: titles) == (-value).wordFormat(titles: titles))
    }

    @Test func wordFormat_withIntMin_doesNotTrap() {
        #expect(titles.contains(Int.min.wordFormat(titles: titles)))
    }

    @Test func stringWithWordFormats_withFormat_combinesNumberAndWord() {
        #expect(3.stringWithWordFormats(formats: titles, format: "%d %@") == "3 товара")
    }

    @Test func stringWithWordFormats_usesSelectedFormAsTemplate() {
        let formats = ["%d товар", "%d товара", "%d товаров"]
        #expect(1.stringWithWordFormats(formats: formats) == "1 товар")
        #expect(5.stringWithWordFormats(formats: formats) == "5 товаров")
    }
}

// MARK: - Double

struct DoubleExtensionTests {
    @Test func toString_returnsDescription() {
        #expect(42.5.toString == "42.5")
    }

    @Test func toStringWithoutPoint_roundsToWholeNumber() {
        #expect(42.7.toStringWithoutPoint == "43")
        #expect(42.2.toStringWithoutPoint == "42")
    }

    @Test func toStringOnePoint_keepsSingleDecimal() {
        #expect(42.567.toStringOnePoint == "42.6")
    }

    @Test func toStringTemperature_appendsDegreeSign() {
        #expect(23.7.toStringTemperature == "24°")
    }

    @Test func toStringTemperature_usesUnicodeMinusForNegatives() {
        #expect((-5.2).toStringTemperature == "−5°")
    }

    @Test func toStringTemperature_withZero_dropsSign() {
        #expect((-0.4).toStringTemperature == "0°")
        #expect(0.0.toStringTemperature == "0°")
    }
}

// MARK: - Float

struct FloatExtensionTests {
    @Test func toString_returnsDescription() {
        #expect(Float(42.5).toString == "42.5")
    }

    @Test func toStringWithoutPoint_roundsToWholeNumber() {
        #expect(Float(42.7).toStringWithoutPoint == "43")
    }
}

// MARK: - CGFloat

struct CGFloatExtensionTests {
    @Test func toStringWithoutPoint_roundsToWholeNumber() {
        #expect(CGFloat(120.8).toStringWithoutPoint == "121")
    }

    @Test func toStringTemperature_appendsDegreeSign() {
        #expect(CGFloat(23.7).toStringTemperature == "24°")
    }

    @Test func toStringTemperature_usesUnicodeMinusForNegatives() {
        #expect(CGFloat(-5.2).toStringTemperature == "−5°")
    }

    @Test func toStringTemperature_withNegativeZero_dropsSign() {
        #expect(CGFloat(-0.0).toStringTemperature == "0°")
    }
}
