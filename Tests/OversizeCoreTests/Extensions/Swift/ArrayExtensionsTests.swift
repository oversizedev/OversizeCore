//
// Copyright © 2026 Alexander Romanov
// ArrayExtensionsTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

// MARK: - Numeric sequences

struct SequenceNumericTests {
    @Test func strings_convertsEveryInt() {
        #expect([1, 2, 3].strings == ["1", "2", "3"])
    }

    @Test func strings_withEmptySequence_returnsEmpty() {
        #expect([Int]().strings.isEmpty)
    }

    @Test func intSum_addsEveryElement() {
        #expect([1, 2, 3].sum == 6)
    }

    @Test func intSum_withEmptySequence_returnsZero() {
        #expect([Int]().sum == 0)
    }

    @Test func doubleSum_addsEveryElement() {
        #expect([1.5, 2.5].sum == 4.0)
    }

    @Test func floatSum_addsEveryElement() {
        #expect([Float(1.5), Float(2.5)].sum == Float(4.0))
    }

    @Test func cgFloatSum_addsEveryElement() {
        #expect([CGFloat(1.5), CGFloat(2.5)].sum == CGFloat(4.0))
    }

    @Test func intSubtract_startsFromGivenValue() {
        #expect([1, 2, 3].subtract(10) == 4)
    }

    @Test func doubleSubtract_startsFromGivenValue() {
        #expect([1.0, 2.0].subtract(10.0) == 7.0)
    }

    @Test func floatSubtract_startsFromGivenValue() {
        #expect([Float(1), Float(2)].subtract(Float(10)) == Float(7))
    }

    @Test func cgFloatSubtract_startsFromGivenValue() {
        #expect([CGFloat(1), CGFloat(2)].subtract(CGFloat(10)) == CGFloat(7))
    }
}

// MARK: - Mutation

struct ArrayMutationTests {
    @Test func move_reordersElement() {
        var values = [1, 2, 3]
        values.move(fromPosition: 0, toPosition: 2)
        #expect(values == [2, 3, 1])
    }

    @Test func move_toSamePosition_keepsOrder() {
        var values = [1, 2, 3]
        values.move(fromPosition: 1, toPosition: 1)
        #expect(values == [1, 2, 3])
    }

    @Test func remove_withExistingElement_returnsIndex() {
        var values = [1, 2, 3]
        #expect(values.remove(2) == 1)
        #expect(values == [1, 3])
    }

    @Test func remove_withMissingElement_returnsNil() {
        var values = [1, 2, 3]
        #expect(values.remove(99) == nil)
        #expect(values == [1, 2, 3])
    }

    @Test func remove_removesOnlyFirstOccurrence() {
        var values = [1, 2, 1]
        #expect(values.remove(1) == 0)
        #expect(values == [2, 1])
    }

    @Test func replace_withExistingElement_keepsPosition() {
        var values = [1, 2, 3]
        values.replace(object: 2, ifMissingInsertAt: 0)
        #expect(values == [1, 2, 3])
    }

    @Test func replace_withMissingElementAndIndex_insertsAtIndex() {
        var values = [1, 3]
        values.replace(object: 2, ifMissingInsertAt: 1)
        #expect(values == [1, 2, 3])
    }

    @Test func replace_withMissingElementAndNoIndex_appends() {
        var values = [1, 2]
        values.replace(object: 3, ifMissingInsertAt: nil)
        #expect(values == [1, 2, 3])
    }

    @Test func removeDuplicates_keepsFirstOccurrenceOrder() {
        #expect([3, 1, 3, 2, 1].removeDuplicates() == [3, 1, 2])
    }

    @Test func removeDuplicates_withEmptyArray_returnsEmpty() {
        #expect([Int]().removeDuplicates().isEmpty)
    }
}

// MARK: - Access

struct ArrayAccessTests {
    @Test func element_withValidIndex_returnsElement() {
        #expect([1, 2, 3].element(1) == 2)
    }

    @Test func element_withIndexPastEnd_returnsNil() {
        #expect([1, 2, 3].element(5) == nil)
    }

    @Test func element_withNegativeIndex_returnsNil() {
        #expect([1, 2, 3].element(-1) == nil)
    }

    @Test func compacted_dropsNilElements() {
        let values: [Int?] = [1, nil, 2, nil]
        #expect(values.compacted() == [1, 2])
    }

    @Test func compacted_withAllNil_returnsEmpty() {
        let values: [Int?] = [nil, nil]
        #expect(values.compacted().isEmpty)
    }
}

// MARK: - Navigation

struct CollectionNavigationTests {
    private let values = [1, 2, 3]

    @Test func after_returnsNextElement() {
        #expect(values.after(2) == 3)
    }

    @Test func after_onLastElement_returnsNil() {
        #expect(values.after(3) == nil)
    }

    @Test func after_onLastElementWithLoop_returnsFirst() {
        #expect(values.after(3, loop: true) == 1)
    }

    @Test func after_withMissingElement_returnsNil() {
        #expect(values.after(99, loop: true) == nil)
    }

    @Test func before_returnsPreviousElement() {
        #expect(values.before(2) == 1)
    }

    @Test func before_onFirstElement_returnsNil() {
        #expect(values.before(1) == nil)
    }

    @Test func before_onFirstElementWithLoop_returnsLast() {
        #expect(values.before(1, loop: true) == 3)
    }

    @Test func before_withMissingElement_returnsNil() {
        #expect(values.before(99, loop: true) == nil)
    }
}

// MARK: - RawRepresentable

struct ArrayRawRepresentableTests {
    @Test func rawValue_encodesJSON() {
        #expect([1, 2, 3].rawValue == "[1,2,3]")
    }

    @Test func rawValue_roundTrips() throws {
        let original = ["a", "b"]
        let restored = try #require([String](rawValue: original.rawValue))
        #expect(restored == original)
    }

    @Test func initRawValue_withInvalidJSON_returnsNil() {
        #expect([Int](rawValue: "not-json") == nil)
    }

    @Test func initRawValue_withMismatchedElementType_returnsNil() {
        #expect([Int](rawValue: "[\"a\"]") == nil)
    }
}
