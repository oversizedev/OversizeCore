//
// Copyright © 2025 Alexander Romanov
// SearchableLoadingState.swift, created on 02.08.2025
//

import Foundation

public enum SearchableLoadingState<Result: Sendable>: Sendable {
    case idle
    case loading
    case result(Result)
    case search(query: String)
    case searchResult(query: String, result: Result)
    case searchEmpty(query: String)
    case empty
    case error(Error)
}

public extension SearchableLoadingState {
    var isLoading: Bool {
        switch self {
        case .loading, .search, .idle:
            true
        default:
            false
        }
    }

    var isSearching: Bool {
        switch self {
        case .search:
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

    var isSearchResult: Bool {
        switch self {
        case .searchResult:
            true
        default:
            false
        }
    }

    var isSearchEmpty: Bool {
        switch self {
        case .searchEmpty:
            true
        default:
            false
        }
    }

    var hasContent: Bool {
        switch self {
        case .result, .searchResult:
            true
        default:
            false
        }
    }

    var successResult: Result? {
        switch self {
        case let .result(result):
            result
        case let .searchResult(_, result):
            result
        default:
            nil
        }
    }

    var searchQuery: String? {
        switch self {
        case let .search(query):
            query
        case let .searchResult(query, _):
            query
        case let .searchEmpty(query):
            query
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

extension SearchableLoadingState: Equatable where Result: Equatable {
    public static func == (lhs: SearchableLoadingState<Result>, rhs: SearchableLoadingState<Result>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            true
        case (.loading, .loading):
            true
        case let (.result(lhsResult), .result(rhsResult)):
            lhsResult == rhsResult
        case let (.search(lhsQuery), .search(rhsQuery)):
            lhsQuery == rhsQuery
        case let (.searchResult(lhsQuery, lhsResult), .searchResult(rhsQuery, rhsResult)):
            lhsQuery == rhsQuery && lhsResult == rhsResult
        case let (.searchEmpty(lhsQuery), .searchEmpty(rhsQuery)):
            lhsQuery == rhsQuery
        case (.empty, .empty):
            true
        case let (.error(lhsError), .error(rhsError)):
            lhsError.localizedDescription == rhsError.localizedDescription
        default:
            false
        }
    }
}
