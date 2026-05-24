//
// Copyright © 2026 Alexander Romanov
// IntelligenceError.swift, created on 23.05.2026
//

import Foundation

public enum IntelligenceError: Error, LocalizedError, Sendable {
    case unsupportedPlatform
    case modelNotAvailable
    case generationFailed(Error?)

    public var errorDescription: String? {
        switch self {
        case .unsupportedPlatform:
            "Apple Intelligence is not supported on this platform"
        case .modelNotAvailable:
            "Apple Intelligence model is not available"
        case .generationFailed:
            "Text generation failed"
        }
    }

    public var failureReason: String? {
        switch self {
        case .unsupportedPlatform:
            "The FoundationModels framework is not available on this platform."
        case .modelNotAvailable:
            "The system language model is not ready or not enabled."
        case let .generationFailed(error):
            error?.localizedDescription ?? "An unexpected error occurred during generation."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .unsupportedPlatform:
            "Use a device running iOS 26 or macOS 26 or later."
        case .modelNotAvailable:
            "Enable Apple Intelligence in Settings and try again."
        case .generationFailed:
            "Please try again later."
        }
    }
}
