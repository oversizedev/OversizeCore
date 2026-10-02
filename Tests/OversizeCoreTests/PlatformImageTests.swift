//
// Copyright © 2026 Alexander Romanov
// PlatformImageTests.swift
//

#if canImport(SwiftUI) && (canImport(UIKit) || canImport(AppKit))
import CoreGraphics
import Foundation
@testable import OversizeCore
import SwiftUI
import Testing

struct PlatformImageTests {
    @Test func initFromData_withValidPNG_returnsImage() throws {
        let data = try #require(Self.pngData())
        #expect(PlatformImage(data: data) != nil)
    }

    @Test func initFromData_withInvalidData_returnsNil() {
        #expect(PlatformImage(data: Data("not an image".utf8)) == nil)
    }

    @Test func imageInitFromData_withValidPNG_returnsImage() throws {
        let data = try #require(Self.pngData())
        #expect(Image(data: data) != nil)
    }

    @Test func imageInitFromPlatformImage_matchesNativeInitializer() throws {
        let platformImage = try #require(Self.makeImage())
        let image = Image(platformImage: platformImage)
        #if canImport(UIKit)
        #expect(image == Image(uiImage: platformImage))
        #else
        #expect(image == Image(nsImage: platformImage))
        #endif
    }
}

private extension PlatformImageTests {
    static func makeImage(size: Int = 8) -> PlatformImage? {
        let context = CGContext(
            data: nil,
            width: size,
            height: size,
            bitsPerComponent: 8,
            bytesPerRow: size * 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue,
        )
        context?.setFillColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)
        context?.fill(CGRect(x: 0, y: 0, width: size, height: size))
        guard let cgImage = context?.makeImage() else { return nil }
        #if canImport(UIKit)
        return PlatformImage(cgImage: cgImage)
        #else
        return PlatformImage(cgImage: cgImage, size: NSSize(width: size, height: size))
        #endif
    }

    static func pngData() -> Data? {
        makeImage()?.pngData()
    }
}
#endif
