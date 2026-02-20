//
// Copyright © 2022 Alexander Romanov
// Color+Extension.swift
//

import SwiftUI

// MARK: - Color Component Manipulation (iOS Only)

#if os(iOS)
// swiftlint:disable large_tuple

public extension Color {
    /// Extracts the RGBA components of the color.
    ///
    /// This computed property breaks down the color into its red, green, blue, and opacity
    /// components, providing access to the individual color values for calculations and manipulations.
    ///
    /// - Returns: A tuple containing (red, green, blue, opacity) as CGFloat values from 0.0 to 1.0
    ///
    /// Example:
    /// ```swift
    /// let color = Color.red
    /// let components = color.components
    /// print("Red: \(components.red), Green: \(components.green)")
    /// // Output: Red: 1.0, Green: 0.0
    /// ```
    ///
    /// - Note: This property is only available on iOS. Returns (0, 0, 0, 0) if component extraction fails.
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            return (0, 0, 0, 0)
        }
        return (r, g, b, o)
    }

    /// Creates a lighter version of the color by the specified percentage.
    ///
    /// This function increases the brightness of the color by adding the specified
    /// percentage to each RGB component, creating a lighter variant of the original color.
    ///
    /// - Parameter percentage: The percentage to lighten the color (default: 30.0)
    /// - Returns: A new Color instance that is lighter than the original
    ///
    /// Example:
    /// ```swift
    /// let originalColor = Color.blue
    /// let lighterBlue = originalColor.lighter(by: 20.0)
    /// let muchLighter = originalColor.lighter() // Uses default 30%
    /// ```
    ///
    /// - Note: This function is only available on iOS. Values are clamped to prevent overflow.
    func lighter(by percentage: CGFloat = 30.0) -> Color {
        adjust(by: abs(percentage))
    }

    /// Creates a darker version of the color by the specified percentage.
    ///
    /// This function decreases the brightness of the color by subtracting the specified
    /// percentage from each RGB component, creating a darker variant of the original color.
    ///
    /// - Parameter percentage: The percentage to darken the color (default: 30.0)
    /// - Returns: A new Color instance that is darker than the original
    ///
    /// Example:
    /// ```swift
    /// let originalColor = Color.yellow
    /// let darkerYellow = originalColor.darker(by: 25.0)
    /// let muchDarker = originalColor.darker() // Uses default 30%
    /// ```
    ///
    /// - Note: This function is only available on iOS. Values are clamped to prevent underflow.
    func darker(by percentage: CGFloat = 30.0) -> Color {
        adjust(by: -1 * abs(percentage))
    }

    /// Adjusts the color brightness by the specified percentage.
    ///
    /// This function modifies the RGB components of the color by adding or subtracting
    /// the specified percentage. Positive values lighten the color, negative values darken it.
    ///
    /// - Parameter percentage: The percentage to adjust (positive for lighter, negative for darker)
    /// - Returns: A new Color instance with adjusted brightness
    ///
    /// Example:
    /// ```swift
    /// let baseColor = Color.green
    /// let lighter = baseColor.adjust(by: 40.0)  // Lighter
    /// let darker = baseColor.adjust(by: -20.0)  // Darker
    /// ```
    ///
    /// - Note: This function is only available on iOS. RGB values are clamped between 0.0 and 1.0.
    func adjust(by percentage: CGFloat = 30.0) -> Color {
        Color(red: min(Double(components.red + percentage / 100), 1.0),
              green: min(Double(components.green + percentage / 100), 1.0),
              blue: min(Double(components.blue + percentage / 100), 1.0),
              opacity: Double(components.opacity))
    }
}
#endif

// MARK: - Random Color Generation

public extension Color {
    /// Generates a random color with optional random opacity.
    ///
    /// This static function creates a Color with randomly generated RGB values.
    /// The opacity can be either fixed at 1.0 (opaque) or randomized as well.
    /// Useful for testing, prototyping, or creating dynamic color schemes.
    ///
    /// - Parameter randomOpacity: Whether to randomize the opacity as well (default: false)
    /// - Returns: A Color with random RGB values and either fixed or random opacity
    ///
    /// Example:
    /// ```swift
    /// let opaqueRandom = Color.random()              // Random color, fully opaque
    /// let transparentRandom = Color.random(randomOpacity: true) // Random color with random opacity
    ///
    /// // Use in SwiftUI
    /// Rectangle()
    ///     .fill(Color.random())
    ///     .frame(width: 100, height: 100)
    /// ```
    ///
    /// - Note: All color components (red, green, blue, and optionally opacity) are generated using uniform distribution from 0.0 to 1.0.
    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0 ... 1),
            green: .random(in: 0 ... 1),
            blue: .random(in: 0 ... 1),
            opacity: randomOpacity ? .random(in: 0 ... 1) : 1,
        )
    }
}
