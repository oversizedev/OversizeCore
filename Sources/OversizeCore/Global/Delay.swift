//
// Copyright © 2022 Alexander Romanov
// Delay.swift
//

import Foundation

public func delay(time: TimeInterval, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time,
                                  execute: execute)
}
