//
// Copyright © 2022 Alexander Romanov
// Log.swift
//

import Foundation

public func log(_ objects: Any...) {
    #if DEBUG
        log(objects.map { "\($0)" }.joined(separator: " "))
    #endif
}

public func log(_ object: Any?) {
    #if DEBUG
        if let object {
            log("⚪️ \(object)")
        } else {
            log("⚪️ \(String(describing: object))")
        }
    #endif
}

@inlinable public func log(_ text: String, terminator: String? = nil) {
    #if DEBUG
        terminator == nil ? print(text) : print(text, terminator: terminator!)
    #endif
}

public func logWithTime(_: String, terminator: String? = nil) {
    #if DEBUG
        let textWithTime: String = Date().formatted(.dateTime)
        terminator == nil ? print(textWithTime) : print(textWithTime, terminator: terminator!)
    #endif
}
