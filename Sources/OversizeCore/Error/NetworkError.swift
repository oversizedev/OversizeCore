import Foundation

public enum NetworkError: Error, LocalizedError, Sendable {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case apiError(title: String, detail: String?)
    case unknown

    public var errorDescription: String? {
        switch self {
        case .decode:
            "Failed to decode server response"
        case .invalidURL:
            "Invalid request URL"
        case .noResponse:
            "No response from server"
        case .unauthorized:
            "Unauthorized"
        case .unexpectedStatusCode:
            "Unexpected status code"
        case let .apiError(title, _):
            title
        case .unknown:
            "Unknown network error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .decode:
            "The response format was not recognized."
        case .invalidURL:
            "The request URL is malformed."
        case .noResponse:
            "The server did not return a response."
        case .unauthorized:
            "Authentication is required."
        case .unexpectedStatusCode:
            "The server returned an unexpected status code."
        case let .apiError(_, detail):
            detail
        case .unknown:
            "The request failed for an unknown reason."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .unauthorized:
            "Sign in and try again."
        case .invalidURL:
            "Check the request parameters and try again."
        default:
            "Please try again later."
        }
    }
}
