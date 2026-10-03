//
// Copyright © 2026 Alexander Romanov
// SequenceExtensionsTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

struct SequenceRemovingDuplicatesTests {
    private struct Item: Hashable {
        let id: String
        let name: String
    }

    @Test func removingDuplicatesByKeyPath_keepsFirstOccurrence() {
        let items = [
            Item(id: "1", name: "first"),
            Item(id: "1", name: "duplicate"),
            Item(id: "2", name: "second"),
        ]
        let result = items.removingDuplicates(by: \.id)
        #expect(result.map(\.name) == ["first", "second"])
    }

    @Test func removingDuplicatesByKeyPath_withoutDuplicates_keepsEverything() {
        let items = [Item(id: "1", name: "a"), Item(id: "2", name: "b")]
        #expect(items.removingDuplicates(by: \.id).count == 2)
    }

    @Test func removingDuplicatesByKeyPath_withEmptySequence_returnsEmpty() {
        #expect([Item]().removingDuplicates(by: \.id).isEmpty)
    }
}
