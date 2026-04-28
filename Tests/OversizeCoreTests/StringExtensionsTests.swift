//
// Copyright © 2026 Alexander Romanov
// StringExtensionsTests.swift
//

@testable import OversizeCore
import XCTest

final class StringExtensionsTests: XCTestCase {
    func testIsEmail_WithValidEmail_ReturnsTrue() {
        XCTAssertTrue("user@example.com".isEmail)
    }

    func testIsEmail_WithInvalidEmail_ReturnsFalse() {
        XCTAssertFalse("invalid-email".isEmail)
    }

    func testIsURL_WithValidURL_ReturnsTrue() {
        XCTAssertTrue("https://www.example.com/path?param=value".isURL)
    }

    func testIsURL_WithInvalidURL_ReturnsFalse() {
        XCTAssertFalse("not-a-url".isURL)
    }

    func testIsAlphabet_WithLettersAndUnderscore_ReturnsTrue() {
        XCTAssertTrue("Hello_World".isAlphabet)
    }

    func testIsAlphabet_WithNumbers_ReturnsFalse() {
        XCTAssertFalse("Hello123".isAlphabet)
    }
}
