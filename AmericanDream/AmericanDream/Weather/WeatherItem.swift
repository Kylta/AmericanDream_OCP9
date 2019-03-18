//
//  WeatherItem.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

public struct WeatherItem: Equatable {
    public let name: String
    public let date: Int
    public let weather: String
    public let description: String
    public let temperature: Double
    public let wind: Double

    public init(name: String, date: Int, weather: String, description: String, temperature: Double, wind: Double) {
        self.name = name
        self.date = date
        self.weather = weather
        self.description = description
        self.temperature = temperature
        self.wind = wind
    }
}
