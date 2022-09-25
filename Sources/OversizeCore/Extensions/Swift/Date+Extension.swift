//
// Copyright © 2022 Alexander Romanov
// Date+Extension.swift
//

import Foundation

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

    var noon: Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    var month: Int {
        Calendar.current.component(.month, from: self)
    }

    var isLastDayOfMonth: Bool {
        dayAfter.month != month
    }
}

extension Date: RawRepresentable {
    private static let formatter: ISO8601DateFormatter = .init()

    public var rawValue: String {
        Date.formatter.string(from: self)
    }

    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}
