//
// Copyright © 2022 Alexander Romanov
// View+Alignment.swift
//

import SwiftUI

public extension View {
    // MARK: Vertical Center

    func vCenter() -> some View {
        frame(maxHeight: .infinity, alignment: .center)
    }

    // MARK: Vertical Top

    func vTop() -> some View {
        frame(maxHeight: .infinity, alignment: .top)
    }

    // MARK: Vertical Bottom

    func vBottom() -> some View {
        frame(maxHeight: .infinity, alignment: .bottom)
    }

    // MARK: Horizontal Center

    func hCenter() -> some View {
        frame(maxWidth: .infinity, alignment: .center)
    }

    // MARK: Horizontal Leading

    func hLeading() -> some View {
        frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: Horizontal Trailing

    func hTrailing() -> some View {
        frame(maxWidth: .infinity, alignment: .trailing)
    }
}
