//
// Copyright © 2023 Alexander Romanov
// URLCache+Extension.swift, created on 07.07.2023
//

import Foundation

public extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 1_000_000_000)
}
