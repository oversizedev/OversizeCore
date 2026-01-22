//
// Copyright © 2025 Alexander Romanov
// EmptyableLoadingState.swift, created on 02.08.2025
//

import Foundation

public enum EmptyableLoadingState<Result: Sendable>: Sendable {
    case idle
    case loading
    case result(Result)
    case empty
    case error(Error)
}

public extension EmptyableLoadingState {
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

    var isEmpty: Bool {
        switch self {
        case .empty:
            true
        default:
            false
        }
    }

    var hasContent: Bool {
        switch self {
        case .result:
            true
        default:
            false
        }
    }

    var successResult: Result? {
        switch self {
        case let .result(result):
            result
        default:
            nil
        }
    }

    var failureError: Error? {
        switch self {
        case let .error(error):
            error
        default:
            nil
        }
    }
}

extension EmptyableLoadingState: Equatable where Result: Equatable {
    public static func == (lhs: EmptyableLoadingState<Result>, rhs: EmptyableLoadingState<Result>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            true
        case (.loading, .loading):
            true
        case (.empty, .empty):
            true
        case let (.result(lhsResult), .result(rhsResult)):
            lhsResult == rhsResult
        case let (.error(lhsError), .error(rhsError)):
            lhsError.localizedDescription == rhsError.localizedDescription
        default:
            false
        }
    }
}
