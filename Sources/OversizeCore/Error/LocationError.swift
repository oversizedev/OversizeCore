import Foundation

public enum LocationError: Error, LocalizedError, Sendable {
    case notDetermined
    case notAccess
    case unknown

    public var errorDescription: String? {
        switch self {
        case .notDetermined:
            "Location access not determined"
        case .notAccess:
            "No access to location"
        case .unknown:
            "Location error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .notDetermined:
            "Location permission has not been granted yet."
        case .notAccess:
            "Location access is restricted or denied."
        case .unknown:
            "An unknown location error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .notAccess, .notDetermined:
            "Allow location access in Settings and try again."
        default:
            "Please try again later."
        }
    }
}
