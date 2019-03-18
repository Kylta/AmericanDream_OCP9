//
//  WeatherMapper.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

internal final class WeatherItemMapper: Decodable {
    let name: String
    let date: Int
    let weather: [Weather]
    let temperature: Double
    let wind: Double
    var outsideWeather: String {
        return weather.map { $0.main }.first!
    }
    var description: String {
        return weather.map { $0.description }.first!
    }
    var weatherItem: WeatherItem {
        return WeatherItem(name: name, date: date, weather: outsideWeather, description: description, temperature: temperature, wind: wind)
    }

    struct Weather: Decodable {
        let main: String
        let description: String
    }

    enum CodingKeys: String, CodingKey {
        case name, wind, main, weather
        case date = "dt"
    }

    enum TempCodingKeys: String, CodingKey {
        case temp
    }

    enum WindCodingKeys: String, CodingKey {
        case speed
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tempContainer = try container.nestedContainer(keyedBy: TempCodingKeys.self, forKey: .main)
        let windContainer = try container.nestedContainer(keyedBy: WindCodingKeys.self, forKey: .wind)

        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(Int.self, forKey: .date)
        weather = try container.decode([Weather].self, forKey: .weather)
        temperature = try tempContainer.decode(Double.self, forKey: .temp)
        wind = try windContainer.decode(Double.self, forKey: .speed)
    }

    private static var OK_200: Int {
        return 200
    }

    internal static func map(_ data: Data, _ response: HTTPURLResponse) -> WeatherItem? {
        guard response.statusCode == OK_200,
            let weatherItemMapper = try? JSONDecoder().decode(WeatherItemMapper.self, from: data) else {
                return nil
        }

        return weatherItemMapper.weatherItem
    }
}
