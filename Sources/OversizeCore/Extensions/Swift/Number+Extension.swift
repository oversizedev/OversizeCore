//
// Copyright © 2022 Alexander Romanov
// Number+Extension.swift
//

import Foundation
import SwiftUI

// MARK: - Int Extensions

public extension Int {
    /// Returns the string representation of the integer.
    /// 
    /// This computed property provides a convenient way to convert an integer
    /// to its string representation.
    /// 
    /// - Returns: String representation of the integer
    /// 
    /// Example:
    /// ```swift
    /// let number = 42
    /// let text = number.toString // "42"
    /// ```
    var toString: String {
        String(self)
    }

    /// Returns the appropriate word form for the given integer based on Slavic language rules.
    /// 
    /// This function implements Slavic language pluralization rules (primarily Russian)
    /// to select the correct word form based on the numeric value. It's commonly used
    /// for displaying counts with proper grammatical forms.
    /// 
    /// - Parameter titles: Array of word forms in order [singular, few, many]
    /// - Returns: The appropriate word form for the number
    /// 
    /// Example:
    /// ```swift
    /// let count = 5
    /// let forms = ["item", "items", "items"] // [singular, few, many]
    /// let word = count.wordFormat(titles: forms) // "items"
    /// ```
    /// 
    /// - Note: This follows Slavic pluralization rules where:
    ///   - Numbers ending in 1 (except 11) use singular form (index 0)
    ///   - Numbers ending in 2-4 (except 12-14) use few form (index 1)  
    ///   - All other numbers use many form (index 2)
    func wordFormat(titles: [String]) -> String {
        let cases = [2, 0, 1, 1, 1, 2]

        let x = self % 100
        if x > 4, x < 20 {
            return titles[2]
        } else {
            let y = self % 10
            let minimum = Swift.min(y, 5)
            let c = cases[minimum]
            return titles[c]
        }
    }

    /// Returns a formatted string with the number and appropriate word form.
    /// 
    /// This function combines the integer with its appropriate word form using
    /// a custom format string.
    /// 
    /// - Parameters:
    ///   - formats: Array of word forms for pluralization
    ///   - format: Format string template with placeholders for number and word
    /// - Returns: Formatted string with number and word
    /// 
    /// Example:
    /// ```swift
    /// let count = 3
    /// let forms = ["file", "files", "files"]
    /// let result = count.stringWithWordFormats(formats: forms, format: "%d %@")
    /// // Result: "3 files"
    /// ```
    func stringWithWordFormats(formats: [String], format: String) -> String {
        let string = wordFormat(titles: formats)
        return String(format: format, self, string)
    }

    /// Returns a formatted string using the word form as the format template.
    /// 
    /// This function uses the selected word form itself as the format string,
    /// allowing for more complex formatting within the word forms.
    /// 
    /// - Parameter formats: Array of format strings for pluralization
    /// - Returns: Formatted string using the selected format
    /// 
    /// Example:
    /// ```swift
    /// let count = 1
    /// let formats = ["%d item found", "%d items found", "%d items found"]
    /// let result = count.stringWithWordFormats(formats: formats)
    /// // Result: "1 item found"
    /// ```
    func stringWithWordFormats(formats: [String]) -> String {
        let format = wordFormat(titles: formats)
        return String(format: format, self)
    }
}

// MARK: - Double Extensions

public extension Double {
    /// Returns the string representation of the double.
    /// 
    /// This computed property provides a convenient way to convert a double
    /// to its string representation using the default formatting.
    /// 
    /// - Returns: String representation of the double
    /// 
    /// Example:
    /// ```swift
    /// let number = 42.5
    /// let text = number.toString // "42.5"
    /// ```
    var toString: String {
        String(self)
    }
}

public extension Double {
    /// Returns the string representation of the double without decimal places.
    /// 
    /// This computed property formats the double as a whole number string,
    /// rounding to the nearest integer and removing the decimal point.
    /// 
    /// - Returns: String representation without decimal places
    /// 
    /// Example:
    /// ```swift
    /// let number = 42.7
    /// let text = number.toStringWithoutPoint // "43"
    /// ```
    var toStringWithoutPoint: String {
        String(format: "%.0f", self)
    }
}

