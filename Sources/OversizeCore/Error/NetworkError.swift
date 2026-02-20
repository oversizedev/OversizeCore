//
// Copyright © 2025 Alexander Romanov
// NetworkError.swift, created on 01.02.2025
//

import Foundation

public enum NetworkError: Error, LocalizedError, Sendable {
    // MARK: - Request

    case invalidURL
    case timeout
    case noConnection

    // MARK: - Response

    case decode
    case noResponse
    case unexpectedStatusCode

    // MARK: - Authentication

    case unauthorized

    // MARK: - API

    case apiError(title: String, detail: String?)

    // MARK: - Unknown

    case unknown(Error?)

    // MARK: - LocalizedError

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Invalid request URL"
        case .timeout:
            "Request timed out"
        case .noConnection:
            "No internet connection"
        case .decode:
            "Failed to decode server response"
        case .noResponse:
            "No response from server"
        case .unexpectedStatusCode:
            "Unexpected status code"
        case .unauthorized:
            "Unauthorized"
        case let .apiError(title, _):
            title
        case .unknown:
            "Unknown network error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .invalidURL:
            "The request URL is malformed."
        case .timeout:
            "The request took too long to complete."
        case .noConnection:
            "The device is not connected to the internet."
        case .decode:
            "The response format was not recognized."
        case .noResponse:
            "The server did not return a response."
        case .unexpectedStatusCode:
            "The server returned an unexpected status code."
        case .unauthorized:
            "Authentication is required."
        case let .apiError(_, detail):
            detail
        case let .unknown(error):
            error?.localizedDescription ?? "The request failed for an unknown reason."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .invalidURL:
            "Check the request parameters and try again."
        case .timeout:
            "Check your internet connection and try again."
        case .noConnection:
            "Connect to the internet and try again."
        case .decode:
            "Try again later or contact support."
        case .noResponse:
            "Check your internet connection and try again."
        case .unexpectedStatusCode:
            "Try again later or contact support."
        case .unauthorized:
            "Sign in and try again."
        case .apiError:
            "Please try again later."
        case .unknown:
            "Please try again later."
        }
    }
}
