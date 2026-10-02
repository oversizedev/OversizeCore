//
// Copyright © 2026 Alexander Romanov
// PlatformImage.swift, created on 28.09.2026
//

#if canImport(UIKit)
import UIKit

/// The native image type of the current platform.
///
/// Resolves to `UIImage` on iOS, tvOS, watchOS and visionOS and to `NSImage` on macOS,
/// so shared code can hold a native image without platform conditionals.
///
/// Example:
/// ```swift
/// struct Form: Equatable {
///     var image: PlatformImage?
/// }
///
/// let image = PlatformImage(data: data)
/// let jpeg = image?.jpegData(compressionQuality: 0.5)
/// ```
public typealias PlatformImage = UIImage
#elseif canImport(AppKit)
import AppKit

/// The native image type of the current platform.
///
/// Resolves to `UIImage` on iOS, tvOS, watchOS and visionOS and to `NSImage` on macOS,
/// so shared code can hold a native image without platform conditionals.
///
/// Example:
/// ```swift
/// struct Form: Equatable {
///     var image: PlatformImage?
/// }
///
/// let image = PlatformImage(data: data)
/// let jpeg = image?.jpegData(compressionQuality: 0.5)
/// ```
public typealias PlatformImage = NSImage
#endif

#if canImport(SwiftUI) && (canImport(UIKit) || canImport(AppKit))
import SwiftUI

public extension Image {
    /// Creates a SwiftUI image from the native image of the current platform.
    ///
    /// Wraps `Image(uiImage:)` on UIKit platforms and `Image(nsImage:)` on macOS.
    ///
    /// - Parameter platformImage: The native image to display.
    ///
    /// Example:
    /// ```swift
    /// if let platformImage = PlatformImage(data: data) {
    ///     Image(platformImage: platformImage)
    ///         .resizable()
    /// }
    /// ```
    init(platformImage: PlatformImage) {
        #if canImport(UIKit)
        self.init(uiImage: platformImage)
        #else
        self.init(nsImage: platformImage)
        #endif
    }
}
#endif
