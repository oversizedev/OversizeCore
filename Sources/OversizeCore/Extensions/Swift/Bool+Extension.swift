//
// Copyright © 2025 Alexander Romanov
// Bool+Extension.swift, created on 15.06.2025
//

import Foundation

// MARK: - iOS Version Availability Checks

public extension Bool {
    /// Indicates whether the app is running on iOS 16 or later.
    ///
    /// This static computed property provides a convenient way to check iOS version
    /// availability for features that require iOS 16 or later. Returns true if the
    /// current iOS version is 16.0 or higher.
    ///
    /// - Returns: `true` if running on iOS 16+, `false` otherwise
    ///
    /// Example:
    /// ```swift
    /// if Bool.iOS16 {
    ///     // Use iOS 16+ features
    ///     configureNewFeatures()
    /// } else {
    ///     // Fallback for older iOS versions
    ///     configureCompatibilityMode()
    /// }
    /// ```
    static var iOS16: Bool {
        if #available(iOS 16, *) {
            true
        } else {
            false
        }
    }

    /// Indicates whether the app is running on iOS 17 or later.
    ///
    /// This static computed property provides a convenient way to check iOS version
    /// availability for features that require iOS 17 or later. Returns true if the
    /// current iOS version is 17.0 or higher.
    ///
    /// - Returns: `true` if running on iOS 17+, `false` otherwise
    ///
    /// Example:
    /// ```swift
    /// if Bool.iOS17 {
    ///     // Use iOS 17+ features
    ///     enableAdvancedUI()
    /// }
    /// ```
    static var iOS17: Bool {
        if #available(iOS 17, *) {
            true
        } else {
            false
        }
    }

    /// Indicates whether the app is running on iOS 18 or later.
    ///
    /// This static computed property provides a convenient way to check iOS version
    /// availability for features that require iOS 18 or later. Returns true if the
    /// current iOS version is 18.0 or higher.
    ///
    /// - Returns: `true` if running on iOS 18+, `false` otherwise
    ///
    /// Example:
    /// ```swift
    /// if Bool.iOS18 {
    ///     // Use iOS 18+ features
    ///     setupLatestFeatures()
    /// }
    /// ```
    static var iOS18: Bool {
        if #available(iOS 18, *) {
            true
        } else {
            false
        }
    }

    /// Indicates whether the app is running on iOS 26 or later.
    ///
    /// This static computed property provides a convenient way to check iOS version
    /// availability for features that require iOS 26 or later. Returns true if the
    /// current iOS version is 26.0 or higher.
    ///
    /// - Returns: `true` if running on iOS 26+, `false` otherwise
    ///
    /// Example:
    /// ```swift
    /// if Bool.iOS26 {
    ///     // Use future iOS 26+ features
    ///     enableFutureFeatures()
    /// }
    /// ```
    ///
    /// - Note: This is a forward-looking availability check for future iOS versions.
    static var iOS26: Bool {
        if #available(iOS 26, *) {
            true
        } else {
            false
        }
    }
}
