//
// Copyright © 2025 Alexander Romanov
// HealthKitError.swift, created on 01.02.2025
//

import Foundation

public enum HealthKitError: Error, LocalizedError, Sendable {
    // MARK: - Core Operations

    case saveFailed
    case fetchFailed
    case deleteFailed
    case updateFailed

    // MARK: - Permission

    case accessDenied
    case authorizationNotDetermined

    // MARK: - Data

    case dataTypeNotAvailable

    // MARK: - Unknown

    case unknown(Error?)

    // MARK: - LocalizedError

    public var errorDescription: String? {
        switch self {
        case .saveFailed:
            "Failed to save Health data"
        case .fetchFailed:
            "Failed to fetch Health data"
        case .deleteFailed:
            "Failed to delete Health data"
        case .updateFailed:
            "Failed to update Health data"
        case .accessDenied:
            "No access to Health data"
        case .authorizationNotDetermined:
            "Health authorization not determined"
        case .dataTypeNotAvailable:
            "Health data type not available"
        case .unknown:
            "HealthKit error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .saveFailed:
            "The data could not be saved to Health."
        case .fetchFailed:
            "The data could not be retrieved from Health."
        case .deleteFailed:
            "The data could not be deleted from Health."
        case .updateFailed:
            "The data could not be updated in Health."
        case .accessDenied:
            "Health access is restricted or denied."
        case .authorizationNotDetermined:
            "Health authorization has not been granted yet."
        case .dataTypeNotAvailable:
            "The requested health data type is not available on this device."
        case let .unknown(error):
            error?.localizedDescription ?? "An unknown HealthKit error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .saveFailed:
            "Check Health permissions and try again."
        case .fetchFailed:
            "Check Health permissions and try again."
        case .deleteFailed:
            "Make sure the data exists and try again."
        case .updateFailed:
            "Make sure the data exists and try again."
        case .accessDenied:
            "Allow Health access in Settings and try again."
        case .authorizationNotDetermined:
            "Allow Health access when prompted and try again."
        case .dataTypeNotAvailable:
            "This feature requires a device that supports this health data type."
        case .unknown:
            "Please try again later."
        }
    }

    // MARK: - Deprecated Aliases

    @available(*, deprecated, renamed: "deleteFailed")
    public static var deleteItem: HealthKitError {
        .deleteFailed
    }

    @available(*, deprecated, renamed: "updateFailed")
    public static var updateItem: HealthKitError {
        .updateFailed
    }

    @available(*, deprecated, renamed: "saveFailed")
    public static var savingItem: HealthKitError {
        .saveFailed
    }

    @available(*, deprecated, renamed: "fetchFailed")
    public static var fetchItems: HealthKitError {
        .fetchFailed
    }

    @available(*, deprecated, renamed: "accessDenied")
    public static var notAccess: HealthKitError {
        .accessDenied
    }
}
