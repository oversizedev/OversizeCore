//
// Copyright © 2023 Alexander Romanov
// Calendar+Extension.swift, created on 02.04.2023
//

import Foundation

public extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents,
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime,
        ) { date, _, stop in
            if let date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}

public extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)

        return numberOfDays.day ?? 0
    }
}
