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
#endif
