//
//  WeatherView.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    let cityTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter city"
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "City name"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let outsideWeatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "Clear"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageWeather: UIImageView = {
        let iv = UIImageView(image: UIImage())
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let iconTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "🌡"
        label.textAlignment = .center
        label.font = UIFont(name: "Apple Color Emoji", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let temperatureWeatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "...°C"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let iconWindLabel: UILabel = {
        let label = UILabel()
        label.text = "💨"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Apple Color Emoji", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let speedWeatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "... km/h"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(cityTextField)
        [cityTextField.topAnchor.constraint(equalTo: topAnchor, constant: 20),
         cityTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
         cityTextField.widthAnchor.constraint(equalToConstant: 200),
         cityTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)].forEach({$0.isActive = true})

        addSubview(cityNameLabel)
        [cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 55),
         cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         cityNameLabel.leftAnchor.constraint(equalTo: leftAnchor),
         cityNameLabel.rightAnchor.constraint(equalTo: rightAnchor),
         cityNameLabel.heightAnchor.constraint(equalToConstant: 30)].forEach({$0.isActive = true})

        addSubview(outsideWeatherLabel)
        [outsideWeatherLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 8),
         outsideWeatherLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         outsideWeatherLabel.heightAnchor.constraint(equalToConstant: 30)].forEach({$0.isActive = true})

        addSubview(imageWeather)
        [imageWeather.topAnchor.constraint(equalTo: outsideWeatherLabel.bottomAnchor),
         imageWeather.centerXAnchor.constraint(equalTo: centerXAnchor, constant: UIScreen.main.bounds.width/15),
         imageWeather.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2.5),
         imageWeather.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2.5)].forEach({$0.isActive = true})

        addSubview(iconTemperatureLabel)
        [iconTemperatureLabel.centerXAnchor.constraint(equalTo: leftAnchor, constant: UIScreen.main.bounds.width/4.5),
         iconTemperatureLabel.widthAnchor.constraint(equalToConstant: 50),
         iconTemperatureLabel.heightAnchor.constraint(equalToConstant: 50),
         iconTemperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)].forEach({$0.isActive = true})

        addSubview(temperatureWeatherLabel)
        [temperatureWeatherLabel.topAnchor.constraint(equalTo: iconTemperatureLabel.bottomAnchor, constant: 4),
         temperatureWeatherLabel.centerXAnchor.constraint(equalTo: iconTemperatureLabel.centerXAnchor),
         temperatureWeatherLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
         temperatureWeatherLabel.widthAnchor.constraint(equalToConstant: 100)].forEach({$0.isActive = true})

        addSubview(iconWindLabel)
        [iconWindLabel.centerXAnchor.constraint(equalTo: rightAnchor, constant: -UIScreen.main.bounds.width/4.5),
         iconWindLabel.widthAnchor.constraint(equalToConstant: 50),
         iconWindLabel.heightAnchor.constraint(equalToConstant: 50),
         iconWindLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)].forEach({$0.isActive = true})

        addSubview(speedWeatherLabel)
        [speedWeatherLabel.topAnchor.constraint(equalTo: iconWindLabel.bottomAnchor, constant: 4),
         speedWeatherLabel.centerXAnchor.constraint(equalTo: iconWindLabel.centerXAnchor),
         speedWeatherLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
         speedWeatherLabel.widthAnchor.constraint(equalToConstant: 120)].forEach({$0.isActive = true})
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

