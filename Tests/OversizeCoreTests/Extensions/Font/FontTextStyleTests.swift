//
// Copyright © 2026 Alexander Romanov
// FontTextStyleTests.swift
//

#if canImport(SwiftUI)
@testable import OversizeCore
import SwiftUI
import Testing

struct FontTextStyleTests {
    private static let styles: [(Font.TextStyle, String)] = [
        (.caption2, "Caption 2"),
        (.caption, "Caption"),
        (.footnote, "Footnote"),
        (.subheadline, "Subheadline"),
        (.callout, "Callout"),
        (.body, "Body"),
        (.headline, "Headline"),
        (.title3, "Title 3"),
        (.title2, "Title 2"),
        (.title, "Title"),
        (.largeTitle, "Large Title"),
    ]

    @Test(arguments: styles)
    func displayName_matchesStyle(_ style: Font.TextStyle, _ expected: String) {
        #expect(style.displayName == expected)
    }

    @Test func displayName_isUniqueForEveryCase() {
        let names = Font.TextStyle.allCases.map(\.displayName)
        #expect(Set(names).count == names.count)
    }
}
#endif
