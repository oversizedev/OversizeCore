//
// Copyright © 2025 Alexander Romanov
// Bool+Extension.swift, created on 15.06.2025
//

import Foundation

public extension Bool {
    static var iOS16: Bool {
        if #available(iOS 16, *) {
            true
        } else {
            false
        }
    }

    static var iOS17: Bool {
        if #available(iOS 17, *) {
            true
        } else {
            false
        }
    }

    static var iOS18: Bool {
        if #available(iOS 18, *) {
            true
        } else {
            false
        }
    }

    static var iOS26: Bool {
        if #available(iOS 26, *) {
            true
        } else {
            false
        }
    }
}
