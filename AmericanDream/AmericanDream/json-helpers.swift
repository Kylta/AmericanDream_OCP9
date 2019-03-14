//
//  json-helpers.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 14/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        return try decode(T.self, from: data)
    }
}

struct Service {
    static func getJSON(from data: Data, atKeyPath keyPath: String) throws -> Any {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let result = json?[keyPath] else {
                throw NSError()
        }
        return result
    }
}
