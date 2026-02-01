//
// Copyright © 2025 Alexander Romanov
// FileManagerError.swift, created on 01.02.2025
//

import Foundation

public enum FileManagerError: Error, LocalizedError, Sendable {
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
            "Failed to save file"
        case .fetchFailed:
            "Failed to fetch files"
        case .deleteFailed:
            "Failed to delete file"
        case .updateFailed:
            "Failed to update file"
        case .accessDenied:
            "No access to files"
        case .unknown:
            "File manager error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .saveFailed:
            "The file could not be saved to disk."
        case .fetchFailed:
            "The files could not be retrieved from disk."
        case .deleteFailed:
            "The file could not be deleted from disk."
        case .updateFailed:
            "The file could not be updated on disk."
        case .accessDenied:
            "File access is restricted or denied."
        case let .unknown(error):
            error?.localizedDescription ?? "An unknown file manager error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .saveFailed:
            "Check if there is enough storage space and try again."
        case .fetchFailed:
            "Make sure the file exists and try again."
        case .deleteFailed:
            "Make sure the file exists and you have permission to delete it."
        case .updateFailed:
            "Make sure the file exists and you have permission to modify it."
        case .accessDenied:
            "Allow file access in Settings and try again."
        case .unknown:
            "Please try again later."
        }
    }

    // MARK: - Deprecated Aliases

    @available(*, deprecated, renamed: "deleteFailed")
    public static var deleteItem: FileManagerError {
        .deleteFailed
    }

    @available(*, deprecated, renamed: "updateFailed")
    public static var updateItem: FileManagerError {
        .updateFailed
    }

    @available(*, deprecated, renamed: "saveFailed")
    public static var savingItem: FileManagerError {
        .saveFailed
    }

    @available(*, deprecated, renamed: "fetchFailed")
    public static var fetchItems: FileManagerError {
        .fetchFailed
    }

    @available(*, deprecated, renamed: "accessDenied")
    public static var notAccess: FileManagerError {
        .accessDenied
    }
}
