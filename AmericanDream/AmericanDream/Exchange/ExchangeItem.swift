//
//  ExchangeItem.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 14/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

struct ExchangeItem: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: Rates
}

struct Rates: Codable {
    let usd, gpb, cad, aud,
    jpy, cny, inr, sgd, brl,
    idr, vnr, mxn: Double

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gpb = "GPB"
        case cad = "CAD"
        case aud = "AUD"
        case jpy = "JPY"
        case cny = "CNY"
        case inr = "INR"
        case sgd = "SGD"
        case brl = "BRL"
        case idr = "IDR"
        case vnr = "VNR"
        case mxn = "MXN"
    }
}
