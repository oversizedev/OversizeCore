//
// Copyright © 2022 Alexander Romanov
// Log.swift
//

import Foundation

public func log(_ objects: Any...) {
    #if DEBUG
    log(objects.map { "\($0)" }.joined(separator: ", "))
    #endif
}

public func log(_ object: Any?) {
    #if DEBUG
    if let object {
        log(object)
    } else {
        log(String(describing: object))
    }
    #endif
}

@inlinable public func log(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print(text) : print(text, terminator: terminator!)
    #endif
}

public func logWithTime(_ text: String, terminator: String? = nil) {
    #if DEBUG
    let textTime: String = Date().formatted(.dateTime)
    let textWithTime = "🕓 [\(textTime)] \(text)"
    terminator == nil ? print(textWithTime) : print(textWithTime, terminator: terminator!)
    #endif
}

@inlinable public func logDebug(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("⚪ [DEBUG] \(text)") : print("⚪ [DEBUG] \(text)", terminator: terminator!)
    #endif
}

@inlinable public func logNotice(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🛎️ [NOTICE] \(text)") : print("🛎️ [NOTICE] \(text)", terminator: terminator!)
    #endif
}

@inlinable public func logInfo(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("ℹ️ [INFO] \(text)") : print("ℹ️ [INFO] \(text)", terminator: terminator!)
    #endif
}

@_disfavoredOverload
@inlinable public func logSuccess(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("✅ [SUCCESS] \(text)") : print("✅ [SUCCESS] \(text)", terminator: terminator!)
    #endif
}

public func logSuccess(_ text: String, object: Any?) {
    #if DEBUG
    print("✅ [SUCCESS] \(text), object:\n")
    log(object)
    #endif
}

@inlinable public func logWarning(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("⚠️ [WARNING] \(text)") : print("⚠️ [WARNING] \(text)", terminator: terminator!)
    #endif
}

@inlinable public func logError(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🔴 [ERROR] \(text)") : print("🔴 [ERROR] \(text)", terminator: terminator!)
    #endif
}

@inlinable public func logError(_ text: String, error: Error, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🔴 [ERROR] \(text):\n\(error.localizedDescription)\n\(error)") : print("🔴 [ERROR] \(text):\n\(error.localizedDescription)", terminator: terminator!)
    #endif
}

@inlinable public func logError(_ text: String, error: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🔴 [ERROR] \(text):\n\(error)") : print("🔴 [ERROR] \(text):\n\(error)", terminator: terminator!)
    #endif
}

@inlinable public func logDeleted(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🗑️ [DELETED] \(text)") : print("🗑️ [DELETED] \(text)", terminator: terminator!)
    #endif
}

@inlinable public func logData(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("💽 [DATA] \(text)") : print("💽 [DATA] \(text)", terminator: terminator!)
    #endif
}

@inlinable public func logUrl(_ text: String? = nil, url: URL?, terminator: String? = nil) {
    #if DEBUG
    guard let url else {
        log("🔗 [URL] Nil or not valid URL", terminator: terminator)
        return
    }
    if let text {
        url.isFileURL ? log("📁 [URL] \(text):\n\(url.path)", terminator: terminator) : log("🌐 [URL] \(text):\n\(url.absoluteString)", terminator: terminator)
    } else {
        url.isFileURL ? log("📁 [URL] \(url.path)", terminator: terminator) : log("🌐 [URL] \(url.absoluteString)", terminator: terminator)
    }
    #endif
}
