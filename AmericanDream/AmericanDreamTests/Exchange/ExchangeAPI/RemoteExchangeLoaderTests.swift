//
//  RemoteExchangeLoaderTests.swift
//  AmericanDreamTests
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import XCTest
import AmericanDream

class RemoteExchangeLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_load_requestDataFromURL() {
        let url = anyURL()
        let (sut, client) = makeSUT(url: url)

        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_loadTwice_requestDataFromURLTwice() {
        let url = anyURL()
        let (sut, client) = makeSUT(url: url)

        sut.load { _ in }
        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut: sut, toCompleteWith: failure(.connectivity), when: {
            let clientError = NSError(domain: "test", code: 0)
            client.complete(with: clientError)
        })
    }

    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]

        samples.enumerated().forEach { index, code in
            expect(sut: sut, toCompleteWith: failure(.invalidData), when: {
                let invalidJSON = makeJSON(valid: false)
                client.complete(withStatusCode: code, data: invalidJSON, at: index)
            })
        }
    }

    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()

        expect(sut: sut, toCompleteWith: failure(.invalidData), when: {
            let invalidJSON = makeJSON(valid: false)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }

    func test_load_deliversItemOn200HTTPResponseWithJSONItem() {
        let (sut, client) = makeSUT()

        let item = makeItem(date: "2019-02-18",
                            base: "EUR",
                            timestamp: 1550517245,
                            currency: ["GBP": 0.87, "USD": 1.13, "CAD": 1.49, "AUD": 1.58, "JPY": 125.07, "CNY": 7.65, "INR": 80.75, "SGD": 1.53, "BRL": 4.21, "IDR": 15981.74, "VND": 26236.82, "MXN": 21.76])

        expect(sut: sut, toCompleteWith: .success(item.model), when: {
            client.complete(withStatusCode: 200, data: makeJSON(valid: true))
        })
    }

    // MARK: - Helpers

    private func makeSUT(url: URL = URL(string: "http://a-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteExchangeLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteExchangeLoader(client: client, url: url)

        trackMemoryLeaks(instance: client, file: file, line: line)
        trackMemoryLeaks(instance: sut, file: file, line: line)

        return (sut, client)
    }

    fileprivate func failure(_ error: RemoteExchangeLoader.Error) -> RemoteExchangeLoader.Result {
        return .failure(error)
    }

    fileprivate func makeItem(date: String, base: String, timestamp: Int, currency: [String: Double]) -> (model: ExchangeModel, json: Data) {
        let item = ExchangeModel(timestamp: timestamp, date: date, base: base, currency: currency)
        let json = makeJSON(valid: true)

        return (item, json)
    }

    fileprivate func makeJSON(valid: Bool) -> Data {
        let invalidJSON = Data(bytes: "invalid json".utf8)
        let filePath = Bundle(for: type(of: self)).url(forResource: "exchange", withExtension: "json")!
        let validJSON = try! Data(contentsOf: filePath)

        return valid ? validJSON : invalidJSON
    }

    fileprivate func anyURL() -> URL {
        return URL(string: "https://any-url.com")!
    }

    private func expect(sut: RemoteExchangeLoader, toCompleteWith expectedResult: RemoteExchangeLoader.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {

        let exp = expectation(description: "Wait for completion")

        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItem), .success(expectedItem)):
                XCTAssertEqual(receivedItem, expectedItem, file: file, line: line)
            case let (.failure(receivedError as RemoteExchangeLoader.Error), .failure(expectedError as RemoteExchangeLoader.Error)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }

            exp.fulfill()
        }

        action()
        wait(for: [exp], timeout: 1.0)
    }

    class HTTPClientSpy: HTTPClient {
        var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()

        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }

        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }

        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }

        func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil)!

            messages[index].completion(.success(data, response))
        }
    }
}
