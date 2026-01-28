import Foundation

public enum FileSyncError: Error, LocalizedError, Sendable {
    case fileManager(FileManagerError)
    case cloudDocuments(CloudDocumentsError)

    public var errorDescription: String? {
        switch self {
        case let .fileManager(error):
            return error.errorDescription
        case let .cloudDocuments(error):
            return error.errorDescription
        }
    }

    public var failureReason: String? {
        switch self {
        case let .fileManager(error):
            return error.failureReason
        case let .cloudDocuments(error):
            return error.failureReason
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case let .fileManager(error):
            return error.recoverySuggestion
        case let .cloudDocuments(error):
            return error.recoverySuggestion
        }
    }
}
