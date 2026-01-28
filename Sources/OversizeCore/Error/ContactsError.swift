import Foundation

public enum ContactsError: Error, LocalizedError, Sendable {
    case notAccess
    case unknown

    public var errorDescription: String? {
        switch self {
        case .notAccess:
            "No access to contacts"
        case .unknown:
            "Contacts error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .notAccess:
            "Contacts access is restricted or denied."
        case .unknown:
            "An unknown contacts error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .notAccess:
            "Allow contacts access in Settings and try again."
        default:
            "Please try again later."
        }
    }
}
