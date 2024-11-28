//
// Copyright © 2022 Alexander Romanov
// Array+Extension.swift
//

import CoreGraphics
import Foundation

public extension Sequence where Iterator.Element == Int {
    var strings: [String] {
        var strings: [String] = []
        for item in self {
            strings.append(item.toString)
        }
        return strings
    }
}

// MARK: - Sum

public extension Sequence where Iterator.Element == CGFloat {
    var sum: Iterator.Element {
        reduce(0) { res, val -> Iterator.Element in
            res + val
        }
    }
}

public extension Sequence where Iterator.Element == Int {
    var sum: Iterator.Element {
        reduce(0) { res, val -> Iterator.Element in
            res + val
        }
    }
}

public extension Sequence where Iterator.Element == Double {
    var sum: Iterator.Element {
        reduce(0) { res, val -> Iterator.Element in
            res + val
        }
    }
}

public extension Sequence where Iterator.Element == Float {
    var sum: Iterator.Element {
        reduce(0) { res, val -> Iterator.Element in
            res + val
        }
    }
}

// MARK: - Subtract

public extension Sequence where Iterator.Element == CGFloat {
    func subtract(_ start: Iterator.Element) -> Iterator.Element {
        reduce(start) { res, val -> Iterator.Element in
            res - val
        }
    }
}

public extension Sequence where Iterator.Element == Int {
    func subtract(_ start: Iterator.Element) -> Iterator.Element {
        reduce(start) { res, val -> Iterator.Element in
            res - val
        }
    }
}

public extension Sequence where Iterator.Element == Double {
    func subtract(_ start: Iterator.Element) -> Iterator.Element {
        reduce(start) { res, val -> Iterator.Element in
            res - val
        }
    }
}

public extension Sequence where Iterator.Element == Float {
    func subtract(_ start: Iterator.Element) -> Iterator.Element {
        reduce(start) { res, val -> Iterator.Element in
            res - val
        }
    }
}

// MARK: - Move

public extension Array where Element: Equatable {
    mutating func move(fromPosition: Int, toPosition: Int) {
        let object = self[fromPosition]
        remove(at: fromPosition)
        insert(object, at: toPosition)
    }

    // Remove first collection element that is equal to the given `object`:
    @discardableResult mutating func remove(_ object: Iterator.Element) -> Int? {
        if let index = firstIndex(of: object) {
            remove(at: index)
            return index
        }
        return nil
    }

    mutating func replace(object: Element, ifMissingInsertAt index: Int?) {
        if let currentIndex = remove(object) {
            insert(object, at: currentIndex)
        } else if let index {
            insert(object, at: index)
        } else {
            append(object)
        }
    }

    func removeDuplicates() -> [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}

extension Array: @retroactive RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result: String = .init(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

public extension Array {
    func element(_ index: Int) -> Element? {
        if index >= 0, index < count {
            self[index]
        } else {
            nil
        }
    }
}

public extension BidirectionalCollection where Iterator.Element: Equatable {
    func after(_ item: Iterator.Element, loop: Bool = false) -> Element? {
        if let itemIndex = firstIndex(of: item) {
            let lastItem: Bool = (index(after: itemIndex) == endIndex)
            if loop, lastItem {
                return first
            } else if lastItem {
                return nil
            } else {
                return self[index(after: itemIndex)]
            }
        }
        return nil
    }

    func before(_ item: Iterator.Element, loop: Bool = false) -> Element? {
        if let itemIndex = firstIndex(of: item) {
            let firstItem: Bool = (itemIndex == startIndex)
            if loop, firstItem {
                return last
            } else if firstItem {
                return nil
            } else {
                return self[index(before: itemIndex)]
            }
        }
        return nil
    }
}

public extension Array {
    func compacted<T>() -> [T] where Element == T? {
        compactMap { $0 }
    }
}
