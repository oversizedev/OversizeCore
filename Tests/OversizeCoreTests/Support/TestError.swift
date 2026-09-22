//
// Copyright © 2026 Alexander Romanov
// TestError.swift
//

import Foundation

enum TestError: Error, LocalizedError, Equatable {
    case first
    case second

    var errorDescription: String? {
        switch self {
        case .first: "First test error"
        case .second: "Second test error"
        }
    }
}
