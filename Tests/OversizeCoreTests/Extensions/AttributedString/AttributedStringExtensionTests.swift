//
// Copyright © 2026 Alexander Romanov
// AttributedStringExtensionTests.swift
//

#if canImport(SwiftUI)
import Foundation
@testable import OversizeCore
import SwiftUI
import Testing

// MARK: - Plain text

struct AttributedStringPlainTextTests {
    @Test func plainText_withContent_returnsTrimmedString() {
        #expect(AttributedString("  Hello  ").plainText == "Hello")
    }

    @Test func plainText_withOnlyWhitespace_returnsNil() {
        #expect(AttributedString("   \n ").plainText == nil)
    }

    @Test func plainText_withEmptyString_returnsNil() {
        #expect(AttributedString("").plainText == nil)
    }
}

// MARK: - Archiving

struct AttributedStringArchivingTests {
    @Test func encode_returnsNonEmptyData() throws {
        let data = try #require(AttributedString("Hello").encode())
        #expect(!data.isEmpty)
    }

    @Test func encodeDecode_preservesCharacters() throws {
        let original = AttributedString("Hello, world")
        let data = try #require(original.encode())
        #expect(String(AttributedString.decode(from: data).characters) == "Hello, world")
    }

    @Test func encodeDecode_preservesForegroundColor() throws {
        var original = AttributedString("Colored")
        original.foregroundColor = .red
        let data = try #require(original.encode())
        #expect(AttributedString.decode(from: data).runs.contains { $0.foregroundColor != nil })
    }

    @Test func encodeDecode_preservesUnderline() throws {
        var original = AttributedString("Underlined")
        original.underlineStyle = Text.LineStyle(pattern: .solid)
        let data = try #require(original.encode())
        #expect(AttributedString.decode(from: data).runs.contains { $0.underlineStyle != nil })
    }

    @Test func encodeDecode_preservesStrikethrough() throws {
        var original = AttributedString("Struck")
        original.strikethroughStyle = Text.LineStyle(pattern: .solid)
        let data = try #require(original.encode())
        #expect(AttributedString.decode(from: data).runs.contains { $0.strikethroughStyle != nil })
    }

    @Test func encodeDecode_preservesLink() throws {
        var original = AttributedString("Link")
        let url = try #require(URL(string: "https://example.com"))
        original.link = url
        let data = try #require(original.encode())
        #expect(AttributedString.decode(from: data).runs.contains { $0.link == url })
    }

    @Test func encodeDecode_preservesPerRunAttributes() throws {
        var original = AttributedString("Red")
        original.foregroundColor = .red
        var tail = AttributedString("Plain")
        tail.foregroundColor = nil
        original.append(tail)

        let data = try #require(original.encode())
        let decoded = AttributedString.decode(from: data)
        #expect(String(decoded.characters) == "RedPlain")
    }

    @Test func decode_withInvalidData_returnsEmptyString() {
        #expect(AttributedString.decode(from: Data("garbage".utf8)).plainText == nil)
    }

    @Test func decode_withEmptyData_returnsEmptyString() {
        #expect(String(AttributedString.decode(from: Data()).characters).isEmpty)
    }
}
#endif
