//
// Copyright © 2026 Alexander Romanov
// ColorDataTests.swift
//

#if canImport(SwiftUI)
import Foundation
@testable import OversizeCore
import SwiftUI
import Testing

private let tolerance: Double = 1e-6

private struct StoredComponents: Decodable {
    let red: Double
    let green: Double
    let blue: Double
    let opacity: Double
}

private func storedComponents(_ data: ColorData) throws -> StoredComponents {
    let encoded = try JSONEncoder().encode(data)
    return try JSONDecoder().decode(StoredComponents.self, from: encoded)
}

private func expectApproximatelyEqual(
    _ lhs: ColorData,
    _ rhs: ColorData,
    accuracy: Double = tolerance,
    sourceLocation: SourceLocation = #_sourceLocation,
) throws {
    let lhsComponents = try storedComponents(lhs)
    let rhsComponents = try storedComponents(rhs)
    #expect(abs(lhsComponents.red - rhsComponents.red) < accuracy, sourceLocation: sourceLocation)
    #expect(abs(lhsComponents.green - rhsComponents.green) < accuracy, sourceLocation: sourceLocation)
    #expect(abs(lhsComponents.blue - rhsComponents.blue) < accuracy, sourceLocation: sourceLocation)
    #expect(abs(lhsComponents.opacity - rhsComponents.opacity) < accuracy, sourceLocation: sourceLocation)
}

// MARK: - Semantic and system colors

struct ColorDataSemanticColorTests {
    @Test func semanticRed_resolvesToRedRange() throws {
        let components = try storedComponents(ColorData(color: .red))
        #expect(components.red > 0.9)
        #expect(components.green < 0.4)
        #expect(components.blue < 0.4)
    }

    @Test func semanticBlue_resolvesToBlueRange() throws {
        let components = try storedComponents(ColorData(color: .blue))
        #expect(components.red < 0.4)
        #expect(components.blue > 0.9)
        #expect(components.blue > components.red)
        #expect(components.blue > components.green)
    }

    @Test func semanticGreen_resolvesToGreenRange() throws {
        let components = try storedComponents(ColorData(color: .green))
        #expect(components.red < 0.4)
        #expect(components.green > 0.6)
        #expect(components.blue < 0.4)
    }

    @Test func distinctSemanticColors_resolveToDistinctStoredValues() {
        let red = ColorData(color: .red)
        let green = ColorData(color: .green)
        let blue = ColorData(color: .blue)

        #expect(red != green)
        #expect(red != blue)
        #expect(green != blue)
    }

    /// `.primary` is a dynamic/system color. `EnvironmentValues()` defaults to the
    /// light appearance, where `.primary` resolves near-black rather than white.
    @Test func primaryColor_resolvesNearBlackInDefaultEnvironment() throws {
        let components = try storedComponents(ColorData(color: .primary))
        #expect(components.red < 0.2)
        #expect(components.green < 0.2)
        #expect(components.blue < 0.2)
        #expect(components.opacity > 0.5)
    }

    @Test func clearColor_doesNotResolveToOpaqueWhite() throws {
        #expect(try storedComponents(ColorData(color: .clear)).opacity < 0.02)
    }
}

// MARK: - Component round-trip

struct ColorDataRoundTripTests {
    @Test(arguments: [
        (0.25, 0.5, 0.75, 0.9),
        (0.0, 0.0, 0.0, 1.0),
        (1.0, 1.0, 1.0, 1.0),
        (0.1, 0.9, 0.4, 0.3),
        (0.5, 0.5, 0.5, 1.0),
        (0.6, 0.6, 0.6, 0.5),
    ])
    func explicitComponents_roundTripThroughColor(_ red: Double, _ green: Double, _ blue: Double, _ opacity: Double) throws {
        let original = ColorData(red: red, green: green, blue: blue, opacity: opacity)
        try expectApproximatelyEqual(original, ColorData(color: original.color))
    }

    @Test func color_exposesStoredComponents() {
        let data = ColorData(red: 0.25, green: 0.5, blue: 0.75, opacity: 1)
        let components = data.color.components
        #expect(abs(components.red - 0.25) < 0.01)
        #expect(abs(components.green - 0.5) < 0.01)
        #expect(abs(components.blue - 0.75) < 0.01)
    }

    @Test func displayP3Color_clampsComponentsToUnitRange() throws {
        let components = try storedComponents(ColorData(color: Color(.displayP3, red: 1, green: 0, blue: 0)))
        #expect((0 ... 1).contains(components.red))
        #expect((0 ... 1).contains(components.green))
        #expect((0 ... 1).contains(components.blue))
        #expect((0 ... 1).contains(components.opacity))
    }
}

// MARK: - Codable and Hashable

struct ColorDataCodableTests {
    @Test func codable_roundTrips() throws {
        let original = ColorData(red: 0.2, green: 0.4, blue: 0.6, opacity: 0.8)
        let encoded = try JSONEncoder().encode(original)
        #expect(try JSONDecoder().decode(ColorData.self, from: encoded) == original)
    }

    @Test func equalValues_shareHash() {
        let first = ColorData(red: 0.2, green: 0.4, blue: 0.6, opacity: 0.8)
        let second = ColorData(red: 0.2, green: 0.4, blue: 0.6, opacity: 0.8)
        #expect(first.hashValue == second.hashValue)
    }

    @Test func distinctValues_deduplicateInSet() {
        let values: Set<ColorData> = [
            ColorData(red: 1, green: 0, blue: 0, opacity: 1),
            ColorData(red: 1, green: 0, blue: 0, opacity: 1),
            ColorData(red: 0, green: 1, blue: 0, opacity: 1),
        ]
        #expect(values.count == 2)
    }
}

// MARK: - ExpressibleByStringLiteral

struct ColorDataStringLiteralTests {
    @Test func sixCharHex_resolvesToRed() throws {
        let components = try storedComponents("#FF0000" as ColorData)
        #expect(components.red > 0.9)
        #expect(components.green < 0.1)
        #expect(components.blue < 0.1)
        #expect(components.opacity > 0.9)
    }

    @Test func eightCharHexWithAlpha_resolvesToRedWithHalfOpacity() throws {
        let components = try storedComponents("#80FF0000" as ColorData)
        #expect(components.red > 0.9)
        #expect(components.green < 0.1)
        #expect(components.blue < 0.1)
        #expect(abs(components.opacity - 0.5) < 0.05)
    }

    @Test func threeCharHex_resolvesToGreen() throws {
        let components = try storedComponents("#0F0" as ColorData)
        #expect(components.red < 0.1)
        #expect(components.green > 0.9)
        #expect(components.blue < 0.1)
    }

    @Test func invalidHex_fallsBackToBlack() throws {
        let components = try storedComponents("not-a-color" as ColorData)
        #expect(components.red < 0.02)
        #expect(components.green < 0.02)
        #expect(components.blue < 0.02)
        #expect(components.opacity > 0.9)
    }
}
#endif
