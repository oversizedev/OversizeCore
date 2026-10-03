//
// Copyright © 2026 Alexander Romanov
// PlatformImageTests.swift
//

#if canImport(SwiftUI) && (canImport(UIKit) || canImport(AppKit))
import Foundation
@testable import OversizeCore
import SwiftUI
import Testing

struct PlatformImageTests {
    @Test func initFromData_withValidPNG_returnsImage() throws {
        let data = try #require(TestImage.pngData())
        #expect(PlatformImage(data: data) != nil)
    }

    @Test func initFromData_withInvalidData_returnsNil() {
        #expect(PlatformImage(data: Data("not an image".utf8)) == nil)
    }

    @Test func imageInitFromPlatformImage_matchesNativeInitializer() throws {
        let platformImage = try #require(TestImage.make())
        let image = Image(platformImage: platformImage)
        #if canImport(UIKit)
        #expect(image == Image(uiImage: platformImage))
        #else
        #expect(image == Image(nsImage: platformImage))
        #endif
    }
}
#endif
