//
// Copyright © 2026 Alexander Romanov
// DateExtensionsTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

private let referenceDate = Date(timeIntervalSince1970: 1_718_280_000)

private func dayDelta(from start: Date, to end: Date) -> Int {
    Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0
}

private func monthDelta(from start: Date, to end: Date) -> Int {
    Calendar.current.dateComponents([.month], from: start, to: end).month ?? 0
}

private func yearDelta(from start: Date, to end: Date) -> Int {
    Calendar.current.dateComponents([.year], from: start, to: end).year ?? 0
}

// MARK: - Offsets

struct DateOffsetTests {
    @Test func dayAfter_movesOneDayForward() {
        #expect(dayDelta(from: referenceDate.noon, to: referenceDate.dayAfter) == 1)
    }

    @Test func dayBefore_movesOneDayBack() {
        #expect(dayDelta(from: referenceDate.noon, to: referenceDate.dayBefore) == -1)
    }

    @Test func weekAfter_movesSevenDaysForward() {
        #expect(dayDelta(from: referenceDate.noon, to: referenceDate.weekAfter) == 7)
    }

    @Test func weekBefore_movesSevenDaysBack() {
        #expect(dayDelta(from: referenceDate.noon, to: referenceDate.weekBefore) == -7)
    }

    @Test func month_movesOneMonthForward() {
        #expect(monthDelta(from: referenceDate, to: referenceDate.month) == 1)
    }

    @Test func monthBefore_movesOneMonthBack() {
        #expect(monthDelta(from: referenceDate, to: referenceDate.monthBefore) == -1)
    }

    @Test func quarterBefore_movesThreeMonthsBack() {
        #expect(monthDelta(from: referenceDate, to: referenceDate.quarterBefore) == -3)
    }

    @Test func halfYearBefore_movesSixMonthsBack() {
        #expect(monthDelta(from: referenceDate, to: referenceDate.halfYearBefore) == -6)
    }

    @Test func year_movesOneYearForward() {
        #expect(yearDelta(from: referenceDate, to: referenceDate.year) == 1)
    }

    @Test func yearBefore_movesOneYearBack() {
        #expect(yearDelta(from: referenceDate, to: referenceDate.yearBefore) == -1)
    }

    @Test func hour_addsOneHour() {
        #expect(referenceDate.hour.timeIntervalSince(referenceDate) == 3600)
    }

    @Test func minute_addsOneMinute() {
        #expect(referenceDate.minute.timeIntervalSince(referenceDate) == 60)
    }

    @Test func minuteBefore_subtractsOneMinute() {
        #expect(referenceDate.minuteBefore.timeIntervalSince(referenceDate) == -60)
    }

    @Test func halfHour_addsThirtyMinutes() {
        #expect(referenceDate.halfHour.timeIntervalSince(referenceDate) == 1800)
    }

    @Test func yesterday_isOneDayBeforeTomorrow() {
        #expect(dayDelta(from: Date.yesterday, to: Date.tomorrow) == 2)
    }
}

// MARK: - Boundaries

struct DateBoundaryTests {
    @Test func noon_setsMiddayComponents() {
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: referenceDate.noon)
        #expect(components.hour == 12)
        #expect(components.minute == 0)
        #expect(components.second == 0)
    }

    @Test func midnight_setsStartOfDayComponents() {
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: referenceDate.midnight)
        #expect(components.hour == 0)
        #expect(components.minute == 0)
        #expect(components.second == 0)
    }

    @Test func endOfDay_setsLastSecondOfDay() {
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: referenceDate.endOfDay)
        #expect(components.hour == 23)
        #expect(components.minute == 59)
        #expect(components.second == 59)
    }

    @Test func startOfDay_matchesCalendar() {
        #expect(referenceDate.startOfDay == Calendar.current.startOfDay(for: referenceDate))
    }

    @Test func startOfMonth_returnsFirstDay() {
        #expect(referenceDate.startOfMonth().dayNumber == 1)
    }

    @Test func startOfMonth_keepsSameMonth() {
        #expect(referenceDate.startOfMonth().monthNumber == referenceDate.monthNumber)
    }

    @Test func endOfMonth_returnsLastDayOfSameMonth() {
        let endOfMonth = referenceDate.endOfMonth()
        #expect(endOfMonth.monthNumber == referenceDate.monthNumber)
        #expect(endOfMonth.isLastDayOfMonth)
    }

    @Test func isLastDayOfMonth_withFirstDayOfMonth_returnsFalse() {
        #expect(!referenceDate.startOfMonth().isLastDayOfMonth)
    }
}

