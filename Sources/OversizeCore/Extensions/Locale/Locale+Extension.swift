//
// Copyright © 2023 Alexander Romanov
// Locale+Extension.swift, created on 15.07.2023
//

import Foundation

@available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
extension Locale {
    func localizedCurrencySymbol(forCurrencyCode currencyCode: String) -> String? {
        guard
            let languageCode = language.languageCode?.identifier,
            let regionCode = language.region?.identifier
        else { return nil }
        let components: [String: String] = [
            NSLocale.Key.languageCode.rawValue: languageCode,
            NSLocale.Key.countryCode.rawValue: regionCode,
            NSLocale.Key.currencyCode.rawValue: currencyCode,
        ]
        let identifier = Locale.identifier(fromComponents: components)
        return Locale(identifier: identifier).currencySymbol
    }
}
