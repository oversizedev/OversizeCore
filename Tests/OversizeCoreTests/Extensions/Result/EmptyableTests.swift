//
// Copyright © 2026 Alexander Romanov
// EmptyableTests.swift
//

@testable import OversizeCore
import Testing

struct EmptyableTests {
    private struct Box: Emptyable {
        let items: [Int]

        var isEmpty: Bool {
            items.isEmpty
        }
    }

    @Test func isEmpty_withoutItems_returnsTrue() {
        let box: any Emptyable = Box(items: [])
        #expect(box.isEmpty)
    }

    @Test func isEmpty_withItems_returnsFalse() {
        let box: any Emptyable = Box(items: [1])
        #expect(!box.isEmpty)
    }
}
