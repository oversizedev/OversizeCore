//
// Copyright © 2023 Alexander Romanov
// String+Extension.swift
//

import Foundation
import SwiftUI

// swiftlint:disable all

// MARK: - String Validation and Formatting

public extension String {
    /// Returns a new string with leading and trailing whitespace and newlines removed.
    /// 
    /// This computed property trims whitespace and newline characters from both ends
    /// of the string, useful for cleaning user input or processing text data.
    /// 
    /// - Returns: A new string with whitespace and newlines trimmed
    /// 
    /// Example:
    /// ```swift
    /// let text = "  Hello World  \n"
    /// let trimmed = text.trim // "Hello World"
    /// ```
    var trim: String {
        let charSet = CharacterSet.whitespacesAndNewlines
        return String(format: "%@", trimmingCharacters(in: charSet))
    }

    /// Validates if the string is a properly formatted email address.
    /// 
    /// This computed property uses regular expression validation to check if the string
    /// matches a valid email format. It checks for the standard email pattern including
    /// local part, @ symbol, domain, and top-level domain.
    /// 
    /// - Returns: `true` if the string is a valid email format, `false` otherwise
    /// 
    /// Example:
    /// ```swift
    /// let email1 = "user@example.com"
    /// let email2 = "invalid-email"
    /// print(email1.isEmail) // true
    /// print(email2.isEmail) // false
    /// ```
    var isEmail: Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let predicate: NSPredicate = .init(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }

    /// Validates if the string is a properly formatted URL.
    /// 
    /// This computed property uses regular expression validation to check if the string
    /// matches a valid HTTP or HTTPS URL format, including domain, port, path, and query parameters.
    /// 
    /// - Returns: `true` if the string is a valid URL format, `false` otherwise
    /// 
    /// Example:
    /// ```swift
    /// let url1 = "https://www.example.com/path?param=value"
    /// let url2 = "not-a-url"
    /// print(url1.isURL) // true
    /// print(url2.isURL) // false
    /// ```
    var isURL: Bool {
        let regEx = "http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?"
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }

