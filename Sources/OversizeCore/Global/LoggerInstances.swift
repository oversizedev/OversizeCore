//
// Copyright © 2022 Alexander Romanov
// LoggerInstances.swift
//

#if canImport(OSLog)
import OSLog

// MARK: - Internal Logger Instances

extension Logger {
    static let subsystem = Bundle.main.bundleIdentifier ?? "app.oversize"
    static let general = Logger(subsystem: subsystem, category: "General")
    static let ui = Logger(subsystem: subsystem, category: "UI")
    static let network = Logger(subsystem: subsystem, category: "Network")
    static let data = Logger(subsystem: subsystem, category: "Data")
    static let security = Logger(subsystem: subsystem, category: "Security")
    static let cloud = Logger(subsystem: subsystem, category: "Cloud")
    static let url = Logger(subsystem: subsystem, category: "URL")
    static let errorLog = Logger(subsystem: subsystem, category: "Error")
}
#endif
