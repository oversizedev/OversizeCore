//
// Copyright © 2026 Alexander Romanov
// ResultExtensionTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

struct ResultExtensionTests {
    private let success: Result<Int, TestError> = .success(42)
    private let failure: Result<Int, TestError> = .failure(.first)

    @Test func successResult_withSuccess_returnsValue() {
        #expect(success.successResult == 42)
    }

    @Test func successResult_withFailure_returnsNil() {
        #expect(failure.successResult == nil)
    }

    @Test func failureError_withFailure_returnsError() {
        #expect(failure.failureError == .first)
    }

    @Test func failureError_withSuccess_returnsNil() {
        #expect(success.failureError == nil)
    }

    @Test func isSuccess_reflectsCase() {
        #expect(success.isSuccess)
        #expect(!failure.isSuccess)
    }

    @Test func isFailure_isInverseOfIsSuccess() {
        #expect(failure.isFailure)
        #expect(!success.isFailure)
    }
}