    /// Validates if the string contains only alphabetic characters and underscores.
    /// 
    /// This computed property checks if the string consists only of letters (A-Z, a-z)
    /// and underscore characters, useful for validating identifiers or names.
    /// 
    /// - Returns: `true` if the string contains only alphabetic characters and underscores, `false` otherwise
    /// 
    /// Example:
    /// ```swift
    /// let valid = "Hello_World"
    /// let invalid = "Hello123"
    /// print(valid.isAlphabet) // true
    /// print(invalid.isAlphabet) // false
    /// ```
    var isAlphabet: Bool {
        let regEx = "[A-Za-z_]*"
        let predicate: NSPredicate = .init(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }

    /// Returns a URL-encoded version of the string.
    /// 
    /// This computed property applies percent encoding to the string, making it safe
    /// for use in URLs by encoding special characters.
    /// 
    /// - Returns: A URL-encoded string
    /// 
    /// Example:
    /// ```swift
    /// let text = "Hello World!"
    /// let encoded = text.urlEncode // "Hello%20World%21"
    /// ```
    /// 
    /// - Warning: This method force-unwraps the result. Ensure the string is valid for encoding.
    var urlEncode: String {
        let originalString = self
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        return escapedString!
    }

    /// Converts the string to a URL object.
    /// 
    /// This computed property attempts to create a URL from the string, with special
    /// handling for URLs that start with "//" (protocol-relative URLs).
    /// 
    /// - Returns: A URL object if the string is a valid URL, `nil` otherwise
    /// 
    /// Example:
    /// ```swift
    /// let urlString = "https://example.com"
    /// let url = urlString.url // URL(string: "https://example.com")
    /// 
    /// let protocolRelative = "//example.com"
    /// let url2 = protocolRelative.url // URL(string: "http://example.com")
    /// ```
    var url: URL? {
        var URLString = self
        if URLString.hasPrefix("//") {
            URLString = "http:" + URLString
            if let URL = URL(string: URLString) {
                return URL
            }
        } else if let URL = URL(string: URLString) {
            return URL
        }
        return nil
    }

    /// Converts decimal separators to match the current locale.
    /// 
    /// This computed property adjusts decimal separators in the string to match
    /// the current locale's decimal separator (comma or period), useful for
    /// processing numeric strings across different locales.
    /// 
    /// - Returns: A string with decimal separators adjusted for the current locale
    /// 
    /// Example:
    /// ```swift
    /// // In a locale that uses comma as decimal separator
    /// let number = "123.45"
    /// let localized = number.localizedDecimalSeparator // "123,45"
    /// ```
    var localizedDecimalSeparator: String {
        let nf: NumberFormatter = .init()
        if let separator = nf.decimalSeparator {
            var safeValue = self
            if separator == "," {
                safeValue = replacingOccurrences(of: ".", with: ",", options: [], range: nil)
            } else {
                safeValue = replacingOccurrences(of: ",", with: ".", options: [], range: nil)
            }
            return safeValue
        }
        return self
    }

    /// Extracts only the numeric characters from the string.
    /// 
    /// This computed property removes all non-numeric characters, leaving only
    /// decimal digits (0-9). Useful for cleaning phone numbers or extracting
    /// numbers from mixed content.
    /// 
    /// - Returns: A string containing only numeric characters
    /// 
    /// Example:
    /// ```swift
    /// let mixed = "Phone: (555) 123-4567"
    /// let digits = mixed.numbers // "5551234567"
    /// ```
    var numbers: String {
        let set = CharacterSet.decimalDigits.inverted
        let numbers = components(separatedBy: set)
        return numbers.joined(separator: "")
    }

    /// Extracts only the letter characters from the string.
    /// 
    /// This computed property removes all non-letter characters, leaving only
    /// alphabetic characters (A-Z, a-z). Useful for extracting text from
    /// mixed alphanumeric content.
    /// 
    /// - Returns: A string containing only letter characters
    /// 
    /// Example:
    /// ```swift
    /// let mixed = "Hello123World456"
    /// let letters = mixed.letters // "HelloWorld"
    /// ```
    var letters: String {
        let set = CharacterSet.letters.inverted
        let letters = components(separatedBy: set)
        return letters.joined(separator: "")
    }

    /// Extracts only letters and spaces from the string.
    /// 
    /// This computed property removes all characters except letters and spaces,
    /// useful for cleaning text input while preserving word separation.
    /// 
    /// - Returns: A string containing only letters and spaces
    /// 
    /// Example:
    /// ```swift
    /// let mixed = "Hello123 World456!"
    /// let clean = mixed.lettersWithSpace // "Hello World"
    /// ```
    var lettersWithSpace: String {
        let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ").inverted
        let letters = components(separatedBy: set)
        return letters.joined(separator: "")
    }

    /// Converts the string to UTF-8 encoded Data.
    /// 
    /// This computed property converts the string to Data using UTF-8 encoding,
    /// commonly needed for network operations or file I/O.
    /// 
    /// - Returns: UTF-8 encoded Data representation of the string
    /// 
    /// Example:
    /// ```swift
    /// let text = "Hello, World!"
    /// let data = text.data // Data representation
    /// ```
    /// 
    /// - Warning: This method force-unwraps the result. The string must be valid for UTF-8 encoding.
    var data: Data {
        self.data(using: String.Encoding.utf8)!
    }

    /// Returns the NSRange covering the entire string.
    /// 
    /// This computed property creates an NSRange that spans the entire string,
    /// useful for string manipulation operations that require NSRange parameters.
    /// 
    /// - Returns: NSRange covering the entire string using UTF-16 encoding
    /// 
    /// Example:
    /// ```swift
    /// let text = "Hello, World!"
    /// let range = text.range // NSRange(location: 0, length: 13)
    /// ```
    var range: NSRange {
        NSRange(location: 0, length: utf16.count)
    }
}

// MARK: - Date Conversion

public extension String {
    /// Converts the string to a Date using ISO8601 formatting.
    /// 
    /// This function parses the string as an ISO8601 date format and returns
    /// a Date object. The format options can be customized to handle different
    /// ISO8601 variants.
    /// 
    /// - Parameter formatOptions: ISO8601 formatting options to use for parsing
    /// - Returns: A Date object if parsing succeeds, `nil` otherwise
    /// 
    /// Example:
    /// ```swift
    /// let dateString = "2024-01-15"
    /// let date = dateString.toDate() // Uses .withFullDate by default
    /// 
    /// let timeString = "2024-01-15T14:30:25Z"
    /// let dateTime = timeString.toDate(formatOptions: [.withFullDate, .withTime])
    /// ```
    func toDate(formatOptions: ISO8601DateFormatter.Options = .withFullDate) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = formatOptions
        return formatter.date(from: self)
    }
}

