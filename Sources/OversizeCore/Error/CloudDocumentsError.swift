//
// Copyright © 2025 Alexander Romanov
// CloudDocumentsError.swift, created on 01.02.2025
//

import Foundation

public enum CloudDocumentsError: Error, LocalizedError, Sendable {
    // MARK: - Core Operations

    case saveFailed
    case fetchFailed
    case deleteFailed
    case updateFailed

    // MARK: - Permission

    case accessDenied

    // MARK: - Unknown

    case unknown(Error?)

    // MARK: - LocalizedError

    public var errorDescription: String? {
        switch self {
        case .saveFailed:
            "Failed to save iCloud document"
        case .fetchFailed:
            "Failed to fetch iCloud documents"
        case .deleteFailed:
            "Failed to delete iCloud document"
        case .updateFailed:
            "Failed to update iCloud document"
        case .accessDenied:
            "No access to iCloud Documents"
        case .unknown:
            "iCloud Documents error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .saveFailed:
            "The document could not be saved to iCloud."
        case .fetchFailed:
            "The documents could not be retrieved from iCloud."
        case .deleteFailed:
            "The document could not be deleted from iCloud."
        case .updateFailed:
            "The document could not be updated in iCloud."
        case .accessDenied:
            "iCloud access is restricted or denied."
        case let .unknown(error):
            error?.localizedDescription ?? "An unknown iCloud Documents error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .saveFailed:
            "Check your internet connection and iCloud storage, then try again."
        case .fetchFailed:
            "Check your internet connection and try again."
        case .deleteFailed:
            "Make sure the document exists and try again."
        case .updateFailed:
            "Make sure the document exists and try again."
        case .accessDenied:
            "Sign in to iCloud in Settings and try again."
        case .unknown:
            "Please try again later."
        }
    }

    // MARK: - Deprecated Aliases

    @available(*, deprecated, renamed: "deleteFailed")
    public static var deleteItem: CloudDocumentsError {
        .deleteFailed
    }

    @available(*, deprecated, renamed: "updateFailed")
    public static var updateItem: CloudDocumentsError {
        .updateFailed
    }

    @available(*, deprecated, renamed: "saveFailed")
    public static var savingItem: CloudDocumentsError {
        .saveFailed
    }

    @available(*, deprecated, renamed: "fetchFailed")
    public static var fetchItems: CloudDocumentsError {
        .fetchFailed
    }

    @available(*, deprecated, renamed: "accessDenied")
    public static var notAccess: CloudDocumentsError {
        .accessDenied
    }
}
