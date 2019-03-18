//
//  WeatherItem.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

public struct WeatherItem: Equatable {
    public let cityName: String
    public let date: Int
    public let weather: String
    public let description: String
    public let temperature: Double
    public let wind: Double
    public let icon: String

    public init(cityName: String, date: Int, weather: String, description: String, temperature: Double, wind: Double, icon: String) {
        self.cityName = cityName
        self.date = date
        self.weather = weather
        self.description = description
        self.temperature = temperature
        self.wind = wind
        self.icon = icon
    }
}