// MARK: - Generic Type Conversion

public extension String {
    /// Converts the string to an enum case of the specified type.
    /// 
    /// This generic function attempts to create an enum value from the string,
    /// where the string represents the raw value of the enum case.
    /// 
    /// - Returns: An enum case of type T if the conversion succeeds, `nil` otherwise
    /// 
    /// Example:
    /// ```swift
    /// enum Status: String {
    ///     case active, inactive, pending
    /// }
    /// 
    /// let statusString = "active"
    /// let status: Status? = statusString.enumCase() // Status.active
    /// ```
    func enumCase<T: RawRepresentable>() -> T? {
        if let raw = self as? T.RawValue {
            return T(rawValue: raw)
        }
        return nil
    }

    /// Finds all matches for a regular expression pattern in the string.
    /// 
    /// This function searches the string for all occurrences of the specified
    /// regular expression pattern and returns an array of match groups for each match.
    /// 
    /// - Parameter regex: The regular expression pattern to search for
    /// - Returns: An array of string arrays, where each inner array contains the match groups for one match
    /// 
    /// Example:
    /// ```swift
    /// let text = "Contact: john@example.com or jane@test.org"
    /// let emailPattern = "([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9.-]+\\.[a-zA-Z]{2,})"
    /// let matches = text.matches(for: emailPattern)
    /// // matches[0] = ["john@example.com", "john", "example.com"]
    /// // matches[1] = ["jane@test.org", "jane", "test.org"]
    /// ```
    func matches(for regex: String) -> [[String]] {
        do {
            let regEx = try NSRegularExpression(pattern: regex, options: [])
            let matches = regEx.matches(in: self, range: NSRange(location: 0, length: count))
            return matches.map {
                var array: [String] = []
                for rangeIndex in 0 ... max(0, $0.numberOfRanges - 1) {
                    array.append(String(self[Range($0.range(at: rangeIndex), in: self)!]))
                }
                return array
            }
        } catch _ {}
        return []
    }
}

// MARK: - Case Manipulation

extension String {
    /// Returns a new string with the first letter capitalized.
    /// 
    /// This function capitalizes only the first character of the string,
    /// leaving the rest of the string unchanged. Useful for proper name
    /// formatting or sentence capitalization.
    /// 
    /// - Returns: A new string with the first letter capitalized
    /// 
    /// Example:
    /// ```swift
    /// let text = "hello world"
    /// let capitalized = text.capitalizingFirstLetter() // "Hello world"
    /// ```
    public func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }

    /// Capitalizes the first letter of the string in place.
    /// 
    /// This mutating function modifies the string by capitalizing its first character.
    /// 
    /// Example:
    /// ```swift
    /// var text = "hello world"
    /// text.capitalizeFirstLetter()
    /// print(text) // "Hello world"
    /// ```
    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }
}

extension String {
    /// Returns a new string with the first letter lowercased.
    /// 
    /// This function lowercases only the first character of the string,
    /// leaving the rest of the string unchanged. Useful for camelCase
    /// conversion or specific formatting requirements.
    /// 
    /// - Returns: A new string with the first letter lowercased
    /// 
    /// Example:
    /// ```swift
    /// let text = "Hello World"
    /// let lowercased = text.lowercasingFirstLetter() // "hello World"
    /// ```
    public func lowercasingFirstLetter() -> String {
        prefix(1).lowercased() + dropFirst()
    }

    /// Lowercases the first letter of the string in place.
    /// 
    /// This mutating function modifies the string by lowercasing its first character.
    /// 
    /// Example:
    /// ```swift
    /// var text = "Hello World"
    /// text.lowercasedFirstLetter()
    /// print(text) // "hello World"
    /// ```
    mutating func lowercasedFirstLetter() {
        self = lowercasingFirstLetter()
    }
}

