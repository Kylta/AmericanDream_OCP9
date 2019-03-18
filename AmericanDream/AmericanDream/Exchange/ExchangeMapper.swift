//
//  ExchangeMapper.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

internal final class ExchangeItemMapper: Decodable {
    let timestamp: Int
    let base: String
    let date: String
    var rates: Rates

    var genericItem: ExchangeModel {
        return ExchangeModel(timestamp: timestamp, date: date, base: base, currency: rates.getCurrencies())
    }

    struct Rates: Decodable {
        var gbp: Double
        var cad: Double
        var aud: Double
        var jpy: Double
        var cny: Double
        var inr: Double
        var sgd: Double
        var brl: Double
        var idr: Double
        var vnd: Double
        var mxn: Double
        var usd: Double

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

    internal static func map(_ data: Data, _ response: HTTPURLResponse) -> RemoteExchangeLoader.Result {
        guard response.statusCode == OK_200,
            let genericItemMapper = try? JSONDecoder().decode(ExchangeItemMapper.self, from: data) else {
                return .failure(RemoteExchangeLoader.Error.invalidData)
        }

        return .success(genericItemMapper.genericItem)
    }
}
