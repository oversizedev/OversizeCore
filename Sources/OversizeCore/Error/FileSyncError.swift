import Foundation

public enum FileSyncError: Error, LocalizedError, Sendable {
    case fileManager(FileManagerError)
    case cloudDocuments(CloudDocumentsError)

    public var errorDescription: String? {
        switch self {
        case let .fileManager(error):
            error.errorDescription
        case let .cloudDocuments(error):
            error.errorDescription
        }
    }

    public var failureReason: String? {
        switch self {
        case let .fileManager(error):
            error.failureReason
        case let .cloudDocuments(error):
            error.failureReason
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case let .fileManager(error):
            error.recoverySuggestion
        case let .cloudDocuments(error):
            error.recoverySuggestion
        }
    }
}
