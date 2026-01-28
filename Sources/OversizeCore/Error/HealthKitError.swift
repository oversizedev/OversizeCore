import Foundation

public enum HealthKitError: Error, LocalizedError, Sendable {
    case deleteItem
    case updateItem
    case savingItem
    case fetchItems
    case notAccess
    case unknown

    public var errorDescription: String? {
        switch self {
        case .deleteItem:
            "Failed to delete Health data"
        case .updateItem:
            "Failed to update Health data"
        case .savingItem:
            "Failed to save Health data"
        case .fetchItems:
            "Failed to fetch Health data"
        case .notAccess:
            "No access to Health data"
        case .unknown:
            "HealthKit error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .notAccess:
            "Health access is restricted or denied."
        default:
            "The HealthKit operation could not be completed."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .notAccess:
            "Allow Health access in Settings and try again."
        default:
            "Please try again later."
        }
    }
}
