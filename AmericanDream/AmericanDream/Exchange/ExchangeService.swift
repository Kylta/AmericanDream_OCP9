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

    func downloadFromServer(euro: Double, completionHandler: @escaping (ExchangeModel) -> ()) {
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
            
            completionHandler(jsonExchangeRate.genericItem)
            }.resume()
    }
}
