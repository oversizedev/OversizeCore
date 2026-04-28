//
// Copyright © 2022 Alexander Romanov
// Color+Extension.swift
//

#if canImport(SwiftUI)
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

    /// The WCAG relative luminance of the color in the range `0...1`.
    ///
    /// sRGB components are first linearised (gamma-expanded) and then combined
    /// with the standard photometric weights (0.2126·R + 0.7152·G + 0.0722·B).
    /// Use this when you need a perceptually accurate brightness value — for
    /// example to compute contrast ratios against black or white.
    ///
    /// - Returns: Relative luminance from `0.0` (black) to `1.0` (white).
    ///
    /// - Note: This property is only available on iOS. It assumes an opaque
    ///   sRGB color; alpha is ignored and dynamic/semantic colors should be
    ///   resolved against a `UITraitCollection` before use.
    var relativeLuminance: CGFloat {
        let c = components
        func linearise(_ channel: CGFloat) -> CGFloat {
            channel <= 0.03928 ? channel / 12.92 : pow((channel + 0.055) / 1.055, 2.4)
        }
        return 0.2126 * linearise(c.red) + 0.7152 * linearise(c.green) + 0.0722 * linearise(c.blue)
    }

    /// Indicates whether the color is perceptually light.
    ///
    /// Compares the color's WCAG `relativeLuminance` to the standard
    /// `0.179` threshold — the point where black and white foregrounds
    /// produce an equal contrast ratio. Colors above this threshold
    /// read better with black text, colors below with white.
    ///
    /// - Returns: `true` if black foreground has higher contrast, `false` otherwise.
    ///
    /// Example:
    /// ```swift
    /// Color.yellow.isLight // true
    /// Color.blue.isLight   // false
    /// ```
    ///
    /// - Note: This property is only available on iOS.
    var isLight: Bool {
        relativeLuminance > 0.179
    }

    /// Returns a contrasting foreground color (black or white) for this background.
    ///
    /// Mirrors the iOS 26 adaptive title behaviour where text on a tinted
    /// Liquid Glass surface automatically picks the readable variant based on
    /// the underlying fill brightness.
    ///
    /// - Returns: `.black` for light backgrounds, `.white` for dark backgrounds.
    ///   Pass an opaque sRGB color — translucent or dynamic colors should be
    ///   composited/resolved by the caller first.
    ///
    /// Example:
    /// ```swift
    /// Text("Title")
    ///     .foregroundStyle(background.contrastingColor)
    ///     .padding()
    ///     .background(background)
    /// ```
    ///
    /// - Note: This property is only available on iOS.
    var contrastingColor: Color {
        isLight ? .black : .white
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
#endif
