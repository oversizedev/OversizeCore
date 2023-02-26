//
// Copyright © 2022 Alexander Romanov
// View+Extension.swift
//

#if os(iOS)
    import SwiftUI
    import UIKit

    public extension UIView {
        var renderedImage: UIImage {
            let rect = bounds
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
            let context: CGContext = UIGraphicsGetCurrentContext()!
            layer.render(in: context)
            let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return capturedImage
        }
    }

    public extension View {
        func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage {
            let window: UIWindow = .init(frame: CGRect(origin: origin, size: size))
            let hosting: UIHostingController = .init(rootView: self)
            hosting.view.frame = window.frame
            window.addSubview(hosting.view)
            window.makeKeyAndVisible()
            return hosting.view.renderedImage
        }
    }
#endif
