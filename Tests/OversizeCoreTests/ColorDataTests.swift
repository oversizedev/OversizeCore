//
// Copyright © 2026 Alexander Romanov
// ColorDataTests.swift
//

#if canImport(SwiftUI)
@testable import OversizeCore
import SwiftUI
import XCTest

final class ColorDataTests: XCTestCase {
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

    private func assertApproximatelyEqual(
        _ lhs: ColorData,
        _ rhs: ColorData,
        accuracy: Double? = nil,
        file: StaticString = #filePath,
        line: UInt = #line,
    ) throws {
        let lhsComponents = try storedComponents(lhs)
        let rhsComponents = try storedComponents(rhs)
        let accuracy = accuracy ?? tolerance
        XCTAssertEqual(lhsComponents.red, rhsComponents.red, accuracy: accuracy, file: file, line: line)
        XCTAssertEqual(lhsComponents.green, rhsComponents.green, accuracy: accuracy, file: file, line: line)
        XCTAssertEqual(lhsComponents.blue, rhsComponents.blue, accuracy: accuracy, file: file, line: line)
        XCTAssertEqual(lhsComponents.opacity, rhsComponents.opacity, accuracy: accuracy, file: file, line: line)
    }

    // MARK: - Semantic / system colors

    func testSemanticColor_Red_ResolvesToRedRange() throws {
        let components = try storedComponents(ColorData(color: .red))
        XCTAssertGreaterThan(components.red, 0.9)
        XCTAssertLessThan(components.green, 0.4)
        XCTAssertLessThan(components.blue, 0.4)
    }

    func testSemanticColor_Blue_ResolvesToBlueRange() throws {
        let components = try storedComponents(ColorData(color: .blue))
        XCTAssertLessThan(components.red, 0.4)
        XCTAssertGreaterThan(components.blue, 0.9)
        XCTAssertGreaterThan(components.blue, components.red)
        XCTAssertGreaterThan(components.blue, components.green)
    }

    func testSemanticColor_Green_ResolvesToGreenRange() throws {
        let components = try storedComponents(ColorData(color: .green))
        XCTAssertLessThan(components.red, 0.4)
        XCTAssertGreaterThan(components.green, 0.6)
        XCTAssertLessThan(components.blue, 0.4)
    }

    func testDistinctSemanticColors_ResolveToDistinctStoredValues() {
        let red = ColorData(color: .red)
        let green = ColorData(color: .green)
        let blue = ColorData(color: .blue)

        XCTAssertNotEqual(red, green)
        XCTAssertNotEqual(red, blue)
        XCTAssertNotEqual(green, blue)
    }

    func testPrimaryColor_ResolvesNearBlackInDefaultEnvironment() throws {
        // `.primary` is a dynamic/system color. `EnvironmentValues()` defaults to the
        // light appearance, where `.primary` resolves near-black rather than white.
        let components = try storedComponents(ColorData(color: .primary))
        XCTAssertLessThan(components.red, 0.2)
        XCTAssertLessThan(components.green, 0.2)
        XCTAssertLessThan(components.blue, 0.2)
        XCTAssertGreaterThan(components.opacity, 0.5)
    }

    // MARK: - Clear color

    func testClearColor_DoesNotResolveToOpaqueWhite() throws {
        let components = try storedComponents(ColorData(color: .clear))
        XCTAssertLessThan(components.opacity, 0.02)
    }

    // MARK: - Explicit component round-trip

    func testExplicitComponents_RoundTripsThroughColor() throws {
        let original = ColorData(red: 0.25, green: 0.5, blue: 0.75, opacity: 0.9)
        let roundTripped = ColorData(color: original.color)
        try assertApproximatelyEqual(original, roundTripped)
    }

    func testExplicitComponents_FullyOpaqueBlack_RoundTrips() throws {
        let original = ColorData(red: 0, green: 0, blue: 0, opacity: 1)
        let roundTripped = ColorData(color: original.color)
        try assertApproximatelyEqual(original, roundTripped)
    }

    func testExplicitComponents_FullyOpaqueWhite_RoundTrips() throws {
        let original = ColorData(red: 1, green: 1, blue: 1, opacity: 1)
        let roundTripped = ColorData(color: original.color)
        try assertApproximatelyEqual(original, roundTripped)
    }

    func testExplicitComponents_PartialOpacity_RoundTrips() throws {
        let original = ColorData(red: 0.1, green: 0.9, blue: 0.4, opacity: 0.3)
        let roundTripped = ColorData(color: original.color)
        try assertApproximatelyEqual(original, roundTripped)
    }

    // MARK: - Grayscale

    func testGrayscaleColor_RoundTrips() throws {
        let original = ColorData(red: 0.5, green: 0.5, blue: 0.5, opacity: 1)
        let roundTripped = ColorData(color: original.color)
        try assertApproximatelyEqual(original, roundTripped)
    }

    func testGrayColor_WithOpacity_RoundTrips() throws {
        let original = ColorData(red: 0.6, green: 0.6, blue: 0.6, opacity: 0.5)
        let roundTripped = ColorData(color: original.color)
        try assertApproximatelyEqual(original, roundTripped)
    }

    // MARK: - Wide gamut

    func testDisplayP3Color_ClampsComponentsToUnitRange() throws {
        let components = try storedComponents(ColorData(color: Color(.displayP3, red: 1, green: 0, blue: 0)))
        XCTAssertGreaterThanOrEqual(components.red, 0)
        XCTAssertLessThanOrEqual(components.red, 1)
        XCTAssertGreaterThanOrEqual(components.green, 0)
        XCTAssertLessThanOrEqual(components.green, 1)
        XCTAssertGreaterThanOrEqual(components.blue, 0)
        XCTAssertLessThanOrEqual(components.blue, 1)
        XCTAssertGreaterThanOrEqual(components.opacity, 0)
        XCTAssertLessThanOrEqual(components.opacity, 1)
    }

    // MARK: - Codable

    func testColorData_IsCodableRoundTrip() throws {
        let original = ColorData(red: 0.2, green: 0.4, blue: 0.6, opacity: 0.8)
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(ColorData.self, from: encoded)
        XCTAssertEqual(original, decoded)
    }

    // MARK: - ExpressibleByStringLiteral

    func testStringLiteral_SixCharHex_ResolvesToRed() throws {
        let components = try storedComponents("#FF0000" as ColorData)
        XCTAssertGreaterThan(components.red, 0.9)
        XCTAssertLessThan(components.green, 0.1)
        XCTAssertLessThan(components.blue, 0.1)
        XCTAssertGreaterThan(components.opacity, 0.9)
    }

    func testStringLiteral_EightCharHexWithAlpha_ResolvesToRedWithHalfOpacity() throws {
        let components = try storedComponents("#80FF0000" as ColorData)
        XCTAssertGreaterThan(components.red, 0.9)
        XCTAssertLessThan(components.green, 0.1)
        XCTAssertLessThan(components.blue, 0.1)
        XCTAssertEqual(components.opacity, 0.5, accuracy: 0.05)
    }

    func testStringLiteral_InvalidHex_FallsBackToBlack() throws {
        let components = try storedComponents("not-a-color" as ColorData)
        XCTAssertLessThan(components.red, 0.02)
        XCTAssertLessThan(components.green, 0.02)
        XCTAssertLessThan(components.blue, 0.02)
        XCTAssertGreaterThan(components.opacity, 0.9)
    }
}
#endif
