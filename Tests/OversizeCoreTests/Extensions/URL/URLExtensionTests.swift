//
// Copyright © 2026 Alexander Romanov
// URLExtensionTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

// MARK: - Host

struct URLHostTests {
    @Test func hostWithoutSubdomain_stripsSubdomain() throws {
        let url = try #require(URL(string: "https://www.example.com/path"))
        #expect(url.hostWithoutSubdomain == "example.com")
    }

    @Test func hostWithoutSubdomain_stripsMultipleSubdomains() throws {
        let url = try #require(URL(string: "https://a.b.example.com"))
        #expect(url.hostWithoutSubdomain == "example.com")
    }

    @Test func hostWithoutSubdomain_withBareDomain_returnsDomain() throws {
        let url = try #require(URL(string: "https://example.com"))
        #expect(url.hostWithoutSubdomain == "example.com")
    }

    @Test func hostWithoutSubdomain_withSingleLabelHost_returnsHost() throws {
        let url = try #require(URL(string: "http://localhost:8080"))
        #expect(url.hostWithoutSubdomain == "localhost")
    }

    @Test func hostWithoutSubdomain_withIPv4Address_returnsWholeAddress() throws {
        let url = try #require(URL(string: "http://192.168.0.1:8080"))
        #expect(url.hostWithoutSubdomain == "192.168.0.1")
    }

    @Test func hostWithoutSubdomain_withoutHost_returnsNil() throws {
        let url = try #require(URL(string: "file:///tmp/file.txt"))
        #expect(url.hostWithoutSubdomain == nil)
    }
}

// MARK: - Title

struct URLTitleTests {
    @Test func urlTitle_withShortURL_returnsFullString() throws {
        let url = try #require(URL(string: "http://a.co"))
        #expect(url.urlTitle == "http://a.co")
    }

    @Test func urlTitle_withURLAtLengthLimit_returnsFullString() throws {
        let url = try #require(URL(string: "http://abc.com"))
        #expect(url.urlTitle == "http://abc.com")
    }

    @Test func urlTitle_withLongURL_truncatesWithEllipsis() throws {
        let url = try #require(URL(string: "https://example.com/very/long/path"))
        #expect(url.urlTitle == "https://exampl...")
    }
}

// MARK: - File system

struct URLFileExistsTests {
    @Test func fileExists_withExistingFile_returnsTrue() throws {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try Data("content".utf8).write(to: url)
        defer { try? FileManager.default.removeItem(at: url) }
        #expect(url.fileExists())
    }

    @Test func fileExists_withMissingFile_returnsFalse() {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        #expect(!url.fileExists())
    }
}

// MARK: - Cache

#if !os(Linux)
struct URLCacheTests {
    @Test func imageCache_hasConfiguredCapacity() {
        #expect(URLCache.imageCache.memoryCapacity == 512_000_000)
        #expect(URLCache.imageCache.diskCapacity == 1_000_000_000)
    }
}
#endif
