//
// Copyright © 2026 Alexander Romanov
// DelayTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

struct DelayTests {
    @Test func delay_awaitsRequestedDuration() async {
        let clock = ContinuousClock()
        let elapsed = await clock.measure {
            await delay(.milliseconds(100)) {}
        }
        #expect(elapsed >= .milliseconds(90))
    }

    @Test func delay_runsAction() async {
        let box = Box()
        await delay(.milliseconds(10)) { await box.mark() }
        #expect(await box.isMarked)
    }

    @Test func delayMain_runsActionOnMainActor() async {
        let box = Box()
        await delayMain(.milliseconds(10)) {
            MainActor.assertIsolated()
            await box.mark()
        }
        #expect(await box.isMarked)
    }

    @Test func delayDetached_runsActionEventually() async throws {
        let box = Box()
        delayDetached(.milliseconds(10)) {
            Task { await box.mark() }
        }
        #expect(try await box.waitUntilMarked())
    }

    @Test func legacyDelay_runsActionOnMainQueue() async throws {
        let box = Box()
        delay(time: 0.01) {
            Task { await box.mark() }
        }
        #expect(try await box.waitUntilMarked())
    }

    private actor Box {
        private(set) var isMarked = false

        func mark() {
            isMarked = true
        }

        func waitUntilMarked(timeout: Duration = .seconds(5)) async throws -> Bool {
            let deadline = ContinuousClock.now + timeout
            while !isMarked, ContinuousClock.now < deadline {
                try await Task.sleep(for: .milliseconds(10))
            }
            return isMarked
        }
    }
}
