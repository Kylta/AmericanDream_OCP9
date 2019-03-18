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
            rates.aud = rates.aud.rounded(toPlaces: 3, with: value)
            rates.brl = rates.brl.rounded(toPlaces: 3, with: value)
            rates.cad = rates.cad.rounded(toPlaces: 3, with: value)
            rates.brl = rates.brl.rounded(toPlaces: 3, with: value)
            rates.cny = rates.cny.rounded(toPlaces: 3, with: value)
            rates.gbp = rates.gbp.rounded(toPlaces: 3, with: value)
            rates.idr = rates.idr.rounded(toPlaces: 3, with: value)
            rates.inr = rates.inr.rounded(toPlaces: 3, with: value)
            rates.jpy = rates.jpy.rounded(toPlaces: 3, with: value)
            rates.mxn = rates.mxn.rounded(toPlaces: 3, with: value)
            rates.sgd = rates.sgd.rounded(toPlaces: 3, with: value)
            rates.usd = rates.usd.rounded(toPlaces: 3, with: value)
            rates.vnd = rates.vnd.rounded(toPlaces: 3, with: value)

            jsonExchangeRate.rates = rates

            completionHandler(jsonExchangeRate.genericItem)
            }.resume()
    }
}
