//
// Copyright © 2026 Alexander Romanov
// TestImage.swift
//

#if canImport(CoreGraphics)
import CoreGraphics
import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

enum TestImage {
    static func cgImage(size: Int = 8) -> CGImage? {
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
        return context?.makeImage()
    }

    #if canImport(UIKit)
    static func make(size: Int = 8) -> UIImage {
        guard let cgImage = cgImage(size: size) else { return UIImage() }
        return UIImage(cgImage: cgImage)
    }
    #elseif canImport(AppKit)
    static func make(size: Int = 8) -> NSImage {
        guard let cgImage = cgImage(size: size) else { return NSImage() }
        return NSImage(cgImage: cgImage, size: NSSize(width: size, height: size))
    }
    #endif

    static func pngData() -> Data? {
        #if canImport(UIKit)
        make().pngData()
        #elseif canImport(AppKit)
        make().pngData()
        #else
        nil
        #endif
    }
}
#endif
