import Foundation

public struct CustomError: Error, LocalizedError, Sendable {
    public let title: String
    public let detail: String?

    public init(title: String, detail: String? = nil) {
        self.title = title
        self.detail = detail
    }

    public var errorDescription: String? {
        title
    }

    public var failureReason: String? {
        detail
    }
}
