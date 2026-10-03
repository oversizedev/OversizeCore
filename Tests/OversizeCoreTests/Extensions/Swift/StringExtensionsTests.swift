//
// Copyright © 2026 Alexander Romanov
// StringExtensionsTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

// MARK: - Validation

struct StringValidationTests {
    @Test func trim_removesLeadingAndTrailingWhitespace() {
        #expect("  Hello World  \n".trim == "Hello World")
    }

    @Test func trim_keepsInnerWhitespace() {
        #expect(" a  b ".trim == "a  b")
    }

    @Test(arguments: ["user@example.com", "first.last+tag@sub.example.co.uk", "a@b.co"])
    func isEmail_withValidAddress_returnsTrue(_ value: String) {
        #expect(value.isEmail)
    }

    @Test(arguments: ["invalid-email", "user@example", "user@example.c", "@example.com", ""])
    func isEmail_withInvalidAddress_returnsFalse(_ value: String) {
        #expect(!value.isEmail)
    }

    @Test(arguments: ["https://www.example.com/path?param=value", "http://example.com", "https://example.com:8080/path"])
    func isURL_withValidURL_returnsTrue(_ value: String) {
        #expect(value.isURL)
    }

    @Test(arguments: ["not-a-url", "ftp://example.com", "example.com", ""])
    func isURL_withInvalidURL_returnsFalse(_ value: String) {
        #expect(!value.isURL)
    }

    @Test func isAlphabet_withLettersAndUnderscore_returnsTrue() {
        #expect("Hello_World".isAlphabet)
    }

    @Test func isAlphabet_withNumbers_returnsFalse() {
        #expect(!"Hello123".isAlphabet)
    }

    @Test func isAlphabet_withEmptyString_returnsTrue() {
        #expect("".isAlphabet)
    }
}

// MARK: - Conversion

struct StringConversionTests {
    @Test func urlEncode_escapesSpaces() {
        #expect("hello world".urlEncode == "hello%20world")
    }

    @Test func urlEncode_leavesAllowedCharactersIntact() {
        #expect("example.com".urlEncode == "example.com")
    }

    @Test func url_withAbsoluteString_returnsURL() throws {
        let url = try #require("https://example.com/path".url)
        #expect(url.absoluteString == "https://example.com/path")
    }

    @Test func url_withProtocolRelativeString_prependsHTTP() throws {
        let url = try #require("//example.com".url)
        #expect(url.absoluteString == "http://example.com")
    }

    @Test func numbers_keepsOnlyDigits() {
        #expect("a1b2c3".numbers == "123")
    }

    @Test func letters_keepsOnlyLetters() {
        #expect("a1b2c3!".letters == "abc")
    }

    @Test func lettersWithSpace_keepsLettersAndSpaces() {
        #expect("Hi5 there!".lettersWithSpace == "Hi there")
    }

    @Test func data_encodesUTF8() {
        #expect("abc".data == Data("abc".utf8))
    }

    @Test func range_coversWholeStringInUTF16() {
        #expect("abc".range == NSRange(location: 0, length: 3))
    }

    @Test func range_countsSurrogatePairsAsTwoUnits() {
        #expect("😀".range == NSRange(location: 0, length: 2))
    }

    @Test func localizedDecimalSeparator_normalizesBothSeparators() {
        #expect("1.5".localizedDecimalSeparator == "1,5".localizedDecimalSeparator)
    }

    @Test(arguments: ["1.5", "1,5"])
    func localizedDecimalSeparator_producesParsableNumber(_ value: String) throws {
        let number = try #require(NumberFormatter().number(from: value.localizedDecimalSeparator))
        #expect(number.doubleValue == 1.5)
    }

    @Test func toDate_withFullDate_parsesDate() throws {
        let date = try #require("2024-06-13".toDate())
        #expect(date.toString() == "2024-06-13")
    }

    @Test func toDate_withInvalidString_returnsNil() {
        #expect("not-a-date".toDate() == nil)
    }

    @Test func enumCase_withMatchingRawValue_returnsCase() {
        let fruit: Fruit? = "apple".enumCase()
        #expect(fruit == .apple)
    }

    @Test func enumCase_withUnknownRawValue_returnsNil() {
        let fruit: Fruit? = "carrot".enumCase()
        #expect(fruit == nil)
    }

    private enum Fruit: String {
        case apple
        case banana
    }
}

// MARK: - Regex matching

struct StringMatchesTests {
    @Test func matchesForRegex_returnsEveryMatch() {
        #expect("a1b2".matches(for: "[0-9]") == [["1"], ["2"]])
    }

    @Test func matchesForRegex_returnsCaptureGroups() {
        #expect("key=value".matches(for: "(\\w+)=(\\w+)") == [["key=value", "key", "value"]])
    }

    @Test func matchesForRegex_withNoMatch_returnsEmpty() {
        #expect("abc".matches(for: "[0-9]").isEmpty)
    }

    @Test func matchesForRegex_withInvalidPattern_returnsEmpty() {
        #expect("abc".matches(for: "[").isEmpty)
    }

    @Test func matchesForRegex_searchesPastSurrogatePairs() {
        #expect("😀abc".matches(for: "abc") == [["abc"]])
    }
}

// MARK: - Case manipulation

struct StringCaseTests {
    @Test func capitalizingFirstLetter_uppercasesFirstCharacter() {
        #expect("hello world".capitalizingFirstLetter() == "Hello world")
    }

    @Test func capitalizingFirstLetter_withEmptyString_returnsEmpty() {
        #expect("".capitalizingFirstLetter() == "")
    }

    @Test func capitalizeFirstLetter_mutatesInPlace() {
        var value = "hello"
        value.capitalizeFirstLetter()
        #expect(value == "Hello")
    }

    @Test func lowercasingFirstLetter_lowercasesFirstCharacter() {
        #expect("Hello World".lowercasingFirstLetter() == "hello World")
    }

    @Test func lowercasedFirstLetter_mutatesInPlace() {
        var value = "Hello"
        value.lowercasedFirstLetter()
        #expect(value == "hello")
    }
}
