//
// Copyright © 2026 Alexander Romanov
// ImageDataTests.swift
//

#if canImport(SwiftUI)
import Foundation
@testable import OversizeCore
import SwiftUI
import Testing
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

struct ImageDataTests {
    @Test func initFromData_withInvalidData_returnsNil() {
        #expect(Image(data: Data("not an image".utf8)) == nil)
    }

    @Test func initFromData_withEmptyData_returnsNil() {
        #expect(Image(data: Data()) == nil)
    }

    @Test func initFromData_withValidPNG_returnsImage() throws {
        let data = try #require(TestImage.pngData())
        #expect(Image(data: data) != nil)
    }
}

#if canImport(AppKit) && !canImport(UIKit)
struct NSImageExtensionTests {
    @Test func pngData_returnsNonEmptyData() throws {
        let data = try #require(TestImage.make()?.pngData())
        #expect(!data.isEmpty)
    }

    @Test func jpegData_returnsNonEmptyData() throws {
        let data = try #require(TestImage.make()?.jpegData())
        #expect(!data.isEmpty)
    }

    @Test func jpegDataWithCompressionQuality_honoursQuality() throws {
        let image = try #require(TestImage.make())
        let low = try #require(image.jpegData(compressionQuality: 0.1))
        let high = try #require(image.jpegData(compressionQuality: 1.0))
        #expect(low.count < high.count)
    }

    @Test func cgImage_isNotNil() throws {
        #expect(try #require(TestImage.make()).cgImage != nil)
    }

    @Test func averageColor_returnsColorForSolidImage() throws {
        #expect(try #require(TestImage.make()).averageColor != nil)
    }
}
#endif

#if canImport(UIKit) && !os(watchOS)
struct UIImageExtensionTests {
    @Test func averageColor_returnsColorForSolidImage() throws {
        #expect(try #require(TestImage.make()).averageColor != nil)
    }
}
#endif
#endif
