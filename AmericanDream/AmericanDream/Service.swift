//
//  Service.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 14/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

struct ServiceTranslator {

    static let shared = ServiceTranslator()

    private init() {}

    func downloadFromServer(text: String, languageTranslation: String, completionHandler: @escaping (TranslateModel) -> ()) {
        let originalString = "https:www.googleapis.com/language/translate/v2?key=AIzaSyAZBRy5yETaiffUODxICqMxGBrSnSWXzRQ&target=\(languageTranslation)&q=\(text)"
        let urlString = originalString.components(separatedBy: .whitespaces).joined()

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("Failed to fetch from server:", err)
            }

            guard let data = data, let response = response as? HTTPURLResponse else { return }

            if let jsonTranslator = TranslateItemMapper.map(data, response) {
                    completionHandler(jsonTranslator)
                }
            }.resume()
    }
}
