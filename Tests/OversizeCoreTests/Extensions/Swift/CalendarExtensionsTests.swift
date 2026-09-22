//
// Copyright © 2026 Alexander Romanov
// CalendarExtensionsTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

struct CalendarExtensionTests {
    private let calendar = Calendar.current
    private let start = Date(timeIntervalSince1970: 1_718_280_000).startOfDay

    @Test func numberOfDaysBetween_forwardRange_returnsPositiveCount() throws {
        let end = try #require(calendar.date(byAdding: .day, value: 3, to: start))
        #expect(calendar.numberOfDaysBetween(start, and: end) == 3)
    }

    @Test func numberOfDaysBetween_backwardRange_returnsNegativeCount() throws {
        let end = try #require(calendar.date(byAdding: .day, value: 3, to: start))
        #expect(calendar.numberOfDaysBetween(end, and: start) == -3)
    }

    @Test func numberOfDaysBetween_sameDay_returnsZero() {
        #expect(calendar.numberOfDaysBetween(start, and: start.endOfDay) == 0)
    }

    @Test func generateDates_returnsIntervalStartAndEveryMatch() throws {
        let end = try #require(calendar.date(byAdding: .day, value: 3, to: start))
        let dates = calendar.generateDates(
            inside: DateInterval(start: start, end: end),
            matching: DateComponents(hour: 0, minute: 0, second: 0),
        )
        #expect(dates.count == 3)
        #expect(dates.first == start)
        #expect(dates.allSatisfy { $0 >= start && $0 < end })
    }

    @Test func generateDates_withEmptyInterval_returnsOnlyStart() {
        let dates = calendar.generateDates(
            inside: DateInterval(start: start, end: start),
            matching: DateComponents(hour: 0, minute: 0, second: 0),
        )
        #expect(dates == [start])
    }
}
