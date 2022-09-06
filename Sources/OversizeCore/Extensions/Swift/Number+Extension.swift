//
// Copyright © 2022 Alexander Romanov
// Number+Extension.swift
//

import Foundation
import SwiftUI

public extension Int {
    var toString: String {
        String(self)
    }

    func wordFormat(titles: [String]) -> String {
        let cases = [2, 0, 1, 1, 1, 2]

        let x = self % 100
        if x > 4, x < 20 {
            return titles[2]
        } else {
            let y = self % 10
            let minimum = Swift.min(y, 5)
            let c = cases[minimum]
            return titles[c]
        }
    }

    func stringWithWordFormats(formats: [String], format: String) -> String {
        let string = wordFormat(titles: formats)
        return String(format: format, self, string)
    }

    func stringWithWordFormats(formats: [String]) -> String {
        let format = wordFormat(titles: formats)
        return String(format: format, self)
    }
}

public extension Double {
    var toString: String {
        String(self)
    }
}

public extension Double {
    var toStringWithoutPoint: String {
        String(format: "%.0f", self)
    }
}

public extension Float {
    var toString: String {
        String(self)
    }
}

public extension Float {
    var toStringWithoutPoint: String {
        String(format: "%.0f", self)
    }
}

public extension CGFloat {
    var toStringWithoutPoint: String {
        String(format: "%.0f", self)
    }

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

public extension Decimal {
    var toString: String {
        NSDecimalNumber(decimal: self).stringValue
    }
}
