//
// Copyright © 2026 Alexander Romanov
// SortOrderExtensionTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

struct SortOrderExtensionTests {
    @Test func allCases_containsBothDirections() {
        #expect(SortOrder.allCases == [.forward, .reverse])
    }

    @Test func title_describesDirection() {
        #expect(SortOrder.forward.title == "Ascending")
        #expect(SortOrder.reverse.title == "Descending")
    }

    @Test func id_matchesTitle() {
        #expect(SortOrder.allCases.allSatisfy { $0.id == $0.title })
    }

    @Test func id_isUnique() {
        #expect(Set(SortOrder.allCases.map(\.id)).count == SortOrder.allCases.count)
    }
}
