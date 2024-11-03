//
// Copyright © 2024 Alexander Romanov
// Sequence+Extension.swift, created on 24.10.2024
//

import Foundation

public extension Sequence where Element: Hashable {
    func removingDuplicates(by keyPath: KeyPath<Element, String>) -> [Element] {
        var seen = Set<String>()
        return filter { seen.insert($0[keyPath: keyPath]).inserted }
    }
}
