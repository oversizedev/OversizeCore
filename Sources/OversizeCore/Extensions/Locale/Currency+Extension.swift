//
// Copyright © 2023 Alexander Romanov
// Currency+Extension.swift, created on 15.07.2023
//

import Foundation

@available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
public extension Locale.Currency {
    var displayName: String? {
        Locale.current.localizedString(forCurrencyCode: identifier)
    }

    var displayIdentifier: String? {
        identifier.uppercased()
    }

    var displayLocalizedSymbol: String? {
        Locale.current.localizedCurrencySymbol(forCurrencyCode: identifier)
    }

    var displaySymbol: String? {
        let allLocalCurrencies = Locale.availableIdentifiers.compactMap { Locale(identifier: $0) }
        return allLocalCurrencies.first { $0.currency == self }?.currencySymbol
    }

    // MARK: - Deprecated aliases for backward compatibility
    @available(*, deprecated, renamed: "displayName", message: "Use displayName instead")
    var dispalyName: String? {
        displayName
    }

    @available(*, deprecated, renamed: "displayIdentifier", message: "Use displayIdentifier instead")
    var dispalyIdentifier: String? {
        displayIdentifier
    }

    @available(*, deprecated, renamed: "displayLocalizedSymbol", message: "Use displayLocalizedSymbol instead")
    var dispalyLocalizedSymbol: String? {
        displayLocalizedSymbol
    }

    @available(*, deprecated, renamed: "displaySymbol", message: "Use displaySymbol instead")
    var dispalySymbol: String? {
        displaySymbol
    }

    var locale: Locale? {
        let allLocalCurrencies = Locale.availableIdentifiers.compactMap { Locale(identifier: $0) }
        return allLocalCurrencies.first { $0.currency == self }
    }

    static var countryCurrencies: [Locale.Currency] {
        Locale.availableIdentifiers
            .compactMap { Locale(identifier: $0).currency }
            .removeDuplicates()
            .sorted { $0.displayName ?? "" < $1.displayName ?? "" }
    }
}
