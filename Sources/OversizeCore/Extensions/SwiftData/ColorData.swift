//
// Copyright © 2024 Alexander Romanov
// ColorData.swift, created on 13.06.2024
//

#if canImport(SwiftUI)
import SwiftUI

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
        let components = color.cgColor?.components ?? []

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
}

// MARK: - ExpressibleByStringLiteral

extension ColorData: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let clean = value.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        self.init(color: [3, 6, 8].contains(clean.count) ? Color(hex: value) : .black)
    }
}
#endif
