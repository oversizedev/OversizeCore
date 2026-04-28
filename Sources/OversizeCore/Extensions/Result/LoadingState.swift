//
// Copyright © 2025 Alexander Romanov
// LoadingState.swift, created on 11.07.2025
//

import Foundation

public enum LoadingState<Result: Sendable>: Sendable {
    case idle
    case loading
    case result(Result)
    case error(Error)
}

public extension LoadingState {
    var isLoading: Bool {
        switch self {
        case .loading, .idle:
            true
        default:
            false
        }
    }

    var isResult: Bool {
        switch self {
        case .result:
            true
        default:
            false
        }
    }

    var result: Result? {
        switch self {
        case let .result(result):
            result
        default:
            nil
        }
    }

    var error: Error? {
        switch self {
        case let .error(error):
            error
        default:
            nil
        }
    }
}

extension LoadingState: Equatable where Result: Equatable {
    public static func == (lhs: LoadingState<Result>, rhs: LoadingState<Result>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            true
        case (.loading, .loading):
            true
        case let (.result(lhsResult), .result(rhsResult)):
            lhsResult == rhsResult
        case let (.error(lhsError), .error(rhsError)):
            (lhsError as NSError).domain == (rhsError as NSError).domain && (lhsError as NSError).code == (rhsError as NSError).code
        default:
            false
        }
    }
}

extension LoadingState {
    @available(*, deprecated, message: "Use error instead", renamed: "error")
    var failureError: Error? {
        error
    }

    @available(*, deprecated, message: "Use result instead", renamed: "result")
    var successResult: Result? {
        result
    }
}
