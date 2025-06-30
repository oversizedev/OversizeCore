//
// Copyright © 2022 Alexander Romanov
// Array+Extension.swift
//

import CoreGraphics
import Foundation

// MARK: - Sequence String Conversion

public extension Sequence where Iterator.Element == Int {
    /// Converts a sequence of integers to an array of strings.
    /// 
    /// This computed property transforms each integer in the sequence to its
    /// string representation, useful for UI display or data serialization.
    /// 
    /// - Returns: An array of strings representing the integer values
    /// 
    /// Example:
    /// ```swift
    /// let numbers = [1, 2, 3, 4, 5]
    /// let strings = numbers.strings // ["1", "2", "3", "4", "5"]
    /// ```
    var strings: [String] {
        var strings: [String] = []
        for item in self {
            strings.append(item.toString)
        }
        return strings
    }
}

// MARK: - Numeric Sequence Operations

public extension Sequence where Iterator.Element == CGFloat {
    /// Calculates the sum of all CGFloat values in the sequence.
    /// 
    /// This computed property adds all values in the sequence and returns
    /// the total sum, useful for calculating totals in UI layout or graphics operations.
    /// 
    /// - Returns: The sum of all CGFloat values in the sequence
    /// 
    /// Example:
    /// ```swift
    /// let values: [CGFloat] = [10.5, 20.0, 15.75]
    /// let total = values.sum // 46.25
    /// ```
    var sum: Iterator.Element {
        reduce(0) { res, val -> Iterator.Element in
            res + val
        }
    }
}

public extension Sequence where Iterator.Element == Int {
    /// Calculates the sum of all integer values in the sequence.
    /// 
    /// This computed property adds all values in the sequence and returns
    /// the total sum, useful for calculating counts or totals.
    /// 
    /// - Returns: The sum of all integer values in the sequence
    /// 
    /// Example:
    /// ```swift
    /// let numbers = [1, 2, 3, 4, 5]
    /// let total = numbers.sum // 15
    /// ```
    var sum: Iterator.Element {
        reduce(0) { res, val -> Iterator.Element in
            res + val
        }
    }
}

public extension Sequence where Iterator.Element == Double {
    /// Calculates the sum of all double values in the sequence.
    /// 
    /// This computed property adds all values in the sequence and returns
    /// the total sum, useful for precise numerical calculations.
    /// 
    /// - Returns: The sum of all double values in the sequence
    /// 
    /// Example:
    /// ```swift
    /// let values = [1.5, 2.7, 3.8]
    /// let total = values.sum // 8.0
    /// ```
    var sum: Iterator.Element {
        reduce(0) { res, val -> Iterator.Element in
            res + val
        }
    }
}

public extension Sequence where Iterator.Element == Float {
    /// Calculates the sum of all float values in the sequence.
    /// 
    /// This computed property adds all values in the sequence and returns
    /// the total sum, useful for floating-point calculations.
    /// 
    /// - Returns: The sum of all float values in the sequence
    /// 
    /// Example:
    /// ```swift
    /// let values: [Float] = [1.5, 2.7, 3.8]
    /// let total = values.sum // 8.0
    /// ```
    var sum: Iterator.Element {
        reduce(0) { res, val -> Iterator.Element in
            res + val
        }
    }
}

// MARK: - Subtraction Operations

public extension Sequence where Iterator.Element == CGFloat {
    /// Performs sequential subtraction starting from a given value.
    /// 
    /// This function takes a starting value and subtracts each element in the
    /// sequence from it sequentially, useful for cumulative calculations.
    /// 
    /// - Parameter start: The initial value to subtract from
    /// - Returns: The result after subtracting all values in the sequence
    /// 
    /// Example:
    /// ```swift
    /// let values: [CGFloat] = [1.0, 2.0, 3.0]
    /// let result = values.subtract(10.0) // 10.0 - 1.0 - 2.0 - 3.0 = 4.0
    /// ```
    func subtract(_ start: Iterator.Element) -> Iterator.Element {
        reduce(start) { res, val -> Iterator.Element in
            res - val
        }
    }
}

