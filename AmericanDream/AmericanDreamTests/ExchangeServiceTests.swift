//
//  ExchangeServiceTests.swift
//  AmericanDreamTests
//
//  Created by Christophe Bugnon on 16/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import XCTest
@testable import AmericanDream

class ExchangeServiceTests: XCTestCase {

    func test_downloadFromServer_sendRequestFromUrl() {
        let exp = expectation(description: "wait for completion")

        _ = ServiceExchange.shared.downloadFromServer(euro: 2.0) { model in
            XCTAssertEqual(model.base, "EUR")
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }
}
