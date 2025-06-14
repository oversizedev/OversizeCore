//
// Copyright © 2022 Alexander Romanov
// Delay.swift
//

import Foundation

public func delay(time: TimeInterval, execute: @Sendable @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: execute)
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 13.0, *)
public func delay(_ time: ContinuousClock.Duration, action: @Sendable @escaping () async -> Void) async {
    do {
        try await Task.sleep(for: time)
        await action()
    } catch {}
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 13.0, *)
public func delayMain(_ time: ContinuousClock.Duration, action: @MainActor @Sendable @escaping () async -> Void) async {
    do {
        try await Task.sleep(for: time)
        await action()
    } catch {}
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 13.0, *)
public func delayDetached(_ time: ContinuousClock.Duration, action: @Sendable @escaping () -> Void) {
    Task.detached {
        try await Task.sleep(for: time)
        action()
    }
}
