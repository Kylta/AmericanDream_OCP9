//
//  Rounded+Double.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 16/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int, with value: Double) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor * value).rounded() / divisor
    }
}
