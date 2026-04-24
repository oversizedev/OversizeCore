// Copyright © 2026 Alexander Romanov
// WeatherError.swift

import Foundation

public enum WeatherError: Error, LocalizedError, Sendable {
    // MARK: - Data

    case noDataForDate
    case forecastUnavailable

    // MARK: - Permission

    case accessDenied

    // MARK: - Unknown

    case unknown(Error?)

    // MARK: - LocalizedError

    public var errorDescription: String? {
        switch self {
        case .noDataForDate:
            "No weather data for this date"
        case .forecastUnavailable:
            "Weather forecast unavailable"
        case .accessDenied:
            "No access to weather data"
        case .unknown:
            "Weather error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .noDataForDate:
            "No forecast data is available for the requested date."
        case .forecastUnavailable:
            "The weather service could not return a forecast."
        case .accessDenied:
            "Access to WeatherKit is restricted or denied."
        case let .unknown(error):
            error?.localizedDescription ?? "An unknown weather error occurred."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .noDataForDate:
            "Weather is only available for dates within the 10-day forecast window."
        case .forecastUnavailable:
            "Please try again later."
        case .accessDenied:
            "Check your WeatherKit entitlement and try again."
        case .unknown:
            "Please try again later."
        }
    }
}
