//
// Copyright © 2022 Alexander Romanov
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

public extension Bool? {
    var valueOrFalse: Bool {
        guard let unwrapped = self else {
            return false
        }
        return unwrapped
    }
}
