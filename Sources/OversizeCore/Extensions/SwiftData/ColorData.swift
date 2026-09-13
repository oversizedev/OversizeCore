//
// Copyright © 2024 Alexander Romanov
// ColorData.swift, created on 13.06.2024
//

#if canImport(SwiftUI)
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public struct ColorData: Codable, Equatable, Hashable, Sendable {
    private var red: Double = 1
    private var green: Double = 1
    private var blue: Double = 1
    private var opacity: Double = 1

    public var color: Color {
        Color(red: red, green: green, blue: blue, opacity: opacity)
    }

    public init(red: Double, green: Double, blue: Double, opacity: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }

    public init(color: Color) {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
            let resolved = color.resolve(in: EnvironmentValues())
            red = Double(resolved.red)
            green = Double(resolved.green)
            blue = Double(resolved.blue)
            opacity = Double(resolved.opacity)
            clampComponents()
            return
        }

        #if canImport(UIKit)
        var uiRed: CGFloat = 0
        var uiGreen: CGFloat = 0
        var uiBlue: CGFloat = 0
        var uiOpacity: CGFloat = 0

        #if os(watchOS)
        // watchOS has no `resolvedColor(with:)` API; fall back to resolving against
        // whatever appearance is ambient at call time.
        let uiColor = UIColor(color)
        #else
        // Resolve against a fixed light trait collection instead of `UITraitCollection.current`
        // so this stays deterministic and independent of ambient UI state — this initializer is
        // a plain nonisolated function and can be called from arbitrary actor contexts.
        let uiColor = UIColor(color).resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        #endif

        if uiColor.getRed(&uiRed, green: &uiGreen, blue: &uiBlue, alpha: &uiOpacity) {
            red = Double(uiRed)
            green = Double(uiGreen)
            blue = Double(uiBlue)
            opacity = Double(uiOpacity)
            clampComponents()
            return
        }
        #elseif canImport(AppKit)
        // AppKit has no clean equivalent to `resolvedColor(with:)`, so this resolves against
        // `NSAppearance.current` (best-effort, ambient-state dependent). Acceptable here since
        // AppKit code always runs where an appearance context is meaningful, unlike a background
        // actor on other Apple platforms sharing this package.
        if let sRGBColor = NSColor(color).usingColorSpace(.sRGB) {
            red = Double(sRGBColor.redComponent)
            green = Double(sRGBColor.greenComponent)
            blue = Double(sRGBColor.blueComponent)
            opacity = Double(sRGBColor.alphaComponent)
            clampComponents()
            return
        }
        #endif

        // Last-resort fallback for the rare case where the platform-native conversion
        // above is unavailable or fails outright (e.g. a pattern-based CGColor with no
        // native UIColor/NSColor representation). Grayscale color spaces report 2
        // components (white, alpha); everything else is treated as RGB(A).
        let components = color.cgColor?.components ?? []
        if components.count == 2 {
            red = Double(components[0])
            green = Double(components[0])
            blue = Double(components[0])
            opacity = Double(components[1])
        } else {
            if components.count > 0 {
                red = Double(components[0])
            }

            if components.count > 1 {
                green = Double(components[1])
            }

            if components.count > 2 {
                blue = Double(components[2])
            }

            if components.count > 3 {
                opacity = Double(components[3])
            }
        }
        clampComponents()
    }

    private mutating func clampComponents() {
        red = red.clamped(to: 0 ... 1)
        green = green.clamped(to: 0 ... 1)
        blue = blue.clamped(to: 0 ... 1)
        opacity = opacity.clamped(to: 0 ... 1)
    }
}

private extension Double {
    func clamped(to range: ClosedRange<Double>) -> Double {
        Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }
}

// MARK: - ExpressibleByStringLiteral

extension ColorData: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let clean = value.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        self.init(color: [3, 6, 8].contains(clean.count) ? Color(hex: value) : .black)
    }
}
#endif
