//
// Copyright © 2026 Alexander Romanov
// ErrorTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

private let allErrors: [any LocalizedError] = {
    var errors: [any LocalizedError] = []
    errors += [
        CalendarError.saveFailed, .fetchFailed, .deleteFailed, .updateFailed,
        .accessDenied, .itemNotFound, .unknown(nil), .unknown(TestError.first),
    ] as [CalendarError]
    errors += [
        CloudError.saveFailed, .fetchFailed, .deleteFailed, .updateFailed, .accessDenied,
        .noAccount, .networkUnavailable, .quotaExceeded, .decode, .unknown(nil), .unknown(TestError.first),
    ] as [CloudError]
    errors += [
        ContactsError.saveFailed, .fetchFailed, .deleteFailed, .updateFailed,
        .accessDenied, .unknown(nil), .unknown(TestError.first),
    ] as [ContactsError]
    errors += [
        FileError.saveFailed, .fetchFailed, .deleteFailed, .updateFailed,
        .accessDenied, .unknown(nil), .unknown(TestError.first),
    ] as [FileError]
    errors += [
        HealthError.saveFailed, .fetchFailed, .deleteFailed, .updateFailed, .accessDenied,
        .authorizationNotDetermined, .dataTypeNotAvailable, .unknown(nil), .unknown(TestError.first),
    ] as [HealthError]
    errors += [
        IntelligenceError.unsupportedPlatform, .modelNotAvailable,
        .generationFailed(nil), .generationFailed(TestError.first),
    ] as [IntelligenceError]
    errors += [
        LocationError.permissionNotDetermined, .accessDenied, .locationUnavailable,
        .locationTimeout, .unknown(nil), .unknown(TestError.first),
    ] as [LocationError]
    errors += [
        NetworkError.invalidURL, .timeout, .noConnection, .decode, .noResponse,
        .unexpectedStatusCode, .unauthorized, .apiError(title: "Title", detail: "Detail"),
        .unknown(nil), .unknown(TestError.first),
    ] as [NetworkError]
    errors += [
        NotificationError.permissionNotDetermined, .accessDenied,
        .schedulingFailed, .unknown(nil), .unknown(TestError.first),
    ] as [NotificationError]
    errors += [
        PersistenceError.saveFailed, .fetchFailed, .deleteFailed, .updateFailed,
        .batchOperationFailed, .migrationFailed, .modelConfigurationError,
        .containerInitializationFailed, .invalidPredicate, .invalidSortDescriptor,
        .invalidFetchDescriptor, .duplicateItem, .itemNotFound,
        .relationshipConstraintViolation, .validationFailed(reason: "Reason"),
        .transactionFailed, .concurrentModification, .indexingError,
        .storageLimitExceeded, .corruptedData, .unknown(nil), .unknown(TestError.first),
    ] as [PersistenceError]
    errors += [
        WeatherError.noDataForDate, .forecastUnavailable,
        .accessDenied, .unknown(nil), .unknown(TestError.first),
    ] as [WeatherError]
    errors.append(CustomError(title: "Title", detail: "Detail", suggestion: "Suggestion"))
    return errors
}()

// MARK: - LocalizedError conformance

struct LocalizedErrorMessageTests {
    @Test func everyCase_providesErrorDescription() {
        for error in allErrors {
            #expect(error.errorDescription?.isEmpty == false, "\(type(of: error)) \(error)")
        }
    }

    @Test func everyCase_providesFailureReason() {
        for error in allErrors {
            #expect(error.failureReason?.isEmpty == false, "\(type(of: error)) \(error)")
        }
    }

    @Test func everyCase_providesRecoverySuggestion() {
        for error in allErrors {
            #expect(error.recoverySuggestion?.isEmpty == false, "\(type(of: error)) \(error)")
        }
    }

    @Test func everyCase_localizedDescriptionMatchesErrorDescription() {
        for error in allErrors {
            #expect(error.localizedDescription == error.errorDescription, "\(type(of: error))")
        }
    }
}

// MARK: - Associated values

struct ErrorAssociatedValueTests {
    @Test func networkApiError_exposesTitleAndDetail() {
        let error = NetworkError.apiError(title: "Rate limited", detail: "Try again in 60s")
        #expect(error.errorDescription == "Rate limited")
        #expect(error.failureReason == "Try again in 60s")
    }

    @Test func networkApiError_withoutDetail_hasNilFailureReason() {
        #expect(NetworkError.apiError(title: "Rate limited", detail: nil).failureReason == nil)
    }

    @Test func persistenceValidationFailed_includesReason() throws {
        let reason = try #require(PersistenceError.validationFailed(reason: "Name is required").failureReason)
        #expect(reason.contains("Name is required"))
    }

    @Test func unknown_withWrappedError_surfacesUnderlyingDescription() throws {
        let reason = try #require(NetworkError.unknown(TestError.first).failureReason)
        #expect(reason == TestError.first.localizedDescription)
    }

    @Test func unknown_withoutWrappedError_usesGenericReason() throws {
        let reason = try #require(NetworkError.unknown(nil).failureReason)
        #expect(!reason.isEmpty)
    }

    @Test func intelligenceGenerationFailed_withWrappedError_surfacesUnderlyingDescription() throws {
        let reason = try #require(IntelligenceError.generationFailed(TestError.second).failureReason)
        #expect(reason == TestError.second.localizedDescription)
    }
}

// MARK: - CustomError

struct CustomErrorTests {
    @Test func init_mapsFieldsToLocalizedError() {
        let error = CustomError(title: "Title", detail: "Detail", suggestion: "Suggestion")
        #expect(error.errorDescription == "Title")
        #expect(error.failureReason == "Detail")
        #expect(error.recoverySuggestion == "Suggestion")
    }

    @Test func init_withDefaults_leavesOptionalFieldsNil() {
        let error = CustomError(title: "Title")
        #expect(error.errorDescription == "Title")
        #expect(error.failureReason == nil)
        #expect(error.recoverySuggestion == nil)
    }
}

// MARK: - Deprecated aliases

/// Two deprecation warnings are expected here: `FileSyncError` is deprecated but still
/// shipping, and its delegation logic is worth covering until it is removed.
struct DeprecatedErrorTests {
    @Test func fileSyncError_delegatesToFileError() {
        let error = FileSyncError.file(.saveFailed)
        #expect(error.errorDescription == FileError.saveFailed.errorDescription)
        #expect(error.failureReason == FileError.saveFailed.failureReason)
        #expect(error.recoverySuggestion == FileError.saveFailed.recoverySuggestion)
    }

    @Test func fileSyncError_delegatesToCloudError() {
        let error = FileSyncError.cloud(.quotaExceeded)
        #expect(error.errorDescription == CloudError.quotaExceeded.errorDescription)
        #expect(error.failureReason == CloudError.quotaExceeded.failureReason)
        #expect(error.recoverySuggestion == CloudError.quotaExceeded.recoverySuggestion)
    }
}
