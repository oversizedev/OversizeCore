import Foundation

public enum NotificationError: Error, LocalizedError, Sendable {
    case notDetermined
    case notAccess
    case unknown

    public var errorDescription: String? {
        switch self {
        case .notDetermined:
            "Notification permission not determined"
        case .notAccess:
            "No access to notifications"
        case .unknown:
            "Notification error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .notDetermined:
            "Notification permission has not been granted yet."
        case .notAccess:
            "Notification access is restricted or denied."
        case .unknown:
            "An unknown notification error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .notAccess, .notDetermined:
            "Allow notifications in Settings and try again."
        default:
            "Please try again later."
        }
    }
}
