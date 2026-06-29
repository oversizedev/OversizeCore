//
// Copyright © 2022 Alexander Romanov
// LogGlobal.swift
//

#if canImport(OSLog)
import OSLog

// MARK: - Basic Logging

@available(*, deprecated, renamed: "Log.debug")
public func log(_ objects: Any...) {
    let message = objects.map { "\($0)" }.joined(separator: ", ")
    Logger.general.debug("\(message, privacy: .public)")
}

@available(*, deprecated, renamed: "Log.debug")
public func log(_ object: Any?) {
    if let object {
        let message = "\(object)"
        Logger.general.debug("\(message, privacy: .public)")
    } else {
        Logger.general.debug("nil")
    }
}

@available(*, deprecated, renamed: "Log.debug")
public func log(_ text: String, terminator _: String? = nil) {
    Logger.general.debug("\(text, privacy: .public)")
}

// MARK: - Timestamped Logging

@available(*, deprecated, renamed: "Log.debug")
public func logWithTime(_ text: String, terminator _: String? = nil) {
    Logger.general.debug("🕓 \(text, privacy: .public)")
}

// MARK: - Categorized Logging

@available(*, deprecated, renamed: "Log.debug")
public func logDebug(_ text: String, terminator _: String? = nil) {
    Logger.general.debug("⚪ [DEBUG] \(text, privacy: .public)")
}

@available(*, deprecated, message: "Use Log.debug(_:) instead")
public func logUI(_ text: String, terminator _: String? = nil) {
    Logger.ui.debug("🖥️ [UI] \(text, privacy: .public)")
}

@available(*, deprecated, renamed: "Log.notice")
public func logNotice(_ text: String, terminator _: String? = nil) {
    Logger.general.notice("🛎️ [NOTICE] \(text, privacy: .public)")
}

@available(*, deprecated, message: "Use Log.debug(_:) instead")
public func logNetwork(_ text: String, terminator _: String? = nil) {
    Logger.network.debug("🌎 [NETWORK] \(text, privacy: .public)")
}

@available(*, deprecated, renamed: "Log.info")
public func logInfo(_ text: String, terminator _: String? = nil) {
    Logger.general.info("ℹ️ [INFO] \(text, privacy: .public)")
}

@available(*, deprecated, message: "Use Log.notice(_:) instead")
public func logSecurity(_ text: String, terminator _: String? = nil) {
    Logger.security.notice("🔐 [SECURITY] \(text, privacy: .private)")
}

// MARK: - Success Logging

@_disfavoredOverload
@available(*, deprecated, renamed: "Log.info")
public func logSuccess(_ text: String, terminator _: String? = nil) {
    Logger.general.info("✅ [SUCCESS] \(text, privacy: .public)")
}

@available(*, deprecated, renamed: "Log.info")
public func logSuccess(_ text: String, object: Any?) {
    let objectDescription = String(describing: object)
    Logger.general.info("✅ [SUCCESS] \(text, privacy: .public), object:\n\(objectDescription, privacy: .public)")
}

// MARK: - Warning and Error Logging

@available(*, deprecated, renamed: "Log.warning")
public func logWarning(_ text: String, terminator _: String? = nil) {
    Logger.general.notice("⚠️ [WARNING] \(text, privacy: .public)")
}

@available(*, deprecated, renamed: "Log.error")
public func logError(_ text: String, terminator _: String? = nil) {
    Logger.general.error("🔴 [ERROR] \(text, privacy: .public)")
}

@available(*, deprecated, renamed: "Log.error(_:error:)")
public func logError(_ text: String, error: Error, terminator _: String? = nil) {
    let description = String(describing: error)
    Logger.general.error("🔴 [ERROR] \(text, privacy: .public):\n\(error.localizedDescription, privacy: .public)\n\(description, privacy: .public)")
}

@available(*, deprecated, renamed: "Log.error(_:error:)")
public func logError(_ text: String, _ error: Error, terminator: String? = nil) {
    logError(text, error: error, terminator: terminator)
}

@available(*, deprecated, renamed: "Log.error")
public func logError(_ text: String, error: String, terminator _: String? = nil) {
    Logger.general.error("🔴 [ERROR] \(text, privacy: .public):\n\(error, privacy: .public)")
}

// MARK: - Specialized Logging

@available(*, deprecated, message: "Use Log.info(_:) instead")
public func logDeleted(_ text: String, terminator _: String? = nil) {
    Logger.data.info("🗑️ [DELETED] \(text, privacy: .public)")
}

@available(*, deprecated, message: "Use Log.debug(_:) instead")
public func logCloud(_ text: String) {
    Logger.cloud.debug("☁️ [CLOUD] \(text, privacy: .public)")
}

@available(*, deprecated, message: "Use Log.debug(_:) instead")
public func logData(_ text: String, terminator _: String? = nil) {
    Logger.data.debug("💽 [DATA] \(text, privacy: .public)")
}

