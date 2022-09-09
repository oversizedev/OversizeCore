//
// Copyright © 2022 Alexander Romanov
// View+Extension.swift
//

#if os(iOS)
    import SwiftUI
    import UIKit

    public extension UIView {
        var renderedImage: UIImage {
            // rect of capure
            let rect = bounds
            // create the context of bitmap
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
            let context: CGContext = UIGraphicsGetCurrentContext()!
            layer.render(in: context)
            // get a image from current context bitmap
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
