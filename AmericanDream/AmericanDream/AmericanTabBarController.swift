//
//  AmericanTabBarController.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 14/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import UIKit

class AmericanTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightBlue

        self.tabBar.tintColor = .white
        self.tabBar.barTintColor = .darkBlue

        let navExchangeController = UINavigationController(rootViewController: ExchangeRateTableViewController())
        let exchangeRateController = navExchangeController
        exchangeRateController.tabBarItem = UITabBarItem(title: "Exchange Rate", image: #imageLiteral(resourceName: "money_bag_euro"), tag: 0)

        let navTranslatorController = UINavigationController(rootViewController: TranslatorController())
        let translatorController = navTranslatorController
        translatorController.tabBarItem = UITabBarItem(title: "Translate", image: #imageLiteral(resourceName: "globe"), tag: 1)

        let navWeatherController = UINavigationController(rootViewController: WeatherController())
        let weatherController = navWeatherController
        weatherController.tabBarItem = UITabBarItem(title: "Weather", image: #imageLiteral(resourceName: "sun"), tag: 2)

        let viewControllerList = [
            exchangeRateController, translatorController, weatherController
        ]

        viewControllers = viewControllerList
    }

}


