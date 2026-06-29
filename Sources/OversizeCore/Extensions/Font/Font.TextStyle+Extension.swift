//
// Copyright © 2026 Alexander Romanov
// Font.TextStyle+Extension.swift
//

#if canImport(SwiftUI)
import SwiftUI

public extension Font.TextStyle {
    var displayName: String {
        switch self {
        case .caption2: "Caption 2"
        case .caption: "Caption"
        case .footnote: "Footnote"
        case .subheadline: "Subheadline"
        case .callout: "Callout"
        case .body: "Body"
        case .headline: "Headline"
        case .title3: "Title 3"
        case .title2: "Title 2"
        case .title: "Title"
        case .largeTitle: "Large Title"
        @unknown default: "Body"
        }
    }
}
#endif
