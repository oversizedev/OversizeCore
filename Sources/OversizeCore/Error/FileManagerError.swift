import Foundation

public enum FileManagerError: Error, LocalizedError, Sendable {
    case deleteItem
    case updateItem
    case savingItem
    case fetchItems
    case notAccess
    case unknown

    public var errorDescription: String? {
        switch self {
        case .deleteItem:
            "Failed to delete file"
        case .updateItem:
            "Failed to update file"
        case .savingItem:
            "Failed to save file"
        case .fetchItems:
            "Failed to fetch files"
        case .notAccess:
            "No access to files"
        case .unknown:
            "File manager error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .notAccess:
            "File access is restricted or denied."
        default:
            "The file operation could not be completed."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .notAccess:
            "Allow file access in Settings and try again."
        default:
            "Please try again later."
        }
    }
}
