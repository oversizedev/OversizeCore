//
// Copyright © 2026 Alexander Romanov
// Version.swift, created on 20.04.2026
//

public struct Version: Sendable {
    public let major: Int
    public let minor: Int?
    public let patch: Int?
    public let prereleaseIdentifiers: [String]
    public let buildMetadataIdentifiers: [String]

    public init(
        _ major: Int,
        _ minor: Int? = nil,
        _ patch: Int? = nil,
        prereleaseIdentifiers: [String] = [],
        buildMetadataIdentifiers: [String] = [],
    ) {
        precondition(major >= 0, "major must be non-negative")
        if let minor { precondition(minor >= 0, "minor must be non-negative") }
        if let patch { precondition(patch >= 0, "patch must be non-negative") }
        self.major = major
        self.minor = minor
        self.patch = patch
        self.prereleaseIdentifiers = prereleaseIdentifiers
        self.buildMetadataIdentifiers = buildMetadataIdentifiers
    }
}

// MARK: - LosslessStringConvertible

extension Version: LosslessStringConvertible {
    public init?(_ versionString: String) {
        var remainder = versionString

        var buildMetadata: [String] = []
        if let plusIndex = remainder.firstIndex(of: "+") {
            let buildPart = String(remainder[remainder.index(after: plusIndex)...])
            guard !buildPart.isEmpty else { return nil }
            let segments = buildPart.split(separator: ".", omittingEmptySubsequences: false).map(String.init)
            guard !segments.contains("") else { return nil }
            buildMetadata = segments
            remainder = String(remainder[..<plusIndex])
        }

        var prerelease: [String] = []
        if let dashIndex = remainder.firstIndex(of: "-") {
            let prereleasePart = String(remainder[remainder.index(after: dashIndex)...])
            guard !prereleasePart.isEmpty else { return nil }
            let segments = prereleasePart.split(separator: ".", omittingEmptySubsequences: false).map(String.init)
            guard !segments.contains("") else { return nil }
            prerelease = segments
            remainder = String(remainder[..<dashIndex])
        }

        let parts = remainder.split(separator: ".", omittingEmptySubsequences: false)
        guard !parts.isEmpty, parts.count <= 3 else { return nil }
        guard let majorValue = Int(parts[0]), majorValue >= 0 else { return nil }

        var minorValue: Int?
        var patchValue: Int?

        if parts.count >= 2 {
            guard let parsed = Int(parts[1]), parsed >= 0 else { return nil }
            minorValue = parsed
        }
        if parts.count == 3 {
            guard let parsed = Int(parts[2]), parsed >= 0 else { return nil }
            patchValue = parsed
        }

        self.init(
            majorValue,
            minorValue,
            patchValue,
            prereleaseIdentifiers: prerelease,
            buildMetadataIdentifiers: buildMetadata,
        )
    }

    public var description: String {
        var result = "\(major)"
        if let minor {
            result += ".\(minor)"
            if let patch {
                result += ".\(patch)"
            }
        }
        if !prereleaseIdentifiers.isEmpty {
            result += "-" + prereleaseIdentifiers.joined(separator: ".")
        }
        if !buildMetadataIdentifiers.isEmpty {
            result += "+" + buildMetadataIdentifiers.joined(separator: ".")
        }
        return result
    }
}

// MARK: - ExpressibleByStringLiteral

extension Version: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public typealias ExtendedGraphemeClusterLiteralType = String
    public typealias UnicodeScalarLiteralType = String

    public init(stringLiteral value: String) {
        guard let version = Version(value) else {
            fatalError("Invalid version string: \(value)")
        }
        self = version
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }

    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}

// MARK: - Equatable & Hashable

extension Version: Equatable {
    public static func == (lhs: Version, rhs: Version) -> Bool {
        lhs.major == rhs.major && (lhs.minor ?? 0) == (rhs.minor ?? 0) && (lhs.patch ?? 0) == (rhs.patch ?? 0) && lhs.prereleaseIdentifiers == rhs.prereleaseIdentifiers
    }
}

extension Version: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(major)
        hasher.combine(minor ?? 0)
        hasher.combine(patch ?? 0)
        hasher.combine(prereleaseIdentifiers)
    }
}

// MARK: - Comparable

extension Version: Comparable {
    public static func < (lhs: Version, rhs: Version) -> Bool {
        let lhsComponents = (lhs.major, lhs.minor ?? 0, lhs.patch ?? 0)
        let rhsComponents = (rhs.major, rhs.minor ?? 0, rhs.patch ?? 0)

        if lhsComponents.0 != rhsComponents.0 { return lhsComponents.0 < rhsComponents.0 }
        if lhsComponents.1 != rhsComponents.1 { return lhsComponents.1 < rhsComponents.1 }
        if lhsComponents.2 != rhsComponents.2 { return lhsComponents.2 < rhsComponents.2 }

        switch (lhs.prereleaseIdentifiers.isEmpty, rhs.prereleaseIdentifiers.isEmpty) {
        case (true, false): return false
        case (false, true): return true
        default: break
        }

        for (lhsId, rhsId) in zip(lhs.prereleaseIdentifiers, rhs.prereleaseIdentifiers) {
            if lhsId == rhsId { continue }
            switch (Int(lhsId), Int(rhsId)) {
            case let (lhsInt?, rhsInt?):
                if lhsInt != rhsInt { return lhsInt < rhsInt }
                return lhsId < rhsId
            case (nil, _?): return false
            case (_?, nil): return true
            default: return lhsId < rhsId
            }
        }

        return lhs.prereleaseIdentifiers.count < rhs.prereleaseIdentifiers.count
    }
}

// MARK: - Version helpers

public extension Version {
    var isFirstVersion: Bool {
        major == 1 && (minor ?? 0) == 0 && (patch ?? 0) == 0
    }

    var isMajor: Bool {
        (minor ?? 0) == 0 && (patch ?? 0) == 0
    }

    var isMinor: Bool {
        (minor ?? 0) != 0 && (patch ?? 0) == 0
    }

    var isPatch: Bool {
        (patch ?? 0) != 0
    }

    func nextMajor() -> Version {
        Version(major + 1, 0)
    }

    func nextMinor() -> Version {
        Version(major, (minor ?? 0) + 1)
    }

    func nextPatch() -> Version {
        if prereleaseIdentifiers.isEmpty {
            Version(major, minor ?? 0, (patch ?? 0) + 1)
        } else {
            Version(major, minor ?? 0, patch ?? 0, prereleaseIdentifiers: prereleaseIdentifiers + ["0"])
        }
    }
}

// MARK: - Range extensions

public extension Range where Bound == Version {
    static func upToNextMajor(from version: Version) -> Range<Version> {
        version ..< Version(version.major + 1)
    }

    static func upToNextMinor(from version: Version) -> Range<Version> {
        version ..< Version(version.major, (version.minor ?? 0) + 1)
    }
}
