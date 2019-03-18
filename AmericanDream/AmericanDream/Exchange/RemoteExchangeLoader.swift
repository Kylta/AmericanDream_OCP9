//
//  RemoteExchangeLoader.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

public final class RemoteExchangeLoader: GenericLoader {
    private let client: HTTPClient
    private let url: URL

    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    public typealias Result = LoadGenericResult<ExchangeModel>

    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in

            switch result {
            case let .success(data, response):
                completion(ExchangeItemMapper.map(data, response))
            case .failure:
                completion(.failure(RemoteExchangeLoader.Error.connectivity))
            }
        }
    }
}
