//
// Copyright © 2023 Alexander Romanov
// String+Extension.swift
//

import Foundation
import SwiftUI

// swiftlint:disable all
public extension String {
    var trim: String {
        let charSet = CharacterSet.whitespacesAndNewlines
        return String(format: "%@", trimmingCharacters(in: charSet))
    }

    var isEmail: Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let predicate: NSPredicate = .init(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }

    var isURL: Bool {
        let regEx = "http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?"
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }

    var isAlphabet: Bool {
        let regEx = "[A-Za-z_]*"
        let predicate: NSPredicate = .init(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }

    var urlEncode: String {
        let originalString = self
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        return escapedString!
    }

    var url: URL? {
        var URLString = self
        if URLString.hasPrefix("//") {
            URLString = "http:" + URLString
            if let URL = URL(string: URLString) {
                return URL
            }
        } else if let URL = URL(string: URLString) {
            return URL
        }
        return nil
    }

    var localizedDecimalSeparator: String {
        let nf: NumberFormatter = .init()
        if let separator = nf.decimalSeparator {
            var safeValue = self
            if separator == "," {
                safeValue = replacingOccurrences(of: ".", with: ",", options: [], range: nil)
            } else {
                safeValue = replacingOccurrences(of: ",", with: ".", options: [], range: nil)
            }
            return safeValue
        }
        return self
    }

    var numbers: String {
        let set = CharacterSet.decimalDigits.inverted
        let numbers = components(separatedBy: set)
        return numbers.joined(separator: "")
    }

    var letters: String {
        let set = CharacterSet.letters.inverted
        let letters = components(separatedBy: set)
        return letters.joined(separator: "")
    }

    var lettersWithSpace: String {
        let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ").inverted
        let letters = components(separatedBy: set)
        return letters.joined(separator: "")
    }

    var data: Data {
        self.data(using: String.Encoding.utf8)!
    }

    var range: NSRange {
        NSRange(location: 0, length: utf16.count)
    }
}

public extension String {
    func enumCase<T: RawRepresentable>() -> T? {
        if let raw = self as? T.RawValue {
            return T(rawValue: raw)
        }
        return nil
    }

    func matches(for regex: String) -> [[String]] {
        do {
            let regEx = try NSRegularExpression(pattern: regex, options: [])
            let matches = regEx.matches(in: self, range: NSRange(location: 0, length: count))
            return matches.map {
                var array: [String] = []
                for rangeIndex in 0 ... max(0, $0.numberOfRanges - 1) {
                    array.append(String(self[Range($0.range(at: rangeIndex), in: self)!]))
                }
                return array
            }
        } catch _ {}
        return []
    }
}

extension String {
    public func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }
}

extension String {
    public func lowercasingFirstLetter() -> String {
        prefix(1).lowercased() + dropFirst()
    }

    mutating func lowercasedFirstLetter() {
        self = lowercasingFirstLetter()
    }
}

#if os(iOS) || os(tvOS) || os(watchOS)

    extension String {
        func getAttributedStringFromHtml(font: UIFont, color: UIColor) -> NSAttributedString? {
            guard let data = data(using: String.Encoding.utf16, allowLossyConversion: false) else {
                return nil
            }

            guard let attributedString = try? NSMutableAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue,
                ],
                documentAttributes: nil
            ) else {
                return nil
            }

            attributedString.addAttributes(
                [
                    .font: font,
                    .foregroundColor: color,
                ],
                range: NSRange(location: 0, length: attributedString.length)
            )

            return attributedString
        }
    }

    public extension String {
        func size(font: UIFont) -> CGSize {
            let originalString = self as NSString
            return originalString.size(withAttributes: [NSAttributedString.Key.font: font])
        }

        func width(font: UIFont) -> CGFloat {
            size(font: font).width
        }

//        func height(width: CGFloat, withFont font: UIFont) -> CGFloat {
//            let constraintRect: CGSize = .init(width: width, height: CGFloat.greatestFiniteMagnitude)
//            let boundingBox = boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//            return ceil(boundingBox.height) + 1
//        }
    }

    public extension NSAttributedString {
        func height(width: CGFloat) -> CGFloat {
            let constraintRect: CGSize = .init(width: width, height: CGFloat.greatestFiniteMagnitude)
            let boundingBox = boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
            return ceil(boundingBox.height) + 1
        }
    }

#endif
