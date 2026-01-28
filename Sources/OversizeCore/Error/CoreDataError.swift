import Foundation

public enum CoreDataError: Error, LocalizedError, Sendable {
    case deleteItem
    case updateItem
    case savingItem
    case fetchItems
    case unknown

    public var errorDescription: String? {
        switch self {
        case .deleteItem:
            "Failed to delete item"
        case .updateItem:
            "Failed to update item"
        case .savingItem:
            "Failed to save item"
        case .fetchItems:
            "Failed to fetch items"
        case .unknown:
            "Core Data error"
        }
    }

    public var failureReason: String? {
        "The data operation could not be completed."
    }

    public var recoverySuggestion: String? {
        "Please try again later."
    }
}
