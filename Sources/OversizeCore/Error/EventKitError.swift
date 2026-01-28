import Foundation

public enum EventKitError: Error, LocalizedError, Sendable {
    case deleteItem
    case updateItem
    case savingItem
    case fetchItems
    case notAccess
    case itemNotFound
    case unknown

    public var errorDescription: String? {
        switch self {
        case .deleteItem:
            "Failed to delete event"
        case .updateItem:
            "Failed to update event"
        case .savingItem:
            "Failed to save event"
        case .fetchItems:
            "Failed to fetch events"
        case .notAccess:
            "No access to calendar"
        case .itemNotFound:
            "Event not found"
        case .unknown:
            "Calendar error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .notAccess:
            "Calendar access is restricted or denied."
        case .itemNotFound:
            "The requested event could not be found."
        default:
            "The calendar operation could not be completed."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .notAccess:
            "Allow calendar access in Settings and try again."
        default:
            "Please try again later."
        }
    }
}
