//
// Copyright © 2022 Alexander Romanov
// Double+Extension.swift
//

import Foundation

public extension Double {
    var toStringTemperature: String {
        let conv = rounded()
        let temp = String(format: "%.0f", conv) + "°"
        if conv == 0 {
            return temp.replacingOccurrences(of: "-", with: "")
        } else if self < 0 {
            return temp.replacingOccurrences(of: "-", with: "−")
        } else {
            return temp
        }
    }
}
