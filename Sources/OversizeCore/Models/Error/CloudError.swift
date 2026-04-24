//
// Copyright © 2025 Alexander Romanov
// CloudError.swift, created on 02.02.2025
//

import Foundation

public enum CloudError: Error, LocalizedError, Sendable {
    // MARK: - Core Operations

    case saveFailed
    case fetchFailed
    case deleteFailed
    case updateFailed

    // MARK: - Account & Permission

    case accessDenied
    case noAccount

    // MARK: - Network & Storage

    case networkUnavailable
    case quotaExceeded

    // MARK: - Data

    case decode

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
        case .accessDenied:
            "No access to iCloud"
        case .noAccount:
            "No iCloud account"
        case .networkUnavailable:
            "iCloud network unavailable"
        case .quotaExceeded:
            "iCloud storage full"
        case .decode:
            "iCloud data could not be read"
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
        case .accessDenied:
            "iCloud access is restricted or denied."
        case .noAccount:
            "An iCloud account is required."
        case .networkUnavailable:
            "The network connection to iCloud is unavailable."
        case .quotaExceeded:
            "Your iCloud storage quota has been exceeded."
        case .decode:
            "The iCloud data format was not recognized."
        case let .unknown(error):
            error?.localizedDescription ?? "An unknown iCloud error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .saveFailed:
            "Check your internet connection and iCloud storage, then try again."
        case .fetchFailed:
            "Check your internet connection and try again."
        case .deleteFailed:
            "Make sure the item exists and try again."
        case .updateFailed:
            "Make sure the item exists and try again."
        case .accessDenied:
            "Sign in to iCloud in Settings and try again."
        case .noAccount:
            "Sign in to iCloud in Settings and try again."
        case .networkUnavailable:
            "Check your internet connection and try again."
        case .quotaExceeded:
            "Free up iCloud storage or upgrade your plan."
        case .decode:
            "Try refreshing the data or reinstalling the app."
        case .unknown:
            "Please try again later."
        }
    }
}
