//
// Copyright © 2023 Alexander Romanov
// URLCache+Extension.swift, created on 07.07.2023
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
