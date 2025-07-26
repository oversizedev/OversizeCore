//
// Copyright © 2022 Alexander Romanov
// Log.swift
//

import Foundation

// MARK: - Basic Logging Functions

/// Logs multiple objects to the console in debug builds.
///
/// This function takes multiple objects and logs them as a comma-separated string.
/// Logging only occurs in debug builds (when DEBUG is defined).
///
/// - Parameter objects: Multiple objects to log
///
/// Example:
/// ```swift
/// log("User:", user.name, "Score:", score)
/// // Output: User: John Doe, Score: 100
/// ```
public func log(_ objects: Any...) {
    #if DEBUG
    log(objects.map { "\($0)" }.joined(separator: ", "))
    #endif
}

/// Logs an optional object to the console in debug builds.
///
/// This function safely logs an optional value, handling nil cases gracefully.
/// Logging only occurs in debug builds (when DEBUG is defined).
///
/// - Parameter object: Optional object to log
///
/// Example:
/// ```swift
/// let optionalValue: String? = "Hello"
/// log(optionalValue) // Output: Hello
///
/// let nilValue: String? = nil
/// log(nilValue) // Output: nil
/// ```
public func log(_ object: Any?) {
    #if DEBUG
    if let object {
        log(object)
    } else {
        log(String(describing: object))
    }
    #endif
}

/// Logs a string to the console with optional terminator in debug builds.
///
/// This is the base logging function that outputs text to the console.
/// Logging only occurs in debug builds (when DEBUG is defined).
///
/// - Parameters:
///   - text: The text to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// log("Hello World")
/// log("Loading...", terminator: "")
/// ```
@inlinable public func log(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print(text) : print(text, terminator: terminator!)
    #endif
}

// MARK: - Timestamped Logging

/// Logs a string with timestamp prefix in debug builds.
///
/// This function adds a timestamp prefix to the log message, useful for tracking
/// when events occur during debugging. Logging only occurs in debug builds.
///
/// - Parameters:
///   - text: The text to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logWithTime("Application started")
/// // Output: 🕓 [2024-01-15 14:30:25] Application started
/// ```
public func logWithTime(_ text: String, terminator: String? = nil) {
    #if DEBUG
    let textTime: String = Date().formatted(.dateTime)
    let textWithTime = "🕓 [\(textTime)] \(text)"
    terminator == nil ? print(textWithTime) : print(textWithTime, terminator: terminator!)
    #endif
}

// MARK: - Categorized Logging Functions

/// Logs a debug message with debug category prefix in debug builds.
///
/// This function is used for general debugging information that helps track
/// application flow and state during development.
///
/// - Parameters:
///   - text: The debug message to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logDebug("User preferences loaded")
/// // Output: ⚪ [DEBUG] User preferences loaded
/// ```
@inlinable public func logDebug(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("⚪ [DEBUG] \(text)") : print("⚪ [DEBUG] \(text)", terminator: terminator!)
    #endif
}

/// Logs a UI-related message with UI category prefix in debug builds.
///
/// This function is used for logging user interface updates, view lifecycle events,
/// and other UI-related debugging information.
///
/// - Parameters:
///   - text: The UI message to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logUI("View did appear")
/// // Output: 🖥️ [UI] View did appear
/// ```
@inlinable public func logUI(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🖥️ [UI] \(text)") : print("⚪ [UI] \(text)", terminator: terminator!)
    #endif
}

/// Logs a notice message with notice category prefix in debug builds.
///
/// This function is used for important notices that require attention but
/// are not errors or warnings.
///
/// - Parameters:
///   - text: The notice message to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logNotice("Cache cleared successfully")
/// // Output: 🛎️ [NOTICE] Cache cleared successfully
/// ```
@inlinable public func logNotice(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🛎️ [NOTICE] \(text)") : print("🛎️ [NOTICE] \(text)", terminator: terminator!)
    #endif
}

/// Logs a network-related message with network category prefix in debug builds.
///
/// This function is used for logging network requests, responses, and
/// connectivity-related debugging information.
///
/// - Parameters:
///   - text: The network message to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logNetwork("API request completed")
/// // Output: 🌎 [NETWORK] API request completed
/// ```
@inlinable public func logNetwork(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🌎 [NETWORK] \(text)") : print("🛎️ [NETWORK] \(text)", terminator: terminator!)
    #endif
}

/// Logs an informational message with info category prefix in debug builds.
///
/// This function is used for general informational messages that provide
/// context about application state and operations.
///
/// - Parameters:
///   - text: The informational message to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logInfo("Database connection established")
/// // Output: ℹ️ [INFO] Database connection established
/// ```
@inlinable public func logInfo(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("ℹ️ [INFO] \(text)") : print("ℹ️ [INFO] \(text)", terminator: terminator!)
    #endif
}

/// Logs a security-related message with security category prefix in debug builds.
///
/// This function is used for logging security-related events, authentication
/// attempts, and other security-sensitive debugging information.
///
/// - Parameters:
///   - text: The security message to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logSecurity("User authenticated successfully")
/// // Output: 🔐 [SECURITY] User authenticated successfully
/// ```
@inlinable public func logSecurity(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🔐 [SECURITY] \(text)") : print("ℹ️ [SECURITY] \(text)", terminator: terminator!)
    #endif
}

// MARK: - Success Logging

/// Logs a success message with success category prefix in debug builds.
///
/// This function is used for logging successful operations and positive outcomes.
/// This overload is marked as disfavored to encourage using the more specific variant.
///
/// - Parameters:
///   - text: The success message to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logSuccess("Data saved successfully")
/// // Output: ✅ [SUCCESS] Data saved successfully
/// ```
@_disfavoredOverload
@inlinable public func logSuccess(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("✅ [SUCCESS] \(text)") : print("✅ [SUCCESS] \(text)", terminator: terminator!)
    #endif
}

