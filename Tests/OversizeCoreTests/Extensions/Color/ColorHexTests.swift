//
// Copyright © 2026 Alexander Romanov
// ColorHexTests.swift
//

#if canImport(SwiftUI)
import Foundation
@testable import OversizeCore
import SwiftUI
import Testing

private let tolerance: CGFloat = 1.0 / 255 + 0.001

private func expectComponents(
    _ color: Color,
    red: CGFloat,
    green: CGFloat,
    blue: CGFloat,
    alpha: CGFloat,
    sourceLocation: SourceLocation = #_sourceLocation,
) {
    let components = color.rgba
    #expect(abs(components.red - red) < tolerance, sourceLocation: sourceLocation)
    #expect(abs(components.green - green) < tolerance, sourceLocation: sourceLocation)
    #expect(abs(components.blue - blue) < tolerance, sourceLocation: sourceLocation)
    #expect(abs(components.alpha - alpha) < tolerance, sourceLocation: sourceLocation)
}

// MARK: - Parsing

struct ColorHexParsingTests {
    @Test func sixCharacterHex_parsesRGB() {
        expectComponents(Color(hex: "FF0000"), red: 1, green: 0, blue: 0, alpha: 1)
    }

    @Test func sixCharacterHex_withHashPrefix_parsesRGB() {
        expectComponents(Color(hex: "#0000FF"), red: 0, green: 0, blue: 1, alpha: 1)
    }

    @Test func threeCharacterHex_expandsEachNibble() {
        expectComponents(Color(hex: "0F0"), red: 0, green: 1, blue: 0, alpha: 1)
    }

    @Test func eightCharacterHex_parsesAlphaFirst() {
        expectComponents(Color(hex: "#80FF0000"), red: 1, green: 0, blue: 0, alpha: 128.0 / 255)
    }

    @Test func hex_ignoresNonAlphanumericSeparators() {
        expectComponents(Color(hex: "FF-00-00"), red: 1, green: 0, blue: 0, alpha: 1)
    }

    @Test func invalidHex_fallsBackToOpaqueBlack() {
        expectComponents(Color(hex: "zzzz"), red: 0, green: 0, blue: 0, alpha: 1)
    }

    @Test func optionalHex_withValue_parsesColor() {
        let hex: String? = "#00FF00"
        expectComponents(Color(hex: hex), red: 0, green: 1, blue: 0, alpha: 1)
    }

    @Test func optionalHex_withNil_returnsOpaqueBlack() {
        let hex: String? = nil
        expectComponents(Color(hex: hex), red: 0, green: 0, blue: 0, alpha: 1)
    }
}

// MARK: - Hex string generation

struct ColorHexStringTests {
    @Test func hexString_withOpaqueColor_returnsSixDigits() {
        #expect(Color(hex: "#FF0000").hexString() == "#ff0000")
    }

    @Test func hexString_withTranslucentColor_returnsEightDigitsARGB() {
        #expect(Color(hex: "#80FF0000").hexString() == "#80ff0000")
    }

    @Test(arguments: ["#ff0000", "#00ff00", "#0000ff", "#123456", "#ffffff", "#000000"])
    func hexString_roundTripsOpaqueColors(_ hex: String) {
        #expect(Color(hex: hex).hexString() == hex)
    }

    @Test(arguments: ["#80ff0000", "#40123456", "#01ffffff"])
    func hexString_roundTripsTranslucentColors(_ hex: String) {
        #expect(Color(hex: hex).hexString() == hex)
    }

    @Test func hexStringFromColorComponents_withOpaqueComponents_returnsRGB() {
        #expect(hexStringFromColorComponents((red: 1, green: 0, blue: 0, alpha: 1)) == "#ff0000")
    }

    @Test func hexStringFromColorComponents_withAlpha_returnsARGB() {
        #expect(hexStringFromColorComponents((red: 0, green: 0, blue: 1, alpha: 0)) == "#000000ff")
    }

    @Test func hexStringFromColorComponents_clampsOutOfRangeChannels() {
        #expect(hexStringFromColorComponents((red: 2, green: -1, blue: 0.5, alpha: 1)) == "#ff0080")
    }
}

// MARK: - ExpressibleByStringLiteral

struct ColorStringLiteralTests {
    @Test func stringLiteral_withSixCharHex_parsesColor() {
        let color: Color = "#FF0000"
        expectComponents(color, red: 1, green: 0, blue: 0, alpha: 1)
    }

    @Test func stringLiteral_withThreeCharHex_parsesColor() {
        let color: Color = "#0F0"
        expectComponents(color, red: 0, green: 1, blue: 0, alpha: 1)
    }

    @Test func stringLiteral_withInvalidLength_fallsBackToBlack() {
        let color: Color = "not-a-color"
        #expect(color == Color.black)
    }
}
#endif
