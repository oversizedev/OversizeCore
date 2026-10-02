//
// Copyright © 2024 Alexander Romanov
// Image+Data.swift, created on 27.06.2024
//

#if canImport(SwiftUI)
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import SwiftUI

public extension Image {
    init?(data: Data) {
        #if canImport(UIKit) || canImport(AppKit)
        guard let platformImage = PlatformImage(data: data) else {
            return nil
        }
        self.init(platformImage: platformImage)
        #else
        return nil
        #endif
    }
}
#endif
