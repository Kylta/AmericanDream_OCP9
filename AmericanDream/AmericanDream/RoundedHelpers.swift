//
//  RoundedHelpers.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 16/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

struct RoundedHelper {
    static func formmated(value: inout Double, with number: Double) -> Double {
        value = Double(round(1000*value)/1000)
        return value * number
    }
}
