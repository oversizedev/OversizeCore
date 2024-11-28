//
// Copyright © 2024 Alexander Romanov
// NSImage+Extension.swift, created on 27.06.2024
//

#if canImport(AppKit)
import AppKit
#endif

#if canImport(AppKit)
public extension NSImage {
    func pngData() -> Data? {
        guard let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            return nil
        }

        let bitmapRepresentation = NSBitmapImageRep(cgImage: cgImage)
        return bitmapRepresentation.representation(using: .png, properties: [:])
    }
}

public extension NSImage {
    func jpegData(compressionQuality _: CGFloat) -> Data? {
        guard let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            return nil
        }

        let bitmapRepresentation = NSBitmapImageRep(cgImage: cgImage)
        return bitmapRepresentation.representation(using: .jpeg, properties: [:])
    }

    func jpegData() -> Data? {
        guard let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            return nil
        }

        let bitmapRepresentation = NSBitmapImageRep(cgImage: cgImage)
        return bitmapRepresentation.representation(using: .jpeg, properties: [:])
    }
}

public extension NSImage {
    var cgImage: CGImage? {
        cgImage(forProposedRect: nil, context: nil, hints: nil)
    }
}

public extension NSImage {
    var averageColor: NSColor? {
        guard let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil) else { return nil }
        let inputImage = CIImage(cgImage: cgImage)

        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return NSColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}

#endif
