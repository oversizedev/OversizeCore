//
// Copyright © 2026 Alexander Romanov
// ColorExtensionTests.swift
//

#if canImport(SwiftUI)
import Foundation
@testable import OversizeCore
import SwiftUI
import Testing

// MARK: - Components

struct ColorComponentsTests {
    @Test func components_returnsSourceValues() {
        let components = Color(red: 0.25, green: 0.5, blue: 0.75, opacity: 0.5).components
        #expect(abs(components.red - 0.25) < 0.01)
        #expect(abs(components.green - 0.5) < 0.01)
        #expect(abs(components.blue - 0.75) < 0.01)
        #expect(abs(components.opacity - 0.5) < 0.01)
    }

    @Test func components_forWhite_returnsMaximumChannels() {
        let components = Color(red: 1, green: 1, blue: 1, opacity: 1).components
        #expect(abs(components.red - 1) < 0.01)
        #expect(abs(components.green - 1) < 0.01)
        #expect(abs(components.blue - 1) < 0.01)
    }
}

// MARK: - Adjustment

struct ColorAdjustmentTests {
    private let gray = Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 1)

    @Test func lighter_increasesEveryChannel() {
        let lighter = gray.lighter(by: 20).components
        #expect(abs(lighter.red - 0.7) < 0.01)
        #expect(abs(lighter.green - 0.7) < 0.01)
        #expect(abs(lighter.blue - 0.7) < 0.01)
    }

    @Test func darker_decreasesEveryChannel() {
        let darker = gray.darker(by: 20).components
        #expect(abs(darker.red - 0.3) < 0.01)
        #expect(abs(darker.green - 0.3) < 0.01)
        #expect(abs(darker.blue - 0.3) < 0.01)
    }

    @Test func lighter_withNegativePercentage_stillLightens() {
        #expect(gray.lighter(by: -20).components.red > gray.components.red)
    }

    @Test func darker_withNegativePercentage_stillDarkens() {
        #expect(gray.darker(by: -20).components.red < gray.components.red)
    }

    @Test func adjust_clampsToUpperBound() {
        let components = gray.adjust(by: 200).components
        #expect(components.red <= 1)
        #expect(components.green <= 1)
        #expect(components.blue <= 1)
    }

    @Test func adjust_clampsToLowerBound() {
        let components = gray.adjust(by: -200).components
        #expect(components.red >= 0)
        #expect(components.green >= 0)
        #expect(components.blue >= 0)
    }

    @Test func adjust_preservesOpacity() {
        let translucent = Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.4)
        #expect(abs(translucent.adjust(by: 10).components.opacity - 0.4) < 0.01)
    }
}

// MARK: - Luminance

struct ColorLuminanceTests {
    @Test func relativeLuminance_forWhite_isOne() {
        let luminance = Color(red: 1, green: 1, blue: 1, opacity: 1).relativeLuminance
        #expect(abs(luminance - 1) < 0.01)
    }

    @Test func relativeLuminance_forBlack_isZero() {
        #expect(Color(red: 0, green: 0, blue: 0, opacity: 1).relativeLuminance < 0.01)
    }

    @Test func relativeLuminance_weightsGreenHighest() {
        let red = Color(red: 1, green: 0, blue: 0, opacity: 1).relativeLuminance
        let green = Color(red: 0, green: 1, blue: 0, opacity: 1).relativeLuminance
        let blue = Color(red: 0, green: 0, blue: 1, opacity: 1).relativeLuminance
        #expect(green > red)
        #expect(red > blue)
    }

    @Test func isLight_forWhite_returnsTrue() {
        #expect(Color(red: 1, green: 1, blue: 1, opacity: 1).isLight)
    }

    @Test func isLight_forBlack_returnsFalse() {
        #expect(!Color(red: 0, green: 0, blue: 0, opacity: 1).isLight)
    }

    @Test func contrastingColor_forLightBackground_returnsBlack() {
        #expect(Color(red: 1, green: 1, blue: 1, opacity: 1).contrastingColor == .black)
    }

    @Test func contrastingColor_forDarkBackground_returnsWhite() {
        #expect(Color(red: 0, green: 0, blue: 0, opacity: 1).contrastingColor == .white)
    }
}

// MARK: - Random

struct ColorRandomTests {
    @Test func random_producesChannelsInUnitRange() {
        for _ in 0 ..< 20 {
            let components = Color.random().components
            #expect((0 ... 1).contains(components.red))
            #expect((0 ... 1).contains(components.green))
            #expect((0 ... 1).contains(components.blue))
        }
    }

    @Test func random_withoutRandomOpacity_isOpaque() {
        #expect(abs(Color.random().components.opacity - 1) < 0.01)
    }

    @Test func random_withRandomOpacity_staysInUnitRange() {
        for _ in 0 ..< 20 {
            #expect((0 ... 1).contains(Color.random(randomOpacity: true).components.opacity))
        }
    }
}
#endif
