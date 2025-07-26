//
// Copyright © 2023 Alexander Romanov
// Optional+Extension.swift
//

import Foundation

// MARK: - String Optional Extensions

public extension String? {
    /// Returns the string value or an empty string if nil.
    ///
    /// This computed property provides a safe way to unwrap optional strings,
    /// returning an empty string instead of nil. Useful for UI display where
    /// you want to show something rather than nothing.
    ///
    /// - Returns: The unwrapped string value, or "" if the optional is nil
    ///
    /// Example:
    /// ```swift
    /// let optionalName: String? = nil
    /// let displayName = optionalName.valueOrEmpty // ""
    ///
    /// let actualName: String? = "John"
    /// let displayName2 = actualName.valueOrEmpty // "John"
    /// ```
    var valueOrEmpty: String {
        guard let unwrapped = self else {
            return ""
        }
        return unwrapped
    }
}

// MARK: - Date Optional Extensions

public extension Date? {
    /// Returns the date value or the current date if nil.
    ///
    /// This computed property provides a safe way to unwrap optional dates,
    /// returning the current date instead of nil. Useful when you need a
    /// valid date for operations or display.
    ///
    /// - Returns: The unwrapped date value, or current Date() if the optional is nil
    ///
    /// Example:
    /// ```swift
    /// let optionalDate: Date? = nil
    /// let safeDate = optionalDate.valueOrEmpty // Current date
    ///
    /// let actualDate: Date? = Date(timeIntervalSince1970: 1000000)
    /// let safeDate2 = actualDate.valueOrEmpty // The actual date
    /// ```
    var valueOrEmpty: Date {
        guard let unwrapped = self else {
            return Date()
        }
        return unwrapped
    }
}

// MARK: - Float Optional Extensions

public extension Float? {
    /// Returns the float value or zero if nil.
    ///
    /// This computed property provides a safe way to unwrap optional floats,
    /// returning zero instead of nil. Useful for calculations where you
    /// want to treat nil as a zero value.
    ///
    /// - Returns: The unwrapped float value, or 0.0 if the optional is nil
    ///
    /// Example:
    /// ```swift
    /// let optionalPrice: Float? = nil
    /// let price = optionalPrice.valueOrEmpty // 0.0
    ///
    /// let actualPrice: Float? = 19.99
    /// let price2 = actualPrice.valueOrEmpty // 19.99
    /// ```
    var valueOrEmpty: Float {
        guard let unwrapped = self else {
            return .zero
        }
        return unwrapped
    }
}

// MARK: - Double Optional Extensions

public extension Double? {
    /// Returns the double value or zero if nil.
    ///
    /// This computed property provides a safe way to unwrap optional doubles,
    /// returning zero instead of nil. Useful for mathematical calculations
    /// where you want to treat nil as a zero value.
    ///
    /// - Returns: The unwrapped double value, or 0.0 if the optional is nil
    ///
    /// Example:
    /// ```swift
    /// let optionalScore: Double? = nil
    /// let score = optionalScore.valueOrEmpty // 0.0
    ///
    /// let actualScore: Double? = 95.5
    /// let score2 = actualScore.valueOrEmpty // 95.5
    /// ```
    var valueOrEmpty: Double {
        guard let unwrapped = self else {
            return .zero
        }
        return unwrapped
    }
}

// MARK: - Bool Optional Extensions

public extension Bool? {
    /// Returns the boolean value or false if nil.
    ///
    /// This computed property provides a safe way to unwrap optional booleans,
    /// returning false instead of nil. Useful for conditional logic where
    /// you want to treat nil as false (conservative/safe default).
    ///
    /// - Returns: The unwrapped boolean value, or false if the optional is nil
    ///
    /// Example:
    /// ```swift
    /// let optionalEnabled: Bool? = nil
    /// let isEnabled = optionalEnabled.valueOrFalse // false
    ///
    /// let actualEnabled: Bool? = true
    /// let isEnabled2 = actualEnabled.valueOrFalse // true
    /// ```
    var valueOrFalse: Bool {
        guard let unwrapped = self else {
            return false
        }
        return unwrapped
    }

    /// Returns the boolean value or true if nil.
    ///
    /// This computed property provides a safe way to unwrap optional booleans,
    /// returning true instead of nil. Useful for conditional logic where
    /// you want to treat nil as true (permissive/optimistic default).
    ///
    /// - Returns: The unwrapped boolean value, or true if the optional is nil
    ///
    /// Example:
    /// ```swift
    /// let optionalAllowed: Bool? = nil
    /// let isAllowed = optionalAllowed.valueOrTrue // true
    ///
    /// let actualAllowed: Bool? = false
    /// let isAllowed2 = actualAllowed.valueOrTrue // false
    /// ```
    var valueOrTrue: Bool {
        guard let unwrapped = self else {
            return true
        }
        return unwrapped
    }
}
