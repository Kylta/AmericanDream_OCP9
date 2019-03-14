//
//  TranslateServiceTests.swift
//  AmericanDreamTests
//
//  Created by Christophe Bugnon on 14/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import XCTest
@testable import AmericanDream

class TranslateServiceTests: XCTestCase {

    func test_downloadFromServer_sendRequestFromUrl() {
        let exp = expectation(description: "wait for completion")

        _ = ServiceTranslator.shared.downloadFromServer(text: "Hello", languageTranslation: "fr") { model in
            XCTAssertEqual(model.translatedText, "Bonjour")
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }
}
