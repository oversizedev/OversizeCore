//
// Copyright © 2022 Alexander Romanov
// Delay.swift
//

import Foundation

// MARK: - Legacy Delay Functions

/// Executes a closure after a specified time interval on the main queue.
/// 
/// This function provides a simple way to delay execution using DispatchQueue.
/// The closure is executed on the main queue after the specified time interval.
/// 
/// - Parameters:
///   - time: The time interval to wait before executing the closure
///   - execute: The closure to execute after the delay
/// 
/// Example:
/// ```swift
/// delay(time: 2.0) {
///     print("This will be printed after 2 seconds")
/// }
/// ```
/// 
/// - Note: For async/await contexts, prefer using the modern `delay(_:action:)` function.
public func delay(time: TimeInterval, execute: @Sendable @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: execute)
}

// MARK: - Modern Async Delay Functions

/// Suspends execution for a specified duration and then executes an async action.
/// 
/// This function provides a modern async/await-based delay mechanism using the new
/// Clock API introduced in iOS 16. The function suspends the current task for the
/// specified duration before executing the provided action.
/// 
/// - Parameters:
///   - time: The duration to wait before executing the action
///   - action: The async action to execute after the delay
/// 
/// Example:
/// ```swift
/// await delay(.seconds(3)) {
///     await updateUI()
/// }
/// ```
/// 
/// - Availability: iOS 16.0+, tvOS 16.0+, watchOS 9.0+, macOS 13.0+
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 13.0, *)
public func delay(_ time: ContinuousClock.Duration, action: @Sendable @escaping () async -> Void) async {
    do {
        try await Task.sleep(for: time)
        await action()
    } catch {
        logError("Delay function failed", error: error)
    }
}

/// Suspends execution for a specified duration and then executes a MainActor action.
/// 
/// This function is similar to `delay(_:action:)` but ensures the action is executed
/// on the main actor, making it safe for UI updates. The function suspends the current
/// task for the specified duration before executing the provided action on the main actor.
/// 
/// - Parameters:
///   - time: The duration to wait before executing the action
///   - action: The main actor action to execute after the delay
/// 
/// Example:
/// ```swift
/// await delayMain(.seconds(1)) {
///     // This runs on the main actor - safe for UI updates
///     self.label.text = "Updated after delay"
/// }
/// ```
/// 
/// - Availability: iOS 16.0+, tvOS 16.0+, watchOS 9.0+, macOS 13.0+
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 13.0, *)
public func delayMain(_ time: ContinuousClock.Duration, action: @MainActor @Sendable @escaping () async -> Void) async {
    do {
        try await Task.sleep(for: time)
        await action()
    } catch {
        logError("DelayMain function failed", error: error)
    }
}

/// Creates a detached task that delays for a specified duration and then executes an action.
/// 
/// This function creates a detached task that delays execution and then runs the provided
/// action. Unlike the other delay functions, this one doesn't suspend the current task
/// but creates a new detached task for the delay and execution.
/// 
/// - Parameters:
///   - time: The duration to wait before executing the action
///   - action: The action to execute after the delay
/// 
/// Example:
/// ```swift
/// delayDetached(.seconds(5)) {
///     performBackgroundCleanup()
/// }
/// // Code continues immediately without waiting
/// ```
/// 
/// - Availability: iOS 16.0+, tvOS 16.0+, watchOS 9.0+, macOS 13.0+
/// - Note: The action is executed in a detached task context, separate from the current task hierarchy.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 13.0, *)
public func delayDetached(_ time: ContinuousClock.Duration, action: @Sendable @escaping () -> Void) {
    Task.detached {
        do {
            try await Task.sleep(for: time)
            action()
        } catch {
            logError("DelayDetached function failed", error: error)
        }
    }
}
