//
// Copyright © 2022 Alexander Romanov
// Optional+Extension.swift
//

import Foundation

public extension Optional where Wrapped == String {
    var valueOrEmpty: String {
        guard let unwrapped = self else {
            return ""
        }
        return unwrapped
    }
}

public extension Optional where Wrapped == Bool {
    var valueOrFalse: Bool {
        guard let unwrapped = self else {
            return false
        }
        return unwrapped
    }
}