public extension Double {
    /// Returns the string representation of the double with one decimal place.
    /// 
    /// This computed property formats the double to display exactly one decimal place,
    /// useful for consistent numeric display in user interfaces.
    /// 
    /// - Returns: String representation with one decimal place
    /// 
    /// Example:
    /// ```swift
    /// let number = 42.567
    /// let text = number.toStringOnePoint // "42.6"
    /// ```
    var toStringOnePoint: String {
        String(format: "%.1f", self)
    }
}

// MARK: - Float Extensions

public extension Float {
    /// Returns the string representation of the float.
    /// 
    /// This computed property provides a convenient way to convert a float
    /// to its string representation using the default formatting.
    /// 
    /// - Returns: String representation of the float
    /// 
    /// Example:
    /// ```swift
    /// let number: Float = 42.5
    /// let text = number.toString // "42.5"
    /// ```
    var toString: String {
        String(self)
    }
}

public extension Float {
    /// Returns the string representation of the float without decimal places.
    /// 
    /// This computed property formats the float as a whole number string,
    /// rounding to the nearest integer and removing the decimal point.
    /// 
    /// - Returns: String representation without decimal places
    /// 
    /// Example:
    /// ```swift
    /// let number: Float = 42.7
    /// let text = number.toStringWithoutPoint // "43"
    /// ```
    var toStringWithoutPoint: String {
        String(format: "%.0f", self)
    }
}

// MARK: - CGFloat Extensions

public extension CGFloat {
    /// Returns the string representation of the CGFloat without decimal places.
    /// 
    /// This computed property formats the CGFloat as a whole number string,
    /// rounding to the nearest integer and removing the decimal point.
    /// Commonly used for UI measurements and layout calculations.
    /// 
    /// - Returns: String representation without decimal places
    /// 
    /// Example:
    /// ```swift
    /// let width: CGFloat = 120.8
    /// let text = width.toStringWithoutPoint // "121"
    /// ```
    var toStringWithoutPoint: String {
        String(format: "%.0f", self)
    }

    /// Returns a temperature string representation with proper formatting.
    /// 
    /// This computed property formats the CGFloat as a temperature value with
    /// special handling for zero and negative values. It uses the proper minus
    /// sign (−) for negative temperatures and removes the minus sign from zero.
    /// 
    /// - Returns: Formatted temperature string with degree symbol
    /// 
    /// Example:
    /// ```swift
    /// let temp1: CGFloat = 23.7
    /// let temp2: CGFloat = -5.2
    /// let temp3: CGFloat = -0.0
    /// 
    /// print(temp1.toStringTemperature) // "24°"
    /// print(temp2.toStringTemperature) // "−5°"
    /// print(temp3.toStringTemperature) // "0°"
    /// ```
    /// 
    /// - Note: Uses the Unicode minus sign (−) for negative values instead of hyphen (-)
    var toStringTemperature: String {
        let conv = rounded()
        let temp = String(format: "%.0f", conv) + "°"
        if conv == 0 {
            return temp.replacingOccurrences(of: "-", with: "")
        } else if self < 0 {
            return temp.replacingOccurrences(of: "-", with: "−")
        } else {
            return temp
        }
    }
}

// MARK: - Decimal Extensions

public extension Decimal {
    /// Returns the string representation of the decimal value.
    /// 
    /// This computed property converts the Decimal to a string using
    /// NSDecimalNumber for precise decimal representation without
    /// floating-point precision issues.
    /// 
    /// - Returns: String representation of the decimal value
    /// 
    /// Example:
    /// ```swift
    /// let decimal = Decimal(string: "123.456")!
    /// let text = decimal.toString // "123.456"
    /// ```
    var toString: String {
        NSDecimalNumber(decimal: self).stringValue
    }
}
