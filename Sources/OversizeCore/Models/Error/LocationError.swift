//
// Copyright © 2025 Alexander Romanov
// LocationError.swift, created on 01.02.2025
//

import Foundation

public enum LocationError: Error, LocalizedError, Sendable {
    // MARK: - Permission

    case permissionNotDetermined
    case accessDenied

    // MARK: - Location

    case locationUnavailable
    case locationTimeout

    // MARK: - Unknown

    case unknown(Error?)

    // MARK: - LocalizedError

    public var errorDescription: String? {
        switch self {
        case .permissionNotDetermined:
            "Location access not determined"
        case .accessDenied:
            "No access to location"
        case .locationUnavailable:
            "Location unavailable"
        case .locationTimeout:
            "Location request timed out"
        case .unknown:
            "Location error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .permissionNotDetermined:
            "Location permission has not been granted yet."
        case .accessDenied:
            "Location access is restricted or denied."
        case .locationUnavailable:
            "The device could not determine its location."
        case .locationTimeout:
            "The location request took too long to complete."
        case let .unknown(error):
            error?.localizedDescription ?? "An unknown location error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .permissionNotDetermined:
            "Allow location access when prompted and try again."
        case .accessDenied:
            "Allow location access in Settings and try again."
        case .locationUnavailable:
            "Make sure location services are enabled and you have a clear view of the sky."
        case .locationTimeout:
            "Move to an area with better GPS reception and try again."
        case .unknown:
            "Please try again later."
        }
    }

    // MARK: - Deprecated Aliases

    @available(*, deprecated, renamed: "permissionNotDetermined")
    public static var notDetermined: LocationError {
        .permissionNotDetermined
    }

    @available(*, deprecated, renamed: "accessDenied")
    public static var notAccess: LocationError {
        .accessDenied
    }
}
