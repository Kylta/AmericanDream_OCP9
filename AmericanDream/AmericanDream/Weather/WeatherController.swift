//
//  WeatherController.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherController: UIViewController {

    var weatherTopView = WeatherView()
    var weatherBotView = WeatherView()

    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Weather"

        setupUI()

        determineMyCurrentLocation()

        fetchManually(with: "Paris")

        weatherTopView.cityTextField.delegate = self
        guard let locationTopView = weatherTopView.cityNameLabel.text else { return }

        fetchManually(with: locationTopView)

        weatherBotView.cityTextField.delegate = self
        guard let locationBotView = weatherBotView.cityTextField.text else { return }
        fetchAutomatically(with: locationBotView)

    }

    override func viewWillAppear(_ animated: Bool) {
        determineMyDeviceOrientation()
    }

    func determineMyDeviceOrientation() {
        if UIDevice.current.orientation.isLandscape {
            removeWeatherImage(isHidden: true)
        } else {
            removeWeatherImage(isHidden: false)
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        determineMyDeviceOrientation()
    }


    private func removeWeatherImage(isHidden: Bool) {
        weatherTopView.imageWeather.isHidden = isHidden
        weatherBotView.imageWeather.isHidden = isHidden
    }

    private func determineMyCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    private func fetchManually(with location: String) {
        // Operate API call on background thread
        DispatchQueue.global(qos: .background).async {

            // Call rest API
            WeatherService.shared.downloadFromServer(city: location) { (weather) in

                DispatchQueue.main.async {
                    self.weatherTopView.cityNameLabel.text = weather.cityName
                    self.weatherTopView.temperatureWeatherLabel.text = "\(weather.temperature)°C"
                    self.weatherTopView.outsideWeatherLabel.text = weather.weather
                    self.weatherTopView.speedWeatherLabel.text = "\(weather.wind) km/h"
                    self.weatherTopView.imageWeather.image = UIImage(named: weather.icon)
                }
            }
        }
    }

    private func fetchAutomatically(with location: String) {
        // Operate API call on background thread
        DispatchQueue.global(qos: .background).async {

            // Call rest API
            WeatherService.shared.downloadFromServer(city: location) { (weather) in

                DispatchQueue.main.async {
                    self.weatherBotView.cityNameLabel.text = weather.cityName
                    self.weatherBotView.temperatureWeatherLabel.text = "\(weather.temperature)°C"
                    self.weatherBotView.outsideWeatherLabel.text = weather.weather
                    self.weatherBotView.speedWeatherLabel.text = "\(weather.wind) km/h"
                    self.weatherBotView.imageWeather.image = UIImage(named: weather.icon)
                }
            }
        }
    }

    private func setupUI() {

        view.backgroundColor = .lightBlue

        weatherTopView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherTopView)
        [weatherTopView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         weatherTopView.leftAnchor.constraint(equalTo: view.leftAnchor),
         weatherTopView.rightAnchor.constraint(equalTo: view.rightAnchor),
         weatherTopView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)].forEach({$0.isActive = true})

        weatherBotView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherBotView)
        [weatherBotView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
         weatherBotView.leftAnchor.constraint(equalTo: view.leftAnchor),
         weatherBotView.rightAnchor.constraint(equalTo: view.rightAnchor),
         weatherBotView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }
}

extension WeatherController: UITextFieldDelegate {

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if weatherTopView.cityTextField.isEditing {
            fetchManually(with: weatherTopView.cityTextField.text!)
        } else {
            fetchAutomatically(with: weatherBotView.cityTextField.text!)
        }
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if weatherTopView.cityTextField.isEditing {
            fetchManually(with: textField.text!)
        } else {
            fetchAutomatically(with: textField.text!)
        }

        return true
    }

}

extension WeatherController: CLLocationManagerDelegate {

    private func fetchCity(location: CLLocation, completion: @escaping (String) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error \(error)")
            } else if let city = placemarks?.first?.locality {
                completion(city)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        fetchCity(location: location) { (city) in
            let cityDash = city.replacingOccurrences(of: " ", with: "-")
            self.fetchAutomatically(with: cityDash)
        }
    }
}

