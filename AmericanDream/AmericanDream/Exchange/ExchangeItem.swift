//
//  ExchangeItem.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 14/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

public struct ExchangeModel: Equatable {
    public typealias Currency = [String: Double]
    public let timestamp: Int
    public let date: String
    public let base: String
    public var currency: Currency

    public init(timestamp: Int, date: String, base: String, currency: Currency) {
        self.timestamp = timestamp
        self.date = date
        self.base = base
        self.currency = currency
    }

    private var sortedCurrencies: [(key: String, value: Double)] {
        return currency.sorted(by: { $0.value < $1.value })
            .sorted(by: { first,_ in  first.key == "USD" })
    }

    var currenciesKeys: [String] {
        return sortedCurrencies.map { $0.key }
    }

    var currenciesValues: [Double] {
        return sortedCurrencies.map { $0.value }
    }

    var emojiFlags: [String] {
        var flags = [String]()
        currenciesKeys.forEach { flags.append(formatEmojiFlag(regionCode: $0))}
        return flags
    }

    var symbolCurrencies: [String] {
        var symbols = [String]()
        currenciesKeys.forEach { symbols.append(getSymbol(forCurrencyCode: $0)!)}
        return symbols
    }

    mutating func updateCurrenciesValue(value: Double) {
        var currencies = [String: Double]()
        currency.forEach { currencies[$0.key] = Double($0.value * value).rounded(toPlaces: 3) }
        self.currency = currencies
    }

    private func formatEmojiFlag(regionCode: String) -> String {
        var code = regionCode.uppercased()
        code.removeLast()
        var flagString = ""

        code.unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value) }
            .forEach { flagString.append(String($0)) }

        return flagString
    }

    private func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
}
