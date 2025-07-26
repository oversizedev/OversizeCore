//
// Copyright © 2025 Alexander Romanov
// SwiftDataError.swift, created on 11.07.2025
//

import Foundation

public enum SwiftDataError: Error, LocalizedError, Sendable {
    // Core operations
    case saveFailed
    case fetchFailed
    case deleteFailed
    case updateFailed

    // Batch operations
    case batchOperationFailed

    // Model & Configuration
    case modelConfigurationError
    case containerInitializationFailed
    case migrationFailed

    // Query & Predicate
    case invalidPredicate
    case invalidSortDescriptor
    case invalidFetchDescriptor

    // Data integrity
    case duplicateItem
    case itemNotFound
    case relationshipConstraintViolation
    case validationFailed(reason: String)

    // Transaction
    case transactionFailed
    case concurrentModification

    // Performance
    case indexingError

    // Storage
    case storageLimitExceeded
    case corruptedData

    // Unknown
    case unknown(Error?)
}
