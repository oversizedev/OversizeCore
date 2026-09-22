//
// Copyright © 2026 Alexander Romanov
// LoadingStateTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

// MARK: - Flags

struct LoadingStateFlagTests {
    @Test func isLoading_withLoading_returnsTrue() {
        #expect(LoadingState<Int>.loading.isLoading)
    }

    @Test func isLoading_withIdle_returnsTrue() {
        #expect(LoadingState<Int>.idle.isLoading)
    }

    @Test func isLoading_withResult_returnsFalse() {
        #expect(!LoadingState.result(1).isLoading)
    }

    @Test func isLoading_withError_returnsFalse() {
        #expect(!LoadingState<Int>.error(NetworkError.decode).isLoading)
    }

    @Test func isResult_withResult_returnsTrue() {
        #expect(LoadingState.result(1).isResult)
    }

    @Test(arguments: [LoadingState<Int>.idle, .loading, .error(NetworkError.decode)])
    func isResult_withoutResult_returnsFalse(_ state: LoadingState<Int>) {
        #expect(!state.isResult)
    }
}

// MARK: - Payload

struct LoadingStatePayloadTests {
    @Test func result_withResult_returnsValue() {
        #expect(LoadingState.result(42).result == 42)
    }

    @Test(arguments: [LoadingState<Int>.idle, .loading, .error(NetworkError.decode)])
    func result_withoutResult_returnsNil(_ state: LoadingState<Int>) {
        #expect(state.result == nil)
    }

    @Test func error_withError_returnsError() {
        let state = LoadingState<Int>.error(TestError.second)
        #expect(state.error as? TestError == .second)
    }

    @Test(arguments: [LoadingState<Int>.idle, .loading, .result(1)])
    func error_withoutError_returnsNil(_ state: LoadingState<Int>) {
        #expect(state.error == nil)
    }
}

// MARK: - Equatable

struct LoadingStateEquatableTests {
    @Test func idleEqualsIdle() {
        #expect(LoadingState<Int>.idle == .idle)
    }

    @Test func loadingEqualsLoading() {
        #expect(LoadingState<Int>.loading == .loading)
    }

    @Test func sameResultsAreEqual() {
        #expect(LoadingState.result(1) == .result(1))
    }

    @Test func differentResultsAreNotEqual() {
        #expect(LoadingState.result(1) != .result(2))
    }

    @Test func differentCasesAreNotEqual() {
        #expect(LoadingState<Int>.idle != .loading)
        #expect(LoadingState<Int>.loading != .result(1))
    }

    @Test func sameErrorsAreEqual() {
        #expect(LoadingState<Int>.error(NetworkError.decode) == .error(NetworkError.decode))
    }

    @Test func errorsWithDifferentDomainsAreNotEqual() {
        let nsError = NSError(domain: "test", code: 1)
        #expect(LoadingState<Int>.error(NetworkError.decode) != .error(nsError))
    }
}
