//
// Copyright © 2026 Alexander Romanov
// CurrencyExtensionTests.swift
//

import Foundation
@testable import OversizeCore
import Testing

struct CurrencyExtensionTests {
    @Test func displayIdentifier_uppercasesCode() {
        guard #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) else { return }
        #expect(Locale.Currency("usd").displayIdentifier == "USD")
    }

    @Test func displayName_returnsLocalizedName() throws {
        guard #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) else { return }
        let name = try #require(Locale.Currency("usd").displayName)
        #expect(!name.isEmpty)
    }

    @Test func displaySymbol_returnsSymbol() throws {
        guard #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) else { return }
        let symbol = try #require(Locale.Currency("usd").displaySymbol)
        #expect(!symbol.isEmpty)
    }

    @Test func displayLocalizedSymbol_returnsSymbol() throws {
        guard #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) else { return }
        let symbol = try #require(Locale.Currency("usd").displayLocalizedSymbol)
        #expect(!symbol.isEmpty)
    }

    @Test func locale_returnsLocaleUsingCurrency() throws {
        guard #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) else { return }
        let currency = Locale.Currency("usd")
        let locale = try #require(currency.locale)
        #expect(locale.currency == currency)
    }

    @Test func countryCurrencies_isNotEmpty() {
        guard #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) else { return }
        #expect(!Locale.Currency.countryCurrencies.isEmpty)
    }

    @Test func countryCurrencies_containsNoDuplicates() {
        guard #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) else { return }
        let currencies = Locale.Currency.countryCurrencies
        #expect(Set(currencies.map(\.identifier)).count == currencies.count)
    }

    @Test func countryCurrencies_isSortedByDisplayName() {
        guard #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) else { return }
        let names = Locale.Currency.countryCurrencies.map { $0.displayName ?? "" }
        #expect(names == names.sorted())
    }

    @Test func stringLiteral_createsCurrency() {
        guard #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) else { return }
        let currency: Locale.Currency = "eur"
        #expect(currency.identifier == "eur")
        #expect(currency.displayIdentifier == "EUR")
    }
}

struct LocaleExtensionTests {
    @Test func localizedCurrencySymbol_withRegionalLocale_returnsSymbol() throws {
        guard #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) else { return }
        let symbol = try #require(Locale(identifier: "en_US").localizedCurrencySymbol(forCurrencyCode: "USD"))
        #expect(symbol == "$")
    }

    @Test func localizedCurrencySymbol_withoutRegion_returnsNil() {
        guard #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) else { return }
        #expect(Locale(identifier: "en").localizedCurrencySymbol(forCurrencyCode: "USD") == nil)
    }
}
