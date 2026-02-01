//
// Copyright © 2025 Alexander Romanov
// CloudKitError.swift, created on 01.02.2025
//

import Foundation

public enum CloudKitError: Error, LocalizedError, Sendable {
    // MARK: - Core Operations

    case saveFailed
    case fetchFailed
    case deleteFailed
    case updateFailed

    // MARK: - Data

    case decode

    // MARK: - Account & Permission

    case noAccount
    case accessDenied

    // MARK: - Network & Storage

    case networkUnavailable
    case quotaExceeded

    // MARK: - Unknown

    case unknown(Error?)

    // MARK: - LocalizedError

    public var errorDescription: String? {
        switch self {
        case .saveFailed:
            "Failed to save to iCloud"
        case .fetchFailed:
            "Failed to fetch from iCloud"
        case .deleteFailed:
            "Failed to delete from iCloud"
        case .updateFailed:
            "Failed to update in iCloud"
        case .decode:
            "iCloud data could not be read"
        case .noAccount:
            "No iCloud account"
        case .accessDenied:
            "No access to iCloud"
        case .networkUnavailable:
            "iCloud network unavailable"
        case .quotaExceeded:
            "iCloud storage full"
        case .unknown:
            "iCloud error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .saveFailed:
            "The data could not be saved to iCloud."
        case .fetchFailed:
            "The data could not be retrieved from iCloud."
        case .deleteFailed:
            "The data could not be deleted from iCloud."
        case .updateFailed:
            "The data could not be updated in iCloud."
        case .decode:
            "The iCloud data format was not recognized."
        case .noAccount:
            "An iCloud account is required."
        case .accessDenied:
            "iCloud access is restricted or denied."
        case .networkUnavailable:
            "The network connection to iCloud is unavailable."
        case .quotaExceeded:
            "Your iCloud storage quota has been exceeded."
        case let .unknown(error):
            error?.localizedDescription ?? "An unknown iCloud error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .saveFailed:
            "Check your internet connection and try again."
        case .fetchFailed:
            "Check your internet connection and try again."
        case .deleteFailed:
            "Make sure the item exists and try again."
        case .updateFailed:
            "Make sure the item exists and try again."
        case .decode:
            "Try refreshing the data or reinstalling the app."
        case .noAccount:
            "Sign in to iCloud in Settings and try again."
        case .accessDenied:
            "Sign in to iCloud in Settings and try again."
        case .networkUnavailable:
            "Check your internet connection and try again."
        case .quotaExceeded:
            "Free up iCloud storage or upgrade your plan."
        case .unknown:
            "Please try again later."
        }
    }

    // MARK: - Deprecated Aliases

    @available(*, deprecated, renamed: "accessDenied")
    public static var notAccess: CloudKitError {
        .accessDenied
    }
}
