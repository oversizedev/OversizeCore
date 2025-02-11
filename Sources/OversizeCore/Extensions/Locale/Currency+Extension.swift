//
// Copyright © 2023 Alexander Romanov
// CurrencyExtension.swift, created on 15.07.2023
//

import Foundation

@available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
public extension Locale.Currency {
    var dispalyName: String? {
        Locale.current.localizedString(forCurrencyCode: identifier)
    }

    var dispalyIdentifier: String? {
        identifier.uppercased()
    }

    var dispalyLocalizedSymbol: String? {
        Locale.current.localizedCurrencySymbol(forCurrencyCode: identifier)
    }

    var dispalySymbol: String? {
        let allLocalCurrencies = Locale.availableIdentifiers.compactMap { Locale(identifier: $0) }
        return allLocalCurrencies.first { $0.currency == self }?.currencySymbol
    }

    var locale: Locale? {
        let allLocalCurrencies = Locale.availableIdentifiers.compactMap { Locale(identifier: $0) }
        return allLocalCurrencies.first { $0.currency == self }
    }

    static var countryCurrencies: [Locale.Currency] {
        Locale.availableIdentifiers
            .compactMap { Locale(identifier: $0).currency }
            .removeDuplicates()
            .sorted { $0.dispalyName ?? "" < $1.dispalyName ?? "" }
    }
}
