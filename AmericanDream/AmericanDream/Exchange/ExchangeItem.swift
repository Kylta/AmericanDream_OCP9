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
    public let currency: Currency

    public init(timestamp: Int, date: String, base: String, currency: Currency) {
        self.timestamp = timestamp
        self.date = date
        self.base = base
        self.currency = currency
    }

    public func getEmojiFlag(regionCode: String) -> String {
        var code = regionCode.uppercased()
        code.removeLast()
        var flagString = ""

        code.unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value) }
            .forEach { flagString.append(String($0)) }

        return flagString
    }

    public func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
}

internal final class ExchangeItemMapper: Decodable {
    let timestamp: Int
    let base: String
    let date: String
    let rates: Rates

    var genericItem: ExchangeModel {
        return ExchangeModel(timestamp: timestamp, date: date, base: base, currency: rates.getCurrencies())
    }

    struct Rates: Decodable {
        let gbp: Double
        let cad: Double
        let aud: Double
        let jpy: Double
        let cny: Double
        let inr: Double
        let sgd: Double
        let brl: Double
        let idr: Double
        let vnd: Double
        let mxn: Double
        let usd: Double

        enum CodingKeys: String, CodingKey {
            case gbp = "GBP"
            case cad = "CAD"
            case aud = "AUD"
            case jpy = "JPY"
            case cny = "CNY"
            case inr = "INR"
            case sgd = "SGD"
            case brl = "BRL"
            case idr = "IDR"
            case vnd = "VND"
            case mxn = "MXN"
            case usd = "USD"
        }

        func getCurrencies() -> [String: Double] {
            return ["GBP": gbp,
                    "USD": usd,
                    "CAD": cad,
                    "AUD": aud,
                    "JPY": jpy,
                    "CNY": cny,
                    "INR": inr,
                    "SGD": sgd,
                    "BRL": brl,
                    "IDR": idr,
                    "VND": vnd,
                    "MXN": mxn]
        }
    }


    private static var OK_200: Int {
        return 200
    }

    internal static func map(_ data: Data, _ response: HTTPURLResponse) -> ExchangeItemMapper? {
        guard response.statusCode == OK_200,
            let exchangeItemMapper = try? JSONDecoder().decode(ExchangeItemMapper.self, from: data) else {
                return nil
        }

        return exchangeItemMapper
    }
}
