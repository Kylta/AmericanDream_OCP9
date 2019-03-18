//
//  WeatherService
//  AmericanDream
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

struct WeatherService {

    static let shared = WeatherService()

    func downloadFromServer(city: String, completionHandler: @escaping (WeatherItem) -> ()) {
        var weather: WeatherItem!

        print("attempting to download city...")

        let originalString = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&APPID=f33ca45f1e944339541f316aef6cda60"

        let urlString = originalString.components(separatedBy: .whitespaces).joined()

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to download city:", err)
                return
            }

            guard let data = data,
                let response = resp as? HTTPURLResponse,
                response.statusCode == 200 else { return }

                weather = WeatherItemMapper.map(data, response)

            print(weather)

                completionHandler(weather)
            }.resume()
    }
}

