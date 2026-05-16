//
// Copyright © 2026 Alexander Romanov
// VersionTests.swift
//

import Testing
@testable import OversizeCore

// MARK: - Init

@Suite struct VersionInitTests {
    @Test func positionalArgs_storesAllComponents() {
        let version = Version(1, 2, 3)
        #expect(version.major == 1)
        #expect(version.minor == 2)
        #expect(version.patch == 3)
    }

    @Test func majorMinor_patchIsNil() {
        let version = Version(1, 2)
        #expect(version.minor == 2)
        #expect(version.patch == nil)
    }

    @Test func majorOnly_minorAndPatchAreNil() {
        let version = Version(1)
        #expect(version.minor == nil)
        #expect(version.patch == nil)
    }

    @Test func withPrereleaseIdentifiers_storesIdentifiers() {
        let version = Version(1, 0, 0, prereleaseIdentifiers: ["beta", "1"])
        #expect(version.prereleaseIdentifiers == ["beta", "1"])
    }

    @Test func withBuildMetadataIdentifiers_storesIdentifiers() {
        let version = Version(1, 0, 0, buildMetadataIdentifiers: ["sha", "abc"])
        #expect(version.buildMetadataIdentifiers == ["sha", "abc"])
    }
}

// MARK: - Parsing

@Suite struct VersionParsingTests {
    @Test func fullVersionString_parsesAllComponents() {
        let version: Version = "1.0.0"
        #expect(version.major == 1)
        #expect(version.minor == 0)
        #expect(version.patch == 0)
    }

    @Test func twoComponentString_patchIsNil() {
        let version: Version = "1.0"
        #expect(version.minor == 0)
        #expect(version.patch == nil)
    }

    @Test func singleComponentString_minorAndPatchAreNil() {
        let version: Version = "1"
        #expect(version.minor == nil)
        #expect(version.patch == nil)
    }

    @Test func prereleaseString_parsesPrereleaseIdentifiers() {
        let version: Version = "1.0.0-beta.1"
        #expect(version.prereleaseIdentifiers == ["beta", "1"])
        #expect(version.buildMetadataIdentifiers.isEmpty)
    }

    @Test func buildMetadataString_parsesBuildMetadata() {
        let version: Version = "1.0.0+sha.001"
        #expect(version.buildMetadataIdentifiers == ["sha", "001"])
        #expect(version.prereleaseIdentifiers.isEmpty)
    }

    @Test func fullSemVerString_parsesBothIdentifiers() {
        let version: Version = "1.0.0-beta.1+sha.001"
        #expect(version.prereleaseIdentifiers == ["beta", "1"])
        #expect(version.buildMetadataIdentifiers == ["sha", "001"])
    }

    // Failable init tests — use String variables to bypass ExpressibleByStringLiteral

    @Test func nonNumericString_returnsNil() {
        let str: String = "abc"
        #expect(Version(str) == nil)
    }

    @Test func emptyString_returnsNil() {
        let str: String = ""
        #expect(Version(str) == nil)
    }

    @Test func fourComponentString_returnsNil() {
        let str: String = "1.2.3.4"
        #expect(Version(str) == nil)
    }

    @Test func negativeMajor_returnsNil() {
        let str: String = "-1.0.0"
        #expect(Version(str) == nil)
    }

    @Test func emptyPrereleaseSection_returnsNil() {
        let str: String = "1.2.3-"
        #expect(Version(str) == nil)
    }

    @Test func emptyBuildMetadataSection_returnsNil() {
        let str: String = "1.2.3+"
        #expect(Version(str) == nil)
    }

    @Test func doubleDotInPrerelease_returnsNil() {
        let str: String = "1.2.3-alpha..1"
        #expect(Version(str) == nil)
    }
}

// MARK: - description

@Suite struct VersionDescriptionTests {
    @Test func majorOnly_returnsSingleComponent() {
        #expect(Version(1).description == "1")
    }

    @Test func majorMinor_returnsTwoComponents() {
        #expect(Version(1, 0).description == "1.0")
    }

