import Foundation

public enum CloudDocumentsError: Error, LocalizedError, Sendable {
    case deleteItem
    case updateItem
    case savingItem
    case fetchItems
    case notAccess
    case unknown

    public var errorDescription: String? {
        switch self {
        case .deleteItem:
            "Failed to delete iCloud document"
        case .updateItem:
            "Failed to update iCloud document"
        case .savingItem:
            "Failed to save iCloud document"
        case .fetchItems:
            "Failed to fetch iCloud documents"
        case .notAccess:
            "No access to iCloud Documents"
        case .unknown:
            "iCloud Documents error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .notAccess:
            "iCloud access is restricted or denied."
        default:
            "The iCloud Documents operation could not be completed."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .notAccess:
            "Sign in to iCloud in Settings and try again."
        default:
            "Please try again later."
        }
    }
}
