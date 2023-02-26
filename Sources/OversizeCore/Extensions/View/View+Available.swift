//
// Copyright © 2022 Alexander Romanov
// View+Available.swift
//

import SwiftUI

public extension View {
    @_disfavoredOverload
    func scrollContentBackground(_ visibility: Visibility) -> some View {
        Group {
            if #available(iOS 16, *) {
                self.scrollContentBackground(visibility)
            } else {
                self
            }
        }
    }

    @_disfavoredOverload
    func presentationDragIndicator(_ visibility: Visibility) -> some View {
        Group {
            if #available(iOS 16, *) {
                self.presentationDragIndicator(visibility)
            } else {
                self
            }
        }
    }
}