    @Test func majorMinorPatch_returnsThreeComponents() {
        #expect(Version(1, 0, 0).description == "1.0.0")
    }

    @Test func withPrerelease_includesPrereleaseIdentifiers() {
        let version = Version(1, 0, 0, prereleaseIdentifiers: ["beta", "1"])
        #expect(version.description == "1.0.0-beta.1")
    }

    @Test func withBuildMetadata_includesBuildMetadata() {
        let version = Version(1, 0, 0, buildMetadataIdentifiers: ["sha", "001"])
        #expect(version.description == "1.0.0+sha.001")
    }

    @Test func withBothIdentifiers_includesBoth() {
        let version = Version(1, 0, 0, prereleaseIdentifiers: ["beta", "1"], buildMetadataIdentifiers: ["sha"])
        #expect(version.description == "1.0.0-beta.1+sha")
    }

    @Test func roundTripThroughDescription_preservesVersion() throws {
        let original = Version(1, 2, 3, prereleaseIdentifiers: ["rc", "1"], buildMetadataIdentifiers: ["abc"])
        let reparsed = try #require(Version(original.description))
        #expect(reparsed == original)
    }
}

// MARK: - Hashable

@Suite struct VersionHashableTests {
    @Test func equalVersions_haveSameHash() {
        #expect(Version(1).hashValue == Version(1, 0).hashValue)
        #expect(Version(1, 0).hashValue == Version(1, 0, 0).hashValue)
    }

    @Test func buildMetadata_doesNotAffectHash() {
        let v1 = Version(1, 0, 0, buildMetadataIdentifiers: ["abc"])
        let v2 = Version(1, 0, 0, buildMetadataIdentifiers: ["xyz"])
        #expect(v1.hashValue == v2.hashValue)
    }

    @Test func differentPrerelease_notDedupedInSet() {
        let versions: Set<Version> = [
            Version(1, 0, 0, prereleaseIdentifiers: ["alpha"]),
            Version(1, 0, 0, prereleaseIdentifiers: ["beta"]),
        ]
        #expect(versions.count == 2)
    }

    @Test func usableInSet() {
        let versions: Set<Version> = [
            Version(1, 0, 0),
            Version(1, 0, 0, buildMetadataIdentifiers: ["abc"]),
            Version(1, 0, 0, buildMetadataIdentifiers: ["xyz"]),
            Version(2, 0, 0),
        ]
        #expect(versions.count == 2)
    }
}

// MARK: - Equatable

@Suite struct VersionEquatableTests {
    @Test func nilMinorEqualsZeroMinor() {
        #expect(Version(1) == Version(1, 0))
    }

    @Test func nilPatchEqualsZeroPatch() {
        #expect(Version(1, 0) == Version(1, 0, 0))
    }

    @Test func sameFullVersion_isEqual() {
        #expect(Version(1, 0, 0) == Version(1, 0, 0))
    }

    @Test func differentMajor_isNotEqual() {
        #expect(Version(1, 0, 0) != Version(2, 0, 0))
    }

    @Test func releaseAndPrerelease_isNotEqual() {
        #expect(Version(1, 0, 0) != Version(1, 0, 0, prereleaseIdentifiers: ["alpha"]))
    }
}

// MARK: - Comparable

@Suite struct VersionComparableTests {
    @Test func lowerMajor_isLess() {
        #expect(Version(1, 0) < Version(2, 0))
    }

    @Test func lowerMinor_isLess() {
        #expect(Version(1, 0) < Version(1, 1))
    }

    @Test func lowerPatch_isLess() {
        #expect(Version(1, 0, 0) < Version(1, 0, 1))
    }

    @Test func releaseGreaterThanPrerelease() {
        #expect(Version(1, 0, 0) > Version(1, 0, 0, prereleaseIdentifiers: ["alpha"]))
    }

