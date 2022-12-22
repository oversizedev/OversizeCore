//
// Copyright © 2022 Alexander Romanov
// URL+Extension.swift
//

import Foundation

public extension URL {
    var hostWithoutSubdomain: String? {
        guard let hostName = host else { return nil }
        let subStrings = hostName.components(separatedBy: ".")
        var domainName: String = .init()
        let count = subStrings.count
        if count > 2 {
            domainName = subStrings[count - 2] + "." + subStrings[count - 1]
        } else if count == 2 {
            domainName = hostName
        }
        return domainName
    }

    var urlTitle: String {
        if absoluteString.count < 14 {
            return absoluteString
        }
        var urlString = absoluteString
        let range = urlString.index(urlString.startIndex, offsetBy: 14) ..< urlString.endIndex
        urlString.removeSubrange(range)
        return urlString + "..."
    }
}
