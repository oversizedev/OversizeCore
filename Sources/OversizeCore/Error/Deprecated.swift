//
// Copyright © 2025 Alexander Romanov
// Deprecated.swift, created on 02.02.2025
//

import Foundation

// MARK: - Deprecated Type Aliases

@available(*, deprecated, renamed: "PersistenceError")
public typealias CoreDataError = PersistenceError

@available(*, deprecated, renamed: "PersistenceError")
public typealias SwiftDataError = PersistenceError

@available(*, deprecated, renamed: "FileError")
public typealias FileManagerError = FileError

@available(*, deprecated, renamed: "CloudError")
public typealias CloudDocumentsError = CloudError

@available(*, deprecated, renamed: "CloudError")
public typealias CloudKitError = CloudError

@available(*, deprecated, renamed: "CalendarError")
public typealias EventKitError = CalendarError

@available(*, deprecated, renamed: "HealthError")
public typealias HealthKitError = HealthError

@available(*, deprecated, message: "Use FileError or CloudError instead")
public enum FileSyncError: Error, LocalizedError, Sendable {
    case file(FileError)
    case cloud(CloudError)

    public var errorDescription: String? {
        switch self {
        case let .file(error):
            error.errorDescription
        case let .cloud(error):
            error.errorDescription
        }
    }

    public var failureReason: String? {
        switch self {
        case let .file(error):
            error.failureReason
        case let .cloud(error):
            error.failureReason
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case let .file(error):
            error.recoverySuggestion
        case let .cloud(error):
            error.recoverySuggestion
        }
    }
}