    @Test func semVerPrecedenceChainIsOrdered() {
        let versions: [Version] = [
            "1.0.0-alpha",
            "1.0.0-alpha.1",
            "1.0.0-alpha.beta",
            "1.0.0-beta",
            "1.0.0-beta.2",
            "1.0.0-beta.11",
            "1.0.0-rc.1",
            "1.0.0",
        ]
        for index in versions.indices.dropFirst() {
            #expect(versions[index - 1] < versions[index])
        }
    }

    @Test func numericIdentifierComparedNumerically() throws {
        let s2: String = "1.0.0-beta.2"
        let s11: String = "1.0.0-beta.11"
        let v2 = try #require(Version(s2))
        let v11 = try #require(Version(s11))
        #expect(v2 < v11)
    }

    @Test func numericIdentifierLessThanAlphanumeric() throws {
        let sNumeric: String = "1.0.0-1"
        let sAlpha: String = "1.0.0-alpha"
        let numeric = try #require(Version(sNumeric))
        let alpha = try #require(Version(sAlpha))
        #expect(numeric < alpha)
    }

    @Test func sameIntValueDifferentString_orderedByString() {
        let v01 = Version(1, 0, 0, prereleaseIdentifiers: ["01"])
        let v1 = Version(1, 0, 0, prereleaseIdentifiers: ["1"])
        #expect(v01 != v1)
        #expect(v01 < v1 || v1 < v01)
    }
}

// MARK: - Helper properties

@Suite struct VersionHelperTests {
    @Test func isFirstVersion_version100_returnsTrue() {
        #expect(Version(1, 0, 0).isFirstVersion)
    }

    @Test func isFirstVersion_version1_returnsTrue() {
        #expect(Version(1).isFirstVersion)
    }

    @Test func isFirstVersion_version2_returnsFalse() {
        #expect(!Version(2).isFirstVersion)
    }

    @Test func isMajor_zeroMinorAndPatch_returnsTrue() {
        #expect(Version(2, 0).isMajor)
    }

    @Test func isMinor_nonZeroMinor_returnsTrue() {
        #expect(Version(1, 1).isMinor)
    }

    @Test func isPatch_nonZeroPatch_returnsTrue() {
        #expect(Version(1, 0, 1).isPatch)
    }
}

// MARK: - Increment

@Suite struct VersionIncrementTests {
    @Test func nextMajor_returnsNextMajor() {
        #expect(Version(1, 0, 0).nextMajor().description == "2")
    }

    @Test func nextMinor_returnsNextMinor() {
        #expect(Version(1, 0, 0).nextMinor().description == "1.1")
    }

    @Test func nextPatch_returnsNextPatch() {
        #expect(Version(1, 0, 0).nextPatch().description == "1.0.1")
    }

    @Test func nextPatch_fromMajorOnly_returnsFullVersion() {
        #expect(Version(1).nextPatch().description == "1.0.1")
    }

    @Test func nextPatch_fromPrerelease_appendsZeroIdentifier() {
        let v = Version(1, 0, 0, prereleaseIdentifiers: ["beta", "1"])
        #expect(v.nextPatch().description == "1.0.0-beta.1.0")
    }
}

// MARK: - Range extensions

@Suite struct VersionRangeTests {
    @Test func upToNextMajor_containsVersionsBeforeNextMajor() {
        let range = Range<Version>.upToNextMajor(from: Version(1, 2, 3))
        #expect(range.contains(Version(1, 9, 9)))
    }

    @Test func upToNextMajor_excludesNextMajorVersion() {
        let range = Range<Version>.upToNextMajor(from: Version(1, 2, 3))
        #expect(!range.contains(Version(2, 0, 0)))
    }

    @Test func upToNextMinor_containsVersionsBeforeNextMinor() {
        let range = Range<Version>.upToNextMinor(from: Version(1, 2, 3))
        #expect(range.contains(Version(1, 2, 9)))
    }

    @Test func upToNextMinor_excludesNextMinorVersion() {
        let range = Range<Version>.upToNextMinor(from: Version(1, 2, 3))
        #expect(!range.contains(Version(1, 3, 0)))
    }
}