// MARK: - Platform-Specific Extensions

#if os(iOS) || os(tvOS) || os(watchOS)

extension String {
    /// Converts HTML string to attributed string with specified font and color.
    /// 
    /// This function parses HTML content and creates an NSAttributedString with
    /// the specified font and color applied to the entire string. Useful for
    /// displaying HTML content in UIKit components.
    /// 
    /// - Parameters:
    ///   - font: The UIFont to apply to the attributed string
    ///   - color: The UIColor to apply to the attributed string
    /// - Returns: An NSAttributedString if HTML parsing succeeds, `nil` otherwise
    /// 
    /// Example:
    /// ```swift
    /// let html = "<p>Hello <b>World</b></p>"
    /// let font = UIFont.systemFont(ofSize: 16)
    /// let color = UIColor.black
    /// let attributed = html.getAttributedStringFromHtml(font: font, color: color)
    /// ```
    /// 
    /// - Note: This function is only available on iOS, tvOS, and watchOS platforms.
    func getAttributedStringFromHtml(font: UIFont, color: UIColor) -> NSAttributedString? {
        guard let data = data(using: String.Encoding.utf16, allowLossyConversion: false) else {
            return nil
        }

        guard let attributedString = try? NSMutableAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue,
            ],
            documentAttributes: nil,
        ) else {
            return nil
        }

        attributedString.addAttributes(
            [
                .font: font,
                .foregroundColor: color,
            ],
            range: NSRange(location: 0, length: attributedString.length),
        )

        return attributedString
    }
}

// MARK: - UIKit Text Measurement

public extension String {
    /// Calculates the size required to display the string with the specified font.
    /// 
    /// This function measures the bounding size needed to display the string
    /// using the specified font, useful for layout calculations and UI sizing.
    /// 
    /// - Parameter font: The UIFont to use for measurement
    /// - Returns: The CGSize required to display the string
    /// 
    /// Example:
    /// ```swift
    /// let text = "Hello, World!"
    /// let font = UIFont.systemFont(ofSize: 16)
    /// let size = text.size(font: font) // CGSize(width: 87.5, height: 19.0)
    /// ```
    /// 
    /// - Note: This function is only available on iOS, tvOS, and watchOS platforms.
    func size(font: UIFont) -> CGSize {
        let originalString = self as NSString
        return originalString.size(withAttributes: [NSAttributedString.Key.font: font])
    }

    /// Calculates the width required to display the string with the specified font.
    /// 
    /// This function measures the width needed to display the string using the
    /// specified font, providing a convenient way to get just the width measurement.
    /// 
    /// - Parameter font: The UIFont to use for measurement
    /// - Returns: The CGFloat width required to display the string
    /// 
    /// Example:
    /// ```swift
    /// let text = "Hello, World!"
    /// let font = UIFont.systemFont(ofSize: 16)
    /// let width = text.width(font: font) // 87.5
    /// ```
    /// 
    /// - Note: This function is only available on iOS, tvOS, and watchOS platforms.
    func width(font: UIFont) -> CGFloat {
        size(font: font).width
    }
}

// MARK: - NSAttributedString Extensions

public extension NSAttributedString {
    /// Calculates the height required to display the attributed string within a given width.
    /// 
    /// This function measures the height needed to display the attributed string
    /// when constrained to a specific width, useful for dynamic text layout
    /// and table view cell sizing.
    /// 
    /// - Parameter width: The maximum width constraint for the text
    /// - Returns: The CGFloat height required to display the attributed string
    /// 
    /// Example:
    /// ```swift
    /// let attributedText = NSAttributedString(string: "Long text content...")
    /// let maxWidth: CGFloat = 300
    /// let height = attributedText.height(width: maxWidth) // Calculated height
    /// ```
    /// 
    /// - Note: This function is only available on iOS, tvOS, and watchOS platforms.
    func height(width: CGFloat) -> CGFloat {
        let constraintRect: CGSize = .init(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height) + 1
    }
}

#endif
