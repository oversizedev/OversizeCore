//
// Copyright © 2026 Alexander Romanov
// ViewExtensionTests.swift
//

#if os(iOS)
@testable import OversizeCore
import SwiftUI
import Testing
import UIKit

@MainActor
struct ViewExtensionTests {
    @Test func renderedImage_matchesViewBounds() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        view.backgroundColor = .red
        #expect(view.renderedImage.size == CGSize(width: 40, height: 20))
    }

    @Test func renderedImage_withZeroBounds_returnsEmptyImage() {
        let view = UIView(frame: .zero)
        #expect(view.renderedImage.size == .zero)
    }

    @Test func takeScreenshot_matchesRequestedSize() {
        let size = CGSize(width: 50, height: 30)
        let image = Color.red.frame(width: size.width, height: size.height).takeScreenshot(origin: .zero, size: size)
        #expect(image.size == size)
    }
}
#endif
