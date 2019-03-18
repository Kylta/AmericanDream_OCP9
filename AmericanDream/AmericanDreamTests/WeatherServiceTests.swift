//
//  WeatherServiceTests.swift
//  AmericanDreamTests
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import XCTest
@testable import AmericanDream

class WeatherServiceTests: XCTestCase {

    func test_downloadFromServer_sendRequestFromUrl() {
        let exp = expectation(description: "wait for completion")

        WeatherService.shared.downloadFromServer(city: "Paris") { weather in
            XCTAssertEqual(weather.cityName, "Paris")
            exp.fulfill()
        }

        wait(for: [exp], timeout: 5.0)
    }
}
