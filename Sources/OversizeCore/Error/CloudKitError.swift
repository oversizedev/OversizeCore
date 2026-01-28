import Foundation

public enum CloudKitError: Error, LocalizedError, Sendable {
    case decode
    case noAccount
    case notAccess
    case unknown

    public var errorDescription: String? {
        switch self {
        case .decode:
            "iCloud data could not be read"
        case .noAccount:
            "No iCloud account"
        case .notAccess:
            "No access to iCloud"
        case .unknown:
            "iCloud error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .decode:
            "The iCloud data format was not recognized."
        case .noAccount:
            "An iCloud account is required."
        case .notAccess:
            "iCloud access is restricted or denied."
        case .unknown:
            "An unknown iCloud error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .noAccount, .notAccess:
            "Sign in to iCloud in Settings and try again."
        default:
            "Please try again later."
        }
    }
}
