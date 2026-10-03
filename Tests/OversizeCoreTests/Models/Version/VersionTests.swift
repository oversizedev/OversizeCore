//
// Copyright © 2026 Alexander Romanov
// VersionTests.swift
//

@testable import OversizeCore
import Testing

// MARK: - Init

struct VersionInitTests {
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

struct VersionParsingTests {
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

    @Test func nonNumericString_returnsNil() {
        let rawValue = "abc"
        #expect(Version(rawValue) == nil)
    }

    @Test func emptyString_returnsNil() {
        let rawValue = ""
        #expect(Version(rawValue) == nil)
    }

    @Test func fourComponentString_returnsNil() {
        let rawValue = "1.2.3.4"
        #expect(Version(rawValue) == nil)
    }

    @Test func negativeMajor_returnsNil() {
        let rawValue = "-1.0.0"
        #expect(Version(rawValue) == nil)
    }

    @Test func emptyPrereleaseSection_returnsNil() {
        let rawValue = "1.2.3-"
        #expect(Version(rawValue) == nil)
    }

    @Test func emptyBuildMetadataSection_returnsNil() {
        let rawValue = "1.2.3+"
        #expect(Version(rawValue) == nil)
    }

    @Test func doubleDotInPrerelease_returnsNil() {
        let rawValue = "1.2.3-alpha..1"
        #expect(Version(rawValue) == nil)
    }
}

// MARK: - description

struct VersionDescriptionTests {
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

struct VersionHashableTests {
    @Test func equalVersions_haveSameHash() {
        #expect(Version(1).hashValue == Version(1, 0).hashValue)
        #expect(Version(1, 0).hashValue == Version(1, 0, 0).hashValue)
    }

    @Test func buildMetadata_doesNotAffectHash() {
        let first = Version(1, 0, 0, buildMetadataIdentifiers: ["abc"])
        let second = Version(1, 0, 0, buildMetadataIdentifiers: ["xyz"])
        #expect(first.hashValue == second.hashValue)
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

struct VersionEquatableTests {
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

struct VersionComparableTests {
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
        let betaTwoString = "1.0.0-beta.2"
        let betaElevenString = "1.0.0-beta.11"
        let betaTwo = try #require(Version(betaTwoString))
        let betaEleven = try #require(Version(betaElevenString))
        #expect(betaTwo < betaEleven)
    }

    @Test func numericIdentifierLessThanAlphanumeric() throws {
        let numericString = "1.0.0-1"
        let alphaString = "1.0.0-alpha"
        let numeric = try #require(Version(numericString))
        let alpha = try #require(Version(alphaString))
        #expect(numeric < alpha)
    }

    @Test func sameIntValueDifferentString_orderedByString() {
        let zeroPadded = Version(1, 0, 0, prereleaseIdentifiers: ["01"])
        let plain = Version(1, 0, 0, prereleaseIdentifiers: ["1"])
        #expect(zeroPadded != plain)
        #expect(zeroPadded < plain)
    }
}

// MARK: - Helper properties

struct VersionHelperTests {
    @Test func isFirstVersion_version100_returnsTrue() {
        #expect(Version(1, 0, 0).isFirstVersion)
    }

    @Test func isFirstVersion_version1_returnsTrue() {
        #expect(Version(1).isFirstVersion)
    }

    @Test func isFirstVersion_version2_returnsFalse() {
        #expect(!Version(2).isFirstVersion)
    }

    @Test func isFirstVersion_version101_returnsFalse() {
        #expect(!Version(1, 0, 1).isFirstVersion)
    }

    @Test func isMajor_zeroMinorAndPatch_returnsTrue() {
        #expect(Version(2, 0).isMajor)
    }

    @Test(arguments: [Version(2, 1), Version(2, 0, 1)])
    func isMajor_nonZeroMinorOrPatch_returnsFalse(_ version: Version) {
        #expect(!version.isMajor)
    }

    @Test func isMinor_nonZeroMinor_returnsTrue() {
        #expect(Version(1, 1).isMinor)
    }

    @Test(arguments: [Version(1, 0), Version(1, 1, 1)])
    func isMinor_zeroMinorOrNonZeroPatch_returnsFalse(_ version: Version) {
        #expect(!version.isMinor)
    }

    @Test func isPatch_nonZeroPatch_returnsTrue() {
        #expect(Version(1, 0, 1).isPatch)
    }

    @Test(arguments: [Version(1), Version(1, 1), Version(1, 1, 0)])
    func isPatch_zeroOrMissingPatch_returnsFalse(_ version: Version) {
        #expect(!version.isPatch)
    }
}

// MARK: - Increment

struct VersionIncrementTests {
    @Test func nextMajor_returnsNextMajor() {
        #expect(Version(1, 0, 0).nextMajor().description == "2.0")
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
        let version = Version(1, 0, 0, prereleaseIdentifiers: ["beta", "1"])
        #expect(version.nextPatch().description == "1.0.0-beta.1.0")
    }

    @Test func nextMinor_fromMajorOnly_fullStyle_returnsFullVersion() {
        #expect(Version(2).nextMinor(.full).description == "2.1.0")
    }

    @Test func nextMajor_fromPrerelease_dropsIdentifiers() {
        let version = Version(1, 2, 3, prereleaseIdentifiers: ["beta"])
        #expect(version.nextMajor(.full).description == "2.0.0")
    }
}

// MARK: - Range extensions

struct VersionRangeTests {
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
