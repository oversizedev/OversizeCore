//
// Copyright © 2025 Alexander Romanov
// CustomError.swift, created on 01.02.2025
//

import Foundation

public struct CustomError: Error, LocalizedError, Sendable {
    public let title: String
    public let detail: String?
    public let suggestion: String?

    public init(title: String, detail: String? = nil, suggestion: String? = nil) {
        self.title = title
        self.detail = detail
        self.suggestion = suggestion
    }

    public var errorDescription: String? {
        title
    }

    public var failureReason: String? {
        detail
    }

    public var recoverySuggestion: String? {
        suggestion
    }
}