/// Logs a success message with an associated object in debug builds.
///
/// This function logs a success message followed by the string representation
/// of the provided object, useful for debugging successful operations with data.
///
/// - Parameters:
///   - text: The success message to log
///   - object: The object to log along with the success message
///
/// Example:
/// ```swift
/// logSuccess("User created", object: user)
/// // Output: ✅ [SUCCESS] User created, object:
/// //         User(name: "John", id: 123)
/// ```
public func logSuccess(_ text: String, object: Any?) {
    #if DEBUG
    print("✅ [SUCCESS] \(text), object:\n")
    log(object)
    #endif
}

// MARK: - Warning and Error Logging

/// Logs a warning message with warning category prefix in debug builds.
///
/// This function is used for logging warning conditions that don't prevent
/// application execution but may indicate potential issues.
///
/// - Parameters:
///   - text: The warning message to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logWarning("Deprecated API usage detected")
/// // Output: ⚠️ [WARNING] Deprecated API usage detected
/// ```
@inlinable public func logWarning(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("⚠️ [WARNING] \(text)") : print("⚠️ [WARNING] \(text)", terminator: terminator!)
    #endif
}

/// Logs an error message with error category prefix in debug builds.
///
/// This function is used for logging error conditions and failures.
///
/// - Parameters:
///   - text: The error message to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logError("Failed to load configuration")
/// // Output: 🔴 [ERROR] Failed to load configuration
/// ```
@inlinable public func logError(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🔴 [ERROR] \(text)") : print("🔴 [ERROR] \(text)", terminator: terminator!)
    #endif
}

/// Logs an error message with detailed error information in debug builds.
///
/// This function logs an error message along with the localized description
/// and full error details for comprehensive debugging.
///
/// - Parameters:
///   - text: The error message to log
///   - error: The Error object containing detailed error information
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// do {
///     try performOperation()
/// } catch {
///     logError("Operation failed", error: error)
/// }
/// // Output: 🔴 [ERROR] Operation failed:
/// //         The operation couldn't be completed.
/// //         NetworkError.timeout
/// ```
@inlinable public func logError(_ text: String, error: Error, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🔴 [ERROR] \(text):\n\(error.localizedDescription)\n\(error)") : print("🔴 [ERROR] \(text):\n\(error.localizedDescription)", terminator: terminator!)
    #endif
}

/// Logs an error message with detailed error information in debug builds.
///
/// This is a convenience overload that provides a more natural parameter order
/// for error logging with Error objects.
///
/// - Parameters:
///   - text: The error message to log
///   - error: The Error object containing detailed error information
///   - terminator: Optional terminator string. If nil, uses default newline
@inlinable public func logError(_ text: String, _ error: Error, terminator: String? = nil) {
    logError(text, error: error, terminator: terminator)
}

/// Logs an error message with a string error description in debug builds.
///
/// This function logs an error message along with a string-based error description
/// for cases where you have error information as a string rather than an Error object.
///
/// - Parameters:
///   - text: The error message to log
///   - error: String description of the error
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logError("Validation failed", error: "Email address is invalid")
/// // Output: 🔴 [ERROR] Validation failed:
/// //         Email address is invalid
/// ```
@inlinable public func logError(_ text: String, error: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🔴 [ERROR] \(text):\n\(error)") : print("🔴 [ERROR] \(text):\n\(error)", terminator: terminator!)
    #endif
}

// MARK: - Specialized Logging

/// Logs a deletion message with deleted category prefix in debug builds.
///
/// This function is used for logging deletion operations and cleanup activities.
///
/// - Parameters:
///   - text: The deletion message to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logDeleted("Temporary files cleaned up")
/// // Output: 🗑️ [DELETED] Temporary files cleaned up
/// ```
@inlinable public func logDeleted(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("🗑️ [DELETED] \(text)") : print("🗑️ [DELETED] \(text)", terminator: terminator!)
    #endif
}

/// Logs a data-related message with data category prefix in debug builds.
///
/// This function is used for logging data operations, database activities,
/// and data processing information.
///
/// - Parameters:
///   - text: The data message to log
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// logData("User preferences synchronized")
/// // Output: 💽 [DATA] User preferences synchronized
/// ```
@inlinable public func logData(_ text: String, terminator: String? = nil) {
    #if DEBUG
    terminator == nil ? print("💽 [DATA] \(text)") : print("💽 [DATA] \(text)", terminator: terminator!)
    #endif
}

/// Logs URL information with appropriate category prefix in debug builds.
///
/// This function logs URL information, automatically detecting whether the URL
/// is a file URL or web URL and using appropriate icons and formatting.
///
/// - Parameters:
///   - text: Optional descriptive text for the URL
///   - url: The URL to log (can be nil)
///   - terminator: Optional terminator string. If nil, uses default newline
///
/// Example:
/// ```swift
/// let webURL = URL(string: "https://example.com")
/// logUrl("API endpoint", url: webURL)
/// // Output: 🌐 [URL] API endpoint:
/// //         https://example.com
///
/// let fileURL = URL(fileURLWithPath: "/tmp/file.txt")
/// logUrl("Temp file", url: fileURL)
/// // Output: 📁 [URL] Temp file:
/// //         /tmp/file.txt
///
/// logUrl("Invalid", url: nil)
/// // Output: 🔗 [URL] Nil or not valid URL
/// ```
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
