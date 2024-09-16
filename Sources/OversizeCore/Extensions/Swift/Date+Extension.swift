//
// Copyright © 2022 Alexander Romanov
// Date+Extension.swift
//

import Foundation

public extension Date {
    func startOfMonth() -> Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func endOfMonth() -> Date {
        Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth())!
    }
}

public extension Date {
    static var yesterday: Date { Date().dayBefore }
    static var tomorrow: Date { Date().dayAfter }
    var dayBefore: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }

    var dayAfter: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }

    var weekAfter: Date {
        Calendar.current.date(byAdding: .day, value: 7, to: noon)!
    }

    var weekBefore: Date {
        Calendar.current.date(byAdding: .day, value: -7, to: noon)!
    }

    var hour: Date {
        Calendar.current.date(bySettingHour: 1, minute: 0, second: 0, of: self)!
    }

    var year: Date {
        Calendar.current.date(byAdding: .year, value: 1, to: self)!
    }

    var yearBefore: Date {
        Calendar.current.date(byAdding: .year, value: -1, to: self)!
    }

    var month: Date {
        Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }

    var minute: Date {
        Calendar.current.date(byAdding: .minute, value: 1, to: self)!
    }

    var minuteBefore: Date {
        Calendar.current.date(byAdding: .minute, value: -1, to: self)!
    }

    var halfHour: Date {
        Calendar.current.date(byAdding: .minute, value: 30, to: self)!
    }

    var monthBefore: Date {
        Calendar.current.date(byAdding: .day, value: -30, to: self)!
    }

    var halfYarBefore: Date {
        Calendar.current.date(byAdding: .month, value: -6, to: self)!
    }

    var quarterBefore: Date {
        Calendar.current.date(byAdding: .month, value: -3, to: self)!
    }

    var noon: Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    var midnight: Date {
        Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }

    var monthNumber: Int {
        Calendar.current.component(.month, from: self)
    }

    var dayNumber: Int {
        Calendar.current.component(.day, from: self)
    }

    var isLastDayOfMonth: Bool {
        dayAfter.monthNumber != monthNumber
    }
}

public extension Date {
    func years(from date: Date) -> Int {
        Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }

    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }

    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }

    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }

    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }

    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }

    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
}

extension Date: @retroactive RawRepresentable {
    private static let formatter: ISO8601DateFormatter = .init()

    public var rawValue: String {
        Date.formatter.string(from: self)
    }

    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}

public extension Date {
    func componentTitle(_ type: Calendar.Component) -> String {
        let calendar = Calendar.current
        let t = calendar.component(type, from: self)
        return t < 10 ? "0\(t)" : t.description
    }

    func component(_ type: Calendar.Component) -> Int {
        let calendar = Calendar.current
        let t = calendar.component(type, from: self)
        return t
    }
}

public extension Date {
    var displayTodayLabelOrDate: String {
        if Calendar.current.isDateInToday(self) {
            return "Today"
        } else if Calendar.current.isDateInTomorrow(self) {
            return "Tomorrow"
        } else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        } else if Calendar.current.component(.year, from: self) == Calendar.current.component(.year, from: Date()) {
            return "\(formatted(.dateTime.day().month(.wide)))"
        } else {
            return "\(formatted(.dateTime.day().month(.wide).year()))"
        }
    }
}

public extension DateFormatter {
    static let monthAndYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        return formatter
    }()
}
