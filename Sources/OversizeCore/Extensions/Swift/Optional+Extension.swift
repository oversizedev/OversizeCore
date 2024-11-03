//
// Copyright © 2023 Alexander Romanov
// Optional+Extension.swift
//

import Foundation

public extension String? {
    var valueOrEmpty: String {
        guard let unwrapped = self else {
            return ""
        }
        return unwrapped
    }
}

public extension Date? {
    var valueOrEmpty: Date {
        guard let unwrapped = self else {
            return Date()
        }
        return unwrapped
    }
}

public extension Float? {
    var valueOrEmpty: Float {
        guard let unwrapped = self else {
            return .zero
        }
        return unwrapped
    }
}

public extension Double? {
    var valueOrEmpty: Double {
        guard let unwrapped = self else {
            return .zero
        }
        return unwrapped
    }
}

public extension Bool? {
    var valueOrFalse: Bool {
        guard let unwrapped = self else {
            return false
        }
        return unwrapped
    }

    var valueOrTrue: Bool {
        guard let unwrapped = self else {
            return true
        }
        return unwrapped
    }
}
