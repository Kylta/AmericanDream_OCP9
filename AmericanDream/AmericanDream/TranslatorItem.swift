//
//  TranslatorItem.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 14/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

public struct TranslateModel: Equatable {
    public let translatedText: String

    public init(translatedText: String) {
        self.translatedText = translatedText
    }

    public var data: [String] = {
        return ["af","sq", "am", "ar", "hy", "az", "eu", "be", "bn", "bs", "bg", "ca", "ceb", "zh-CN", "zh-TW", "co", "hr", "cs", "da", "nl", "en", "eo", "et", "fi", "fr", "fy", "gl", "ka", "de", "el", "gu", "ht", "ha", "haw", "iw", "hi", "hmn", "hu", "is", "ig", "id", "ga", "it", "ja", "jw", "kn", "kk", "km", "ko", "ku", "ky", "lo", "la", "lv", "lt", "lb", "mk", "mg", "ms", "ml", "mt", "mi", "mr", "mn", "my", "ne", "no", "ny", "ps", "fa", "pl", "pt", "pa", "ro", "ru", "sm", "gd", "sr", "st", "sn", "sd", "si", "sk", "sl", "so", "es", "su", "sw", "sv", "tl", "tg", "ta", "te", "th", "th", "uk", "ur", "uz", "vi", "cy", "xh", "yi", "yo", "zu" ].sorted(by: {$0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending})
    }()
}

internal final class TranslateItemMapper: Decodable {
    let translations: [Response]
    var translateItem: TranslateModel {
        return TranslateModel(translatedText: translations.map { $0.translatedText }.first!)
    }

    struct Response: Decodable {
        let detectedSourceLanguage: String
        let translatedText: String
    }

    private static var OK_200: Int {
        return 200
    }

    internal static func map(_ data: Data, _ response: HTTPURLResponse) -> TranslateModel? {
        guard response.statusCode == 200,
            let json = try? Service.getJSON(from: data, atKeyPath: "data"),
            let translateItemMapper = try? JSONDecoder().decode(TranslateItemMapper.self, withJSONObject: json) else {
                return nil
        }

        return translateItemMapper.translateItem
    }
}
