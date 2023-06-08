//
// Copyright © 2023 Alexander Romanov
// File.swift, created on 24.05.2023
//

import SwiftUI

public struct DebugOverlayModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .overlay(Color.random(randomOpacity: true))
    }
}

public extension View {
    func debugOverlay() -> some View {
        modifier(DebugOverlayModifier())
    }
}
