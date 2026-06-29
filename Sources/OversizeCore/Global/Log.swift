//
// Copyright © 2022 Alexander Romanov
// Log.swift
//

#if canImport(OSLog)
import OSLog

// MARK: - Log

public enum Log {
    public static func trace(_ message: String) {
        Logger.general.trace("\(message, privacy: .public)")
    }

    public static func debug(_ message: String) {
        Logger.general.debug("\(message, privacy: .public)")
    }

    public static func debug(_ items: Any..., separator: String = " ") {
        let output = items.map { "\($0)" }.joined(separator: separator)
        Logger.general.debug("\(output, privacy: .public)")
    }

    public static func info(_ message: String) {
        Logger.general.info("\(message, privacy: .public)")
    }

    public static func notice(_ message: String) {
        Logger.general.notice("\(message, privacy: .public)")
    }

    public static func warning(_ message: String) {
        Logger.general.warning("\(message, privacy: .public)")
    }

    public static func error(_ message: String) {
        Logger.general.error("\(message, privacy: .public)")
    }

    public static func error(_ message: String, error: Error) {
        let description: String = .init(describing: error)
        Logger.general.error("\(message, privacy: .public):\n\(error.localizedDescription, privacy: .public)\n\(description, privacy: .public)")
    }

    public static func critical(_ message: String) {
        Logger.general.critical("\(message, privacy: .public)")
    }

    public static func fault(_ message: String) {
        Logger.general.fault("\(message, privacy: .public)")
    }
}

public extension Log {
    static func ui(_ message: String) {
        Logger.ui.debug("\(message, privacy: .public)")
    }

    static func network(_ message: String) {
        Logger.network.debug("\(message, privacy: .public)")
    }

    static func security(_ message: String) {
        Logger.security.notice("\(message, privacy: .private)")
    }

    static func debug(_ message: String?, url: URL?) {
        guard let url else {
            Logger.url.debug("Not valid URL")
            return
        }
        if let message {
            if url.isFileURL {
                Logger.url.debug("\(message, privacy: .public)\nFile URL: \(url.path, privacy: .private)")
            } else {
                Logger.url.debug("\(message, privacy: .public):\nURL: \(url.absoluteString, privacy: .private)")
            }
        } else {
            if url.isFileURL {
                Logger.url.debug("File URL:\n\(url.path, privacy: .private)")
            } else {
                Logger.url.debug("URL:\n\(url.absoluteString, privacy: .private)")
            }
        }
    }

    static func debug(url: URL?) {
        guard let url else {
            Logger.url.debug("Not valid URL")
            return
        }
        if url.isFileURL {
            Logger.url.debug("File URL:\n\(url.path, privacy: .private)")
        } else {
            Logger.url.debug("URL:\n\(url.absoluteString, privacy: .private)")
        }
    }
}
#else
import Foundation

// MARK: - Log (Linux fallback)

public enum Log {
    public static func trace(_ message: String) { print("[TRACE] \(message)") }
    public static func debug(_ message: String) { print("[DEBUG] \(message)") }
    public static func debug(_ items: Any..., separator: String = " ") { print("[DEBUG] \(items.map { "\($0)" }.joined(separator: separator))") }
    public static func info(_ message: String) { print("[INFO] \(message)") }
    public static func notice(_ message: String) { print("[NOTICE] \(message)") }
    public static func warning(_ message: String) { print("[WARNING] \(message)") }
    public static func error(_ message: String) { print("[ERROR] \(message)") }
    public static func error(_ message: String, error: Error) { print("[ERROR] \(message):\n\(error.localizedDescription)\n\(error)") }
    public static func critical(_ message: String) { print("[CRITICAL] \(message)") }
    public static func fault(_ message: String) { print("[FAULT] \(message)") }
}

public extension Log {
    static func ui(_ message: String) { print("[UI] \(message)") }
    static func network(_ message: String) { print("[NETWORK] \(message)") }
    static func security(_ message: String) { print("[SECURITY] \(message)") }
    static func debug(_ message: String?, url: URL?) {
        guard let url else { print("[URL] Not valid URL"); return }
        print("[URL] \(message.map { "\($0): " } ?? "")\(url.absoluteString)")
    }
    static func debug(url: URL?) {
        guard let url else { print("[URL] Not valid URL"); return }
        print("[URL] \(url.absoluteString)")
    }
}
#endif
