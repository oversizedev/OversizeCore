//
// Copyright © 2022 Alexander Romanov
// Color+Hex.swift
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// A type alias representing the RGBA color components as a tuple.
/// 
/// This type provides a convenient way to work with color components,
/// containing red, green, blue, and alpha values as CGFloat from 0.0 to 1.0.
public typealias ColorComponentsRGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

// swiftlint:disable all

// MARK: - Hex Color Initialization

public extension Color {
    /// Creates a Color from a hexadecimal string representation.
    /// 
    /// This initializer supports multiple hex color formats:
    /// - 3-character RGB (e.g., "F0A" becomes "FF00AA")
    /// - 6-character RGB (e.g., "FF00AA")
    /// - 8-character ARGB (e.g., "80FF00AA" with alpha)
    /// 
    /// The initializer automatically strips non-alphanumeric characters,
    /// so formats like "#FF00AA", "0xFF00AA", or "FF-00-AA" are all valid.
    /// 
    /// - Parameter hex: The hexadecimal color string
    /// 
    /// Example:
    /// ```swift
    /// let red = Color(hex: "FF0000")        // Pure red
    /// let blue = Color(hex: "#0000FF")      // Pure blue with # prefix
    /// let green = Color(hex: "0F0")         // Short form green
    /// let transparent = Color(hex: "80FF0000") // Semi-transparent red
    /// ```
    /// 
    /// - Note: Invalid hex strings default to black with zero opacity.
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255,
        )
    }

    /// Creates a Color from an optional hexadecimal string representation.
    /// 
    /// This initializer handles optional hex strings safely, providing the same
    /// functionality as the non-optional version but with nil safety.
    /// If the hex string is nil, it creates a black color.
    /// 
    /// - Parameter hex: The optional hexadecimal color string
    /// 
    /// Example:
    /// ```swift
    /// let userColor: String? = "#FF0000"
    /// let safeColor = Color(hex: userColor)  // Red color
    /// 
    /// let nilColor: String? = nil
    /// let defaultColor = Color(hex: nilColor) // Black color
    /// ```
    init(hex: String?) {
        if let hex {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
            }

            self.init(
                .sRGB,
                red: Double(r) / 255,
                green: Double(g) / 255,
                blue: Double(b) / 255,
                opacity: Double(a) / 255,
            )
        } else {
            self.init(red: 0, green: 0, blue: 0)
        }
    }
}

// MARK: - Hex String Generation

public extension Color {
    /// Converts the color to its hexadecimal string representation.
    /// 
    /// This function generates a hex string from the color, automatically choosing
    /// between 6-character RGB format (when alpha is 1.0) or 8-character RGBA format
    /// (when alpha is not 1.0).
    /// 
    /// - Returns: A hex string representation of the color with # prefix
    /// 
    /// Example:
    /// ```swift
    /// let red = Color.red
    /// let hex = red.hexString() // "#FF0000"
    /// 
    /// let transparentBlue = Color.blue.opacity(0.5)
    /// let hexWithAlpha = transparentBlue.hexString() // "#0000FF80"
    /// ```
    func hexString() -> String {
        hexStringFromColorComponents(rgba)
    }

    /// Extracts the RGBA components of the color as a tuple.
    /// 
    /// This computed property breaks down the color into its red, green, blue, and alpha
    /// components using the platform's native color representation (UIColor or NSColor).
    /// 
    /// - Returns: A ColorComponentsRGBA tuple with values from 0.0 to 1.0
    /// 
    /// Example:
    /// ```swift
    /// let purple = Color.purple
    /// let components = purple.rgba
    /// print("Red: \(components.red), Alpha: \(components.alpha)")
    /// ```
    var rgba: ColorComponentsRGBA {
        #if canImport(AppKit)
        let color = NSColor(self).usingColorSpace(.displayP3)!
        #elseif canImport(UIKit)
        let color: UIColor = .init(self)
        #endif

        var t = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        color.getRed(&t.0, green: &t.1, blue: &t.2, alpha: &t.3)
        return t
    }
}

// MARK: - Hex Conversion Utilities

/// Converts color components to a hexadecimal string representation.
/// 
/// This function creates a hex string from RGBA color components, automatically
/// choosing the appropriate format based on the alpha value. If alpha is 1.0,
/// it returns a 6-character RGB hex string, otherwise an 8-character RGBA hex string.
/// 
/// - Parameter components: The RGBA color components tuple
/// - Returns: A hex string with # prefix in RGB or RGBA format
/// 
/// Example:
/// ```swift
/// let components: ColorComponentsRGBA = (red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
/// let hex = hexStringFromColorComponents(components) // "#FF0000"
/// ```
public func hexStringFromColorComponents(_ components: ColorComponentsRGBA) -> String {
    // print("hexStringFromColorComponents → \(components)")

    if components.alpha == 1.0 {
        // Color is in hex format without alpha
        let rgb: Int = hexIntFromColorComponents(rgb: components)
        // print("hexString rgb → \(rgb)")

        return String(format: "#%06x", rgb)
    } else {
        // Color is in hex format with alpha
        let rgba: Int = hexIntFromColorComponents(rgba: components)
        // print("hexString rgba → \(rgba)")

        return String(format: "#%08x", rgba)
    }
}

private func hexIntFromColorComponents(rgb components: ColorComponentsRGBA) -> Int {
    let (r, g, b, _) = components
    return Int(r * 255) << 16 | Int(g * 255) << 8 | Int(b * 255) << 0
}

private func hexIntFromColorComponents(rgba components: ColorComponentsRGBA) -> Int {
    let (r, g, b, a) = components
    return Int(r * 255) << 24 | Int(g * 255) << 16 | Int(b * 255) << 8 | Int(a * 255) << 0
}

struct Hex_Preview: PreviewProvider {
    static var previews: some View {
        let green: Color = .init(hex: "#00FF00")

        return Circle()
            .frame(width: 100, height: 100)
            .foregroundColor(green)
    }
}