public extension Sequence where Iterator.Element == Int {
    /// Performs sequential subtraction starting from a given value.
    /// 
    /// This function takes a starting value and subtracts each element in the
    /// sequence from it sequentially, useful for cumulative calculations.
    /// 
    /// - Parameter start: The initial value to subtract from
    /// - Returns: The result after subtracting all values in the sequence
    /// 
    /// Example:
    /// ```swift
    /// let numbers = [1, 2, 3]
    /// let result = numbers.subtract(10) // 10 - 1 - 2 - 3 = 4
    /// ```
    func subtract(_ start: Iterator.Element) -> Iterator.Element {
        reduce(start) { res, val -> Iterator.Element in
            res - val
        }
    }
}

public extension Sequence where Iterator.Element == Double {
    /// Performs sequential subtraction starting from a given value.
    /// 
    /// This function takes a starting value and subtracts each element in the
    /// sequence from it sequentially, useful for precise numerical calculations.
    /// 
    /// - Parameter start: The initial value to subtract from
    /// - Returns: The result after subtracting all values in the sequence
    /// 
    /// Example:
    /// ```swift
    /// let values = [1.5, 2.5, 3.0]
    /// let result = values.subtract(10.0) // 10.0 - 1.5 - 2.5 - 3.0 = 3.0
    /// ```
    func subtract(_ start: Iterator.Element) -> Iterator.Element {
        reduce(start) { res, val -> Iterator.Element in
            res - val
        }
    }
}

public extension Sequence where Iterator.Element == Float {
    /// Performs sequential subtraction starting from a given value.
    /// 
    /// This function takes a starting value and subtracts each element in the
    /// sequence from it sequentially, useful for floating-point calculations.
    /// 
    /// - Parameter start: The initial value to subtract from
    /// - Returns: The result after subtracting all values in the sequence
    /// 
    /// Example:
    /// ```swift
    /// let values: [Float] = [1.5, 2.5, 3.0]
    /// let result = values.subtract(10.0) // 10.0 - 1.5 - 2.5 - 3.0 = 3.0
    /// ```
    func subtract(_ start: Iterator.Element) -> Iterator.Element {
        reduce(start) { res, val -> Iterator.Element in
            res - val
        }
    }
}

// MARK: - Array Manipulation

public extension Array where Element: Equatable {
    /// Moves an element from one position to another within the array.
    /// 
    /// This mutating function repositions an element within the array by removing
    /// it from its current position and inserting it at the new position.
    /// 
    /// - Parameters:
    ///   - fromPosition: The current index of the element to move
    ///   - toPosition: The target index where the element should be moved
    /// 
    /// Example:
    /// ```swift
    /// var items = ["A", "B", "C", "D"]
    /// items.move(fromPosition: 0, toPosition: 2)
    /// // items is now ["B", "C", "A", "D"]
    /// ```
    /// 
    /// - Warning: Ensure both indices are valid to avoid runtime errors.
    mutating func move(fromPosition: Int, toPosition: Int) {
        let object = self[fromPosition]
        remove(at: fromPosition)
        insert(object, at: toPosition)
    }

    /// Removes the first occurrence of the specified element from the array.
    /// 
    /// This mutating function searches for the first element equal to the provided
    /// object and removes it from the array if found.
    /// 
    /// - Parameter object: The element to remove from the array
    /// - Returns: The index where the element was found and removed, or `nil` if not found
    /// 
    /// Example:
    /// ```swift
    /// var items = ["A", "B", "C", "B"]
    /// let removedIndex = items.remove("B") // Returns 1
    /// // items is now ["A", "C", "B"]
    /// ```
    @discardableResult mutating func remove(_ object: Iterator.Element) -> Int? {
        if let index = firstIndex(of: object) {
            remove(at: index)
            return index
        }
        return nil
    }

    /// Replaces an existing element or inserts it at a specified position.
    /// 
    /// This mutating function either replaces an existing element (if found) or
    /// inserts it at the specified index. If no index is provided and the element
    /// doesn't exist, it's appended to the end.
    /// 
    /// - Parameters:
    ///   - object: The element to replace or insert
    ///   - index: The index to insert at if the element is not found (optional)
    /// 
    /// Example:
    /// ```swift
    /// var items = ["A", "B", "C"]
    /// items.replace(object: "B", ifMissingInsertAt: nil) // Replaces existing "B"
    /// items.replace(object: "D", ifMissingInsertAt: 1)   // Inserts "D" at index 1
    /// ```
    mutating func replace(object: Element, ifMissingInsertAt index: Int?) {
        if let currentIndex = remove(object) {
            insert(object, at: currentIndex)
        } else if let index {
            insert(object, at: index)
        } else {
            append(object)
        }
    }