// MARK: - Components

struct DateComponentTests {
    @Test func monthNumber_matchesCalendar() {
        #expect(referenceDate.monthNumber == Calendar.current.component(.month, from: referenceDate))
    }

    @Test func dayNumber_matchesCalendar() {
        #expect(referenceDate.dayNumber == Calendar.current.component(.day, from: referenceDate))
    }

    @Test func component_matchesCalendar() {
        #expect(referenceDate.component(.year) == Calendar.current.component(.year, from: referenceDate))
    }

    @Test func componentTitle_padsSingleDigitWithZero() {
        let startOfMonth = referenceDate.startOfMonth()
        #expect(startOfMonth.componentTitle(.day) == "01")
    }

    @Test func componentTitle_withFourDigitYear_keepsValue() {
        #expect(referenceDate.componentTitle(.year) == referenceDate.component(.year).description)
    }
}

// MARK: - Deltas

struct DateDeltaTests {
    @Test func years_returnsWholeYears() {
        #expect(referenceDate.year.years(from: referenceDate) == 1)
    }

    @Test func months_returnsWholeMonths() {
        #expect(referenceDate.month.months(from: referenceDate) == 1)
    }

    @Test func weeks_returnsWholeWeeks() {
        #expect(referenceDate.weekAfter.weeks(from: referenceDate.noon) == 1)
    }

    @Test func days_returnsWholeDays() {
        #expect(referenceDate.dayAfter.days(from: referenceDate.noon) == 1)
    }

    @Test func hours_returnsWholeHours() {
        #expect(referenceDate.hour.hours(from: referenceDate) == 1)
    }

    @Test func minutes_returnsWholeMinutes() {
        #expect(referenceDate.halfHour.minutes(from: referenceDate) == 30)
    }

    @Test func seconds_returnsWholeSeconds() {
        #expect(referenceDate.minute.seconds(from: referenceDate) == 60)
    }

    @Test func days_withSameDate_returnsZero() {
        #expect(referenceDate.days(from: referenceDate) == 0)
    }
}

// MARK: - Formatting

struct DateFormattingTests {
    @Test func toString_withDefaultFormat_usesISODay() {
        #expect(Date(timeIntervalSince1970: 0).toString() == "1970-01-01")
    }

    @Test func toString_withCustomFormat_appliesFormat() {
        #expect(Date(timeIntervalSince1970: 0).toString(format: "yyyy/MM/dd HH:mm") == "1970/01/01 00:00")
    }

    @Test func toString_withTimeZone_shiftsResult() {
        let date = Date(timeIntervalSince1970: 0)
        #expect(date.toString(format: "HH", timeZone: "Europe/Moscow") == "03")
    }

    @Test func monthAndYearFormatter_producesNonEmptyString() {
        #expect(!DateFormatter.monthAndYear.string(from: referenceDate).isEmpty)
    }

    @Test func displayTodayLabelOrDate_withToday_returnsToday() {
        #expect(Date().displayTodayLabelOrDate == "Today")
    }

    @Test func displayTodayLabelOrDate_withTomorrow_returnsTomorrow() {
        #expect(Date.tomorrow.displayTodayLabelOrDate == "Tomorrow")
    }

    @Test func displayTodayLabelOrDate_withYesterday_returnsYesterday() {
        #expect(Date.yesterday.displayTodayLabelOrDate == "Yesterday")
    }

    @Test func displayTodayLabelOrDate_withDistantDate_returnsFormattedDate() {
        let distant = Date(timeIntervalSince1970: 0)
        let label = distant.displayTodayLabelOrDate
        #expect(!["Today", "Tomorrow", "Yesterday"].contains(label))
        #expect(!label.isEmpty)
    }
}

// MARK: - RawRepresentable

struct DateRawRepresentableTests {
    @Test func rawValue_roundTrips() throws {
        let date = Date(timeIntervalSince1970: 1_718_280_000)
        let restored = try #require(Date(rawValue: date.rawValue))
        #expect(abs(restored.timeIntervalSince(date)) < 1)
    }

    @Test func initRawValue_withInvalidString_returnsNil() {
        #expect(Date(rawValue: "not-a-date") == nil)
    }

    @Test func initRawValue_withEmptyString_returnsNil() {
        #expect(Date(rawValue: "") == nil)
    }
}
