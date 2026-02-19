//
// Copyright © 2025 Alexander Romanov
// CalendarError.swift, created on 02.02.2025
//

import Foundation

public enum CalendarError: Error, LocalizedError, Sendable {
    // MARK: - Core Operations

    case saveFailed
    case fetchFailed
    case deleteFailed
    case updateFailed

    // MARK: - Permission

    case accessDenied

    // MARK: - Data

    case itemNotFound

    // MARK: - Unknown

    case unknown(Error?)

    // MARK: - LocalizedError

    public var errorDescription: String? {
        switch self {
        case .saveFailed:
            "Failed to save event"
        case .fetchFailed:
            "Failed to fetch events"
        case .deleteFailed:
            "Failed to delete event"
        case .updateFailed:
            "Failed to update event"
        case .accessDenied:
            "No access to calendar"
        case .itemNotFound:
            "Event not found"
        case .unknown:
            "Calendar error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .saveFailed:
            "The event could not be saved to the calendar."
        case .fetchFailed:
            "The events could not be retrieved from the calendar."
        case .deleteFailed:
            "The event could not be deleted from the calendar."
        case .updateFailed:
            "The event could not be updated in the calendar."
        case .accessDenied:
            "Calendar access is restricted or denied."
        case .itemNotFound:
            "The requested event could not be found."
        case let .unknown(error):
            error?.localizedDescription ?? "An unknown calendar error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .saveFailed:
            "Check if the calendar is writable and try again."
        case .fetchFailed:
            "Refresh the calendar and try again."
        case .deleteFailed:
            "Make sure the event exists and try again."
        case .updateFailed:
            "Make sure the event exists and try again."
        case .accessDenied:
            "Allow calendar access in Settings and try again."
        case .itemNotFound:
            "Refresh the calendar and try again."
        case .unknown:
            "Please try again later."
        }
    }
}
