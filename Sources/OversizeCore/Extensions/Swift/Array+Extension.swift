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
        } else if let index = index {
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
