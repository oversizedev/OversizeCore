//
// Copyright © 2025 Alexander Romanov
// ContactsError.swift, created on 01.02.2025
//

import Foundation

public enum ContactsError: Error, LocalizedError, Sendable {
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
            "Failed to save contact"
        case .fetchFailed:
            "Failed to fetch contacts"
        case .deleteFailed:
            "Failed to delete contact"
        case .updateFailed:
            "Failed to update contact"
        case .accessDenied:
            "No access to contacts"
        case .unknown:
            "Contacts error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .saveFailed:
            "The contact could not be saved to the address book."
        case .fetchFailed:
            "The contacts could not be retrieved from the address book."
        case .deleteFailed:
            "The contact could not be deleted from the address book."
        case .updateFailed:
            "The contact could not be updated in the address book."
        case .accessDenied:
            "Contacts access is restricted or denied."
        case let .unknown(error):
            error?.localizedDescription ?? "An unknown contacts error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .saveFailed:
            "Check if the contact data is valid and try again."
        case .fetchFailed:
            "Refresh the contacts and try again."
        case .deleteFailed:
            "Make sure the contact exists and try again."
        case .updateFailed:
            "Make sure the contact exists and try again."
        case .accessDenied:
            "Allow contacts access in Settings and try again."
        case .unknown:
            "Please try again later."
        }
    }

    // MARK: - Deprecated Aliases

    @available(*, deprecated, renamed: "accessDenied")
    public static var notAccess: ContactsError {
        .accessDenied
    }
}
