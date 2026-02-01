//
// Copyright © 2025 Alexander Romanov
// NotificationError.swift, created on 01.02.2025
//

import Foundation

public enum NotificationError: Error, LocalizedError, Sendable {
    // MARK: - Permission

    case permissionNotDetermined
    case accessDenied

    // MARK: - Operations

    case schedulingFailed

    // MARK: - Unknown

    case unknown(Error?)

    // MARK: - LocalizedError

    public var errorDescription: String? {
        switch self {
        case .permissionNotDetermined:
            "Notification permission not determined"
        case .accessDenied:
            "No access to notifications"
        case .schedulingFailed:
            "Failed to schedule notification"
        case .unknown:
            "Notification error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .permissionNotDetermined:
            "Notification permission has not been granted yet."
        case .accessDenied:
            "Notification access is restricted or denied."
        case .schedulingFailed:
            "The notification could not be scheduled."
        case let .unknown(error):
            error?.localizedDescription ?? "An unknown notification error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .permissionNotDetermined:
            "Allow notifications when prompted and try again."
        case .accessDenied:
            "Allow notifications in Settings and try again."
        case .schedulingFailed:
            "Check the notification settings and try again."
        case .unknown:
            "Please try again later."
        }
    }

    // MARK: - Deprecated Aliases

    @available(*, deprecated, renamed: "permissionNotDetermined")
    public static var notDetermined: NotificationError {
        .permissionNotDetermined
    }

    @available(*, deprecated, renamed: "accessDenied")
    public static var notAccess: NotificationError {
        .accessDenied
    }
}
