//
//  ExchangeAPIEndToEndTests.swift
//  AmericanDreamTests
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import XCTest
import AmericanDream

class ExchangeAPIEndToEndTests: XCTestCase {

    func test_endToEndTestServerGETExchangeResult_matchesFixedTestAccountData() {
        switch getExchangeResult() {
        case let .success(item)?:
            XCTAssertNotNil(item)
            XCTAssertEqual(item.emojiFlags.first, "🇺🇸")
            XCTAssertEqual(item.symbolCurrencies.first, "$")
        case let .failure(error)?:
            XCTFail("Expected successful Exchange result, got \(error) instead")
        default:
            XCTFail("Expected successful Exchange result, got no result instead")
        }
    }

    // MARK: - Helpers

    private func getExchangeResult(file: StaticString = #file, line: UInt = #line) -> LoadGenericResult<ExchangeModel>? {
        let client = URLSessionExchangeHTTPClient()
        // Use samples URL from your API
        let testServerURL = URL(string: "http://data.fixer.io/api/latest?access_key=356dae2235195b60bb99471f9de6c140&base?=EUR&symbols=USD,GBP,CAD,AUD,JPY,CNY,INR,SGD,BRL,IDR,VND,MXN")!
        let loader = RemoteExchangeLoader(client: client, url: testServerURL)
        trackMemoryLeaks(instance: client, file: file, line: line)
        trackMemoryLeaks(instance: loader, file: file, line: line)

        let exp = expectation(description: "Wait for load completion")

        var receivedResult: LoadGenericResult<ExchangeModel>?
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }

        wait(for: [exp], timeout: 5.0)
        return receivedResult
    }
}