@available(*, deprecated, message: "Use Log.debug(_:url:) instead")
public func logUrl(_ text: String? = nil, url: URL?, terminator _: String? = nil) {
    guard let url else {
        Logger.url.debug("🔗 [URL] Nil or not valid URL")
        return
    }
    if let text {
        if url.isFileURL {
            Logger.url.debug("📁 [URL] \(text, privacy: .public):\n\(url.path, privacy: .public)")
        } else {
            Logger.url.debug("🌐 [URL] \(text, privacy: .public):\n\(url.absoluteString, privacy: .public)")
        }
    } else {
        if url.isFileURL {
            Logger.url.debug("📁 [URL] \(url.path, privacy: .public)")
        } else {
            Logger.url.debug("🌐 [URL] \(url.absoluteString, privacy: .public)")
        }
    }
}
#else
import Foundation

@available(*, deprecated, renamed: "Log.debug")
public func log(_ objects: Any...) { print(objects.map { "\($0)" }.joined(separator: ", ")) }
@available(*, deprecated, renamed: "Log.debug")
public func log(_ object: Any?) { print(object.map { "\($0)" } ?? "nil") }
@available(*, deprecated, renamed: "Log.debug")
public func log(_ text: String, terminator _: String? = nil) { print(text) }
@available(*, deprecated, renamed: "Log.debug")
public func logWithTime(_ text: String, terminator _: String? = nil) { print("🕓 \(text)") }
@available(*, deprecated, renamed: "Log.debug")
public func logDebug(_ text: String, terminator _: String? = nil) { print("⚪ [DEBUG] \(text)") }
@available(*, deprecated, message: "Use Log.debug(_:) instead")
public func logUI(_ text: String, terminator _: String? = nil) { print("🖥️ [UI] \(text)") }
@available(*, deprecated, renamed: "Log.notice")
public func logNotice(_ text: String, terminator _: String? = nil) { print("🛎️ [NOTICE] \(text)") }
@available(*, deprecated, message: "Use Log.debug(_:) instead")
public func logNetwork(_ text: String, terminator _: String? = nil) { print("🌎 [NETWORK] \(text)") }
@available(*, deprecated, renamed: "Log.info")
public func logInfo(_ text: String, terminator _: String? = nil) { print("ℹ️ [INFO] \(text)") }
@available(*, deprecated, message: "Use Log.notice(_:) instead")
public func logSecurity(_ text: String, terminator _: String? = nil) { print("🔐 [SECURITY] \(text)") }
@_disfavoredOverload
@available(*, deprecated, renamed: "Log.info")
public func logSuccess(_ text: String, terminator _: String? = nil) { print("✅ [SUCCESS] \(text)") }
@available(*, deprecated, renamed: "Log.info")
public func logSuccess(_ text: String, object: Any?) { print("✅ [SUCCESS] \(text), object:\n\(String(describing: object))") }
@available(*, deprecated, renamed: "Log.warning")
public func logWarning(_ text: String, terminator _: String? = nil) { print("⚠️ [WARNING] \(text)") }
@available(*, deprecated, renamed: "Log.error")
public func logError(_ text: String, terminator _: String? = nil) { print("🔴 [ERROR] \(text)") }
@available(*, deprecated, renamed: "Log.error(_:error:)")
public func logError(_ text: String, error: Error, terminator _: String? = nil) { print("🔴 [ERROR] \(text):\n\(error.localizedDescription)\n\(error)") }
@available(*, deprecated, renamed: "Log.error(_:error:)")
public func logError(_ text: String, _ error: Error, terminator: String? = nil) { logError(text, error: error, terminator: terminator) }
@available(*, deprecated, renamed: "Log.error")
public func logError(_ text: String, error: String, terminator _: String? = nil) { print("🔴 [ERROR] \(text):\n\(error)") }
@available(*, deprecated, message: "Use Log.info(_:) instead")
public func logDeleted(_ text: String, terminator _: String? = nil) { print("🗑️ [DELETED] \(text)") }
@available(*, deprecated, message: "Use Log.debug(_:) instead")
public func logCloud(_ text: String) { print("☁️ [CLOUD] \(text)") }
@available(*, deprecated, message: "Use Log.debug(_:) instead")
public func logData(_ text: String, terminator _: String? = nil) { print("💽 [DATA] \(text)") }
@available(*, deprecated, message: "Use Log.debug(_:url:) instead")
public func logUrl(_ text: String? = nil, url: URL?, terminator _: String? = nil) {
    guard let url else { print("🔗 [URL] Nil or not valid URL"); return }
    let prefix = text.map { "\($0):\n" } ?? ""
    print(url.isFileURL ? "📁 [URL] \(prefix)\(url.path)" : "🌐 [URL] \(prefix)\(url.absoluteString)")
}
#endif
