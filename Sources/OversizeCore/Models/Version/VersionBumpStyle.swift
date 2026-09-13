//
// Copyright © 2026 Alexander Romanov
// VersionBumpStyle.swift, created on 14.09.2026
//

/// The output shape produced when incrementing a version's major or minor component.
///
/// A ``Version`` stores `minor` and `patch` as optional components, so an incremented
/// version can be rendered either without a trailing patch component or as a complete
/// SemVer triple. Use this style to pick the shape that fits the destination: the short
/// form reads better in user-facing text, while the full form matches SemVer release tags.
///
/// Example:
/// ```swift
/// let version = Version("2.0.1")!
/// version.nextMajor(.short).description // "3.0"
/// version.nextMajor(.full).description  // "3.0.0"
/// version.nextMinor(.short).description // "2.1"
/// version.nextMinor(.full).description  // "2.1.0"
/// ```
public enum VersionBumpStyle: Sendable {
    /// Omits the patch component, producing versions such as `3.0` or `2.1`.
    case short

    /// Includes a zeroed patch component, producing full SemVer versions such as `3.0.0` or `2.1.0`.
    case full
}
