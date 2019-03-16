//
//  ExchangeService.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 14/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

class ServiceExchange {
    static let shared = ServiceExchange()

    func downloadFromServer(value: Double, completionHandler: @escaping (ExchangeModel) -> ()) {
        let urlString = "http://data.fixer.io/api/latest?access_key=356dae2235195b60bb99471f9de6c140"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("Failed to fetch data:", err)
            }

            guard let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let jsonExchangeRate = ExchangeItemMapper.map(data, response) else {
                    return
            }

            var rates = jsonExchangeRate.rates
            rates.aud = RoundedHelper.formmated(value: &rates.aud, with: value)
            rates.brl = RoundedHelper.formmated(value: &rates.brl, with: value)
            rates.cad = RoundedHelper.formmated(value: &rates.cad, with: value)
            rates.cny = RoundedHelper.formmated(value: &rates.cny, with: value)
            rates.gbp = RoundedHelper.formmated(value: &rates.gbp, with: value)
            rates.idr = RoundedHelper.formmated(value: &rates.idr, with: value)
            rates.inr = RoundedHelper.formmated(value: &rates.inr, with: value)
            rates.jpy = RoundedHelper.formmated(value: &rates.jpy, with: value)
            rates.mxn = RoundedHelper.formmated(value: &rates.mxn, with: value)
            rates.sgd = RoundedHelper.formmated(value: &rates.sgd, with: value)
            rates.usd = RoundedHelper.formmated(value: &rates.usd, with: value)
            rates.vnd = RoundedHelper.formmated(value: &rates.vnd, with: value)

            jsonExchangeRate.rates = rates

            completionHandler(jsonExchangeRate.genericItem)
            }.resume()
    }
}
