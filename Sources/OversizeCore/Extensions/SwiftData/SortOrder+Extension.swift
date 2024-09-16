//
// Copyright © 2024 Alexander Romanov
// SortOrder+Extension.swift, created on 28.06.2024
//

import Foundation

extension SortOrder: @retroactive CaseIterable, @retroactive Identifiable {
    public static var allCases: [SortOrder] = [.forward, .reverse]

    public var title: String {
        switch self {
        case .forward:
            "Ascending"
        case .reverse:
            "Descending"
        }
    }

    public var id: String { title }
}
