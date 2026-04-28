//
// Copyright © 2025 Alexander Romanov
// PersistenceError.swift, created on 02.02.2025
//

import Foundation

public enum PersistenceError: Error, LocalizedError, Sendable {
    // MARK: - Core Operations

    case saveFailed
    case fetchFailed
    case deleteFailed
    case updateFailed

    // MARK: - Batch Operations

    case batchOperationFailed

    // MARK: - Model & Configuration

    case migrationFailed
    case modelConfigurationError
    case containerInitializationFailed

    // MARK: - Query & Predicate

    case invalidPredicate
    case invalidSortDescriptor
    case invalidFetchDescriptor

    // MARK: - Data Integrity

    case duplicateItem
    case itemNotFound
    case relationshipConstraintViolation
    case validationFailed(reason: String)

    // MARK: - Transaction

    case transactionFailed
    case concurrentModification

    // MARK: - Performance

    case indexingError

    // MARK: - Storage

    case storageLimitExceeded
    case corruptedData

    // MARK: - Unknown

    case unknown(Error?)

    // MARK: - LocalizedError

    public var errorDescription: String? {
        switch self {
        case .saveFailed:
            "Failed to save data"
        case .fetchFailed:
            "Failed to fetch data"
        case .deleteFailed:
            "Failed to delete data"
        case .updateFailed:
            "Failed to update data"
        case .batchOperationFailed:
            "Batch operation failed"
        case .migrationFailed:
            "Data migration failed"
        case .modelConfigurationError:
            "Model configuration error"
        case .containerInitializationFailed:
            "Failed to initialize data container"
        case .invalidPredicate:
            "Invalid search criteria"
        case .invalidSortDescriptor:
            "Invalid sort order"
        case .invalidFetchDescriptor:
            "Invalid fetch configuration"
        case .duplicateItem:
            "Item already exists"
        case .itemNotFound:
            "Item not found"
        case .relationshipConstraintViolation:
            "Relationship constraint violated"
        case .validationFailed:
            "Data validation failed"
        case .transactionFailed:
            "Transaction failed"
        case .concurrentModification:
            "Concurrent modification detected"
        case .indexingError:
            "Indexing error"
        case .storageLimitExceeded:
            "Storage limit exceeded"
        case .corruptedData:
            "Data is corrupted"
        case .unknown:
            "Data persistence error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .saveFailed:
            "The data could not be saved to the database."
        case .fetchFailed:
            "The data could not be retrieved from the database."
        case .deleteFailed:
            "The data could not be deleted from the database."
        case .updateFailed:
            "The data could not be updated in the database."
        case .batchOperationFailed:
            "The batch operation could not be completed."
        case .migrationFailed:
            "The data migration could not be completed."
        case .modelConfigurationError:
            "The data model configuration is invalid."
        case .containerInitializationFailed:
            "The data container could not be initialized."
        case .invalidPredicate:
            "The search criteria format is not valid."
        case .invalidSortDescriptor:
            "The sort order specification is not valid."
        case .invalidFetchDescriptor:
            "The fetch configuration is not valid."
        case .duplicateItem:
            "An item with the same identifier already exists."
        case .itemNotFound:
            "The requested item does not exist in the database."
        case .relationshipConstraintViolation:
            "The operation violates a relationship constraint."
        case let .validationFailed(reason):
            reason
        case .transactionFailed:
            "The database transaction could not be completed."
        case .concurrentModification:
            "The data was modified by another process."
        case .indexingError:
            "The database index could not be updated."
        case .storageLimitExceeded:
            "The database has reached its storage limit."
        case .corruptedData:
            "The database contains corrupted data."
        case let .unknown(error):
            error?.localizedDescription ?? "An unknown data persistence error occurred."
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
        case .batchOperationFailed:
            "Try performing the operation in smaller batches."
        case .migrationFailed:
            "The app may need to be reinstalled."
        case .modelConfigurationError:
            "Restart the app and try again."
        case .containerInitializationFailed:
            "Restart the app and try again."
        case .invalidPredicate:
            "Check your query parameters and try again."
        case .invalidSortDescriptor:
            "Check your query parameters and try again."
        case .invalidFetchDescriptor:
            "Check your query parameters and try again."
        case .duplicateItem:
            "Try updating the existing item instead."
        case .itemNotFound:
            "Refresh and try again."
        case .relationshipConstraintViolation:
            "Check the related data and try again."
        case .validationFailed:
            "Check the data and try again."
        case .transactionFailed:
            "Please try again later."
        case .concurrentModification:
            "Reload the data and try again."
        case .indexingError:
            "Please try again later."
        case .storageLimitExceeded:
            "Delete some data to free up space."
        case .corruptedData:
            "The database may need to be reset."
        case .unknown:
            "Please try again later."
        }
    }
}