    /// Returns a new array with duplicate elements removed.
    /// 
    /// This function creates a new array containing only unique elements,
    /// preserving the order of first occurrence for each element.
    /// 
    /// - Returns: A new array with duplicates removed
    /// 
    /// Example:
    /// ```swift
    /// let items = ["A", "B", "A", "C", "B"]
    /// let unique = items.removeDuplicates() // ["A", "B", "C"]
    /// ```
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

// MARK: - JSON Serialization

extension Array: @retroactive RawRepresentable where Element: Codable {
    /// Creates an array from a JSON string representation.
    /// 
    /// This initializer attempts to decode a JSON string into an array of
    /// codable elements, useful for data persistence and serialization.
    /// 
    /// - Parameter rawValue: JSON string representation of the array
    /// 
    /// Example:
    /// ```swift
    /// let jsonString = "[\"A\", \"B\", \"C\"]"
    /// let array = [String](rawValue: jsonString) // ["A", "B", "C"]
    /// ```
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    /// Returns the JSON string representation of the array.
    /// 
    /// This computed property encodes the array to a JSON string, useful for
    /// data storage and transmission.
    /// 
    /// - Returns: JSON string representation, or "[]" if encoding fails
    /// 
    /// Example:
    /// ```swift
    /// let array = ["A", "B", "C"]
    /// let json = array.rawValue // "[\"A\",\"B\",\"C\"]"
    /// ```
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result: String = .init(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

// MARK: - Safe Element Access

public extension Array {
    /// Safely accesses an element at the specified index.
    /// 
    /// This function provides bounds-safe access to array elements, returning
    /// the element if the index is valid or nil if it's out of bounds.
    /// 
    /// - Parameter index: The index of the element to access
    /// - Returns: The element at the index if valid, `nil` otherwise
    /// 
    /// Example:
    /// ```swift
    /// let items = ["A", "B", "C"]
    /// let first = items.element(0)  // "A"
    /// let invalid = items.element(5) // nil
    /// ```
    func element(_ index: Int) -> Element? {
        if index >= 0, index < count {
            self[index]
        } else {
            nil
        }
    }
}

// MARK: - Collection Navigation

public extension BidirectionalCollection where Iterator.Element: Equatable {
    /// Returns the element that comes after the specified item in the collection.
    /// 
    /// This function finds the given item in the collection and returns the next element.
    /// Optionally supports looping back to the first element after the last one.
    /// 
    /// - Parameters:
    ///   - item: The item to find in the collection
    ///   - loop: Whether to loop back to the first element after the last (default: false)
    /// - Returns: The next element after the specified item, or `nil` if not found or at end
    /// 
    /// Example:
    /// ```swift
    /// let items = ["A", "B", "C", "D"]
    /// let next1 = items.after("B")        // "C"
    /// let next2 = items.after("D")        // nil
    /// let next3 = items.after("D", loop: true) // "A"
    /// ```
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

    /// Returns the element that comes before the specified item in the collection.
    /// 
    /// This function finds the given item in the collection and returns the previous element.
    /// Optionally supports looping back to the last element before the first one.
    /// 
    /// - Parameters:
    ///   - item: The item to find in the collection
    ///   - loop: Whether to loop back to the last element before the first (default: false)
    /// - Returns: The previous element before the specified item, or `nil` if not found or at start
    /// 
    /// Example:
    /// ```swift
    /// let items = ["A", "B", "C", "D"]
    /// let prev1 = items.before("C")        // "B"
    /// let prev2 = items.before("A")        // nil
    /// let prev3 = items.before("A", loop: true) // "D"
    /// ```
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

// MARK: - Optional Compacting

public extension Array {
    /// Returns a new array with non-nil elements from an array of optionals.
    /// 
    /// This function provides a convenient way to compact an array of optional values,
    /// removing all nil values and unwrapping the remaining elements.
    /// 
    /// - Returns: Array of unwrapped non-nil elements
    /// 
    /// Example:
    /// ```swift
    /// let optionals: [String?] = ["A", nil, "B", nil, "C"]
    /// let compacted: [String] = optionals.compacted() // ["A", "B", "C"]
    /// ```
    /// 
    /// - Note: This is a generic constraint that only applies when Element is Optional.
    func compacted<T>() -> [T] where Element == T? {
        compactMap { $0 }
    }
}
