//
// Copyright © 2026 Alexander Romanov
// TestImage.swift
//

#if canImport(UIKit) || canImport(AppKit)
import CoreGraphics
import Foundation
@testable import OversizeCore

enum TestImage {
    static func make(size: Int = 8) -> PlatformImage? {
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
        return PlatformImage(cgImage: cgImage, size: CGSize(width: size, height: size))
        #endif
    }

    static func pngData() -> Data? {
        make()?.pngData()
    }
}
#endif
