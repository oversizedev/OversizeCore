//
//  File.swift
//
//
//  Created by aromanov on 04.09.2022.
//

import Foundation

public extension Decimal {
    /// Round `Decimal` number to certain number of decimal places.
    ///
    /// - Parameters:
    ///   - scale: How many decimal places.
    ///   - roundingMode: How should number be rounded. Defaults to `.plain`.
    /// - Returns: The new rounded number.

    func rounded(_ scale: Int, roundingMode: RoundingMode = .plain) -> Decimal {
        var value = self
        var result: Decimal = 0
        NSDecimalRound(&result, &value, scale, roundingMode)
        return result
    }
}
