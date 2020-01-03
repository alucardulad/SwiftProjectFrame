//
//  Double+Extension.swift
//  VeSync
//
//  Created by dave on 2019/9/26.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import Foundation

extension Double {

    /// Rounds the double to decimal places value
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

}
