//
// Copyright © 2022 Alexander Romanov
// URL+Extension.swift
//

import Foundation

public extension URL {
    var hostWithoutSubdomain: String? {
        guard let hostName = host else { return nil }
        let subStrings = hostName.components(separatedBy: ".")
        let count = subStrings.count
        let isIPv4Address = count == 4 && subStrings.allSatisfy { !$0.isEmpty && $0.allSatisfy(\.isNumber) }
        guard count > 2, !isIPv4Address else { return hostName }
        return subStrings[count - 2] + "." + subStrings[count - 1]
    }

    var urlTitle: String {
        let maximumLength = 14
        guard absoluteString.count > maximumLength else { return absoluteString }
        return String(absoluteString.prefix(maximumLength)) + "..."
    }
}

public extension URL {
    func fileExists() -> Bool {
        let path = path.replacingOccurrences(of: "file://", with: "")
        return FileManager.default.fileExists(atPath: path)
    }
}
