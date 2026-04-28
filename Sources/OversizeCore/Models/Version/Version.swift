//
// Copyright © 2026 Alexander Romanov
// Version.swift, created on 20.04.2026
//

import Foundation

public struct Version: Comparable, Sendable {
    public let major: Int
    public let minor: Int
    public let patch: Int?

    public init(_ major: Int, _ minor: Int, _ patch: Int? = nil) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }

    public init?(_ version: String) {
        let segments = version.split(separator: ".")
        let parts = segments.compactMap { Int($0) }
        guard parts.count == segments.count, parts.count >= 2 else { return nil }
        major = parts[0]
        minor = parts[1]
        patch = parts.count > 2 ? parts[2] : nil
    }

    public var stringValue: String {
        if let patch {
            "\(major).\(minor).\(patch)"
        } else {
            "\(major).\(minor)"
        }
    }

    public static func < (lhs: Version, rhs: Version) -> Bool {
        if lhs.major != rhs.major { return lhs.major < rhs.major }
        if lhs.minor != rhs.minor { return lhs.minor < rhs.minor }
        return (lhs.patch ?? 0) < (rhs.patch ?? 0)
    }

    public var isFirstVersion: Bool {
        major == 1 && minor == 0 && (patch == nil || patch == 0)
    }

    public var isMajor: Bool {
        minor == 0 && (patch == nil || patch == 0)
    }

    public var isMinor: Bool {
        minor != 0 && (patch == nil || patch == 0)
    }

    public var isPatch: Bool {
        (patch ?? 0) != 0
    }

    public func incrementMajor() -> Version {
        Version(major + 1, 0, 0)
    }

    public func incrementMinor() -> Version {
        Version(major, minor + 1, 0)
    }

    public func incrementPatch() -> Version {
        Version(major, minor, (patch ?? 0) + 1)
    }
}

extension Version: Equatable {
    public static func == (lhs: Version, rhs: Version) -> Bool {
        lhs.major == rhs.major && lhs.minor == rhs.minor && (lhs.patch ?? 0) == (rhs.patch ?? 0)
    }
}

extension Version: CustomStringConvertible {
    public var description: String {
        stringValue
    }
}
