//
//  File.swift
//
//
//  Created by aromanov on 05.09.2022.
//

import Foundation

public func delay(time: TimeInterval, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time,
                                  execute: execute)
}
