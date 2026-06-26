//
// Copyright © 2026 Alexander Romanov
// AttributedString+Extension.swift, created on 02.06.2026
//

import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension AttributedString {
    func encode() -> Data? {
        let str = String(characters)
        let ns = NSMutableAttributedString(string: str)
        var strIdx = str.startIndex
        for run in runs {
            let runCharCount = characters.distance(from: run.range.lowerBound, to: run.range.upperBound)
            let strEndIdx = str.index(strIdx, offsetBy: runCharCount)
            let nsRange = NSRange(strIdx ..< strEndIdx, in: str)
            strIdx = strEndIdx

            #if canImport(UIKit)
            if let uiFont = run[AttributeScopes.UIKitAttributes.FontAttribute.self] {
                ns.addAttribute(.font, value: uiFont, range: nsRange)
            }
            if let color = run.foregroundColor {
                ns.addAttribute(.foregroundColor, value: UIColor(color), range: nsRange)
            }
            if let color = run.backgroundColor {
                ns.addAttribute(.backgroundColor, value: UIColor(color), range: nsRange)
            }
            #elseif canImport(AppKit)
            if let nsFont = run[AttributeScopes.AppKitAttributes.FontAttribute.self] {
                ns.addAttribute(.font, value: nsFont, range: nsRange)
            }
            if let color = run.foregroundColor {
                ns.addAttribute(.foregroundColor, value: NSColor(color), range: nsRange)
            }
            if let color = run.backgroundColor {
                ns.addAttribute(.backgroundColor, value: NSColor(color), range: nsRange)
            }
            #endif
            if run.underlineStyle != nil {
                ns.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange)
            }
            if run.strikethroughStyle != nil {
                ns.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange)
            }
            if let url = run.link {
                ns.addAttribute(.link, value: url, range: nsRange)
            }
        }
        return try? NSKeyedArchiver.archivedData(withRootObject: ns, requiringSecureCoding: true)
    }

    static func decode(from data: Data) -> AttributedString {
        guard let ns = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSAttributedString.self, from: data) else {
            return AttributedString()
        }
        let str = ns.string
        var result = AttributedString(str)
        ns.enumerateAttributes(in: NSRange(location: 0, length: ns.length), options: []) { attrs, nsRange, _ in
            guard let strRange = Range(nsRange, in: str) else { return }
            let startOffset = str.distance(from: str.startIndex, to: strRange.lowerBound)
            let endOffset = str.distance(from: str.startIndex, to: strRange.upperBound)
            guard startOffset <= result.characters.count, endOffset <= result.characters.count else { return }
            let lower = result.characters.index(result.characters.startIndex, offsetBy: startOffset)
            let upper = result.characters.index(result.characters.startIndex, offsetBy: endOffset)
            let attrRange = lower ..< upper

            #if canImport(UIKit)
            if let uiFont = attrs[.font] as? UIFont {
                result[attrRange].font = Font(uiFont)
                result[attrRange][AttributeScopes.UIKitAttributes.FontAttribute.self] = uiFont
            }
            if let uiColor = attrs[.foregroundColor] as? UIColor {
                result[attrRange].foregroundColor = Color(uiColor)
            }
            if let uiColor = attrs[.backgroundColor] as? UIColor {
                result[attrRange].backgroundColor = Color(uiColor)
            }
            #elseif canImport(AppKit)
            if let nsFont = attrs[.font] as? NSFont {
                result[attrRange].font = Font(nsFont)
                result[attrRange][AttributeScopes.AppKitAttributes.FontAttribute.self] = nsFont
            }
            if let nsColor = attrs[.foregroundColor] as? NSColor {
                result[attrRange].foregroundColor = Color(nsColor)
            }
            if let nsColor = attrs[.backgroundColor] as? NSColor {
                result[attrRange].backgroundColor = Color(nsColor)
            }
            #endif
            if let underline = attrs[.underlineStyle] as? Int, underline != 0 {
                result[attrRange].underlineStyle = Text.LineStyle(pattern: .solid)
            }
            if let strikethrough = attrs[.strikethroughStyle] as? Int, strikethrough != 0 {
                result[attrRange].strikethroughStyle = Text.LineStyle(pattern: .solid)
            }
            if let url = attrs[.link] as? URL {
                result[attrRange].link = url
            } else if let urlString = attrs[.link] as? String, let url = URL(string: urlString) {
                result[attrRange].link = url
            }
        }
        return result
    }

    var plainText: String? {
        let text = String(characters).trimmingCharacters(in: .whitespacesAndNewlines)
        return text.isEmpty ? nil : text
    }
}
