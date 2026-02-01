//
// Copyright © 2025 Alexander Romanov
// CoreDataError.swift, created on 01.02.2025
//

import Foundation

public enum CoreDataError: Error, LocalizedError, Sendable {
    // MARK: - Core Operations

    case saveFailed
    case fetchFailed
    case deleteFailed
    case updateFailed

    // MARK: - Unknown

    case unknown(Error?)

    // MARK: - LocalizedError

    public var errorDescription: String? {
        switch self {
        case .saveFailed:
            "Failed to save item"
        case .fetchFailed:
            "Failed to fetch items"
        case .deleteFailed:
            "Failed to delete item"
        case .updateFailed:
            "Failed to update item"
        case .unknown:
            "Core Data error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .saveFailed:
            "The item could not be saved to the database."
        case .fetchFailed:
            "The items could not be retrieved from the database."
        case .deleteFailed:
            "The item could not be deleted from the database."
        case .updateFailed:
            "The item could not be updated in the database."
        case let .unknown(error):
            error?.localizedDescription ?? "An unknown Core Data error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .saveFailed:
            "Check if there is enough storage space and try again."
        case .fetchFailed:
            "Refresh the data and try again."
        case .deleteFailed:
            "Make sure the item exists and try again."
        case .updateFailed:
            "Make sure the item exists and try again."
        case .unknown:
            "Please try again later."
        }
    }

    // MARK: - Deprecated Aliases

    @available(*, deprecated, renamed: "deleteFailed")
    public static var deleteItem: CoreDataError {
        .deleteFailed
    }

    @available(*, deprecated, renamed: "updateFailed")
    public static var updateItem: CoreDataError {
        .updateFailed
    }

    @available(*, deprecated, renamed: "saveFailed")
    public static var savingItem: CoreDataError {
        .saveFailed
    }

    @available(*, deprecated, renamed: "fetchFailed")
    public static var fetchItems: CoreDataError {
        .fetchFailed
    }
}
