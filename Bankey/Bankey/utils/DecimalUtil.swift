//
//  DecimalUtil.swift
//  Bankey
//
//  Created by srinivas on 28/08/22.
//

import Foundation

extension Decimal {
    
    var doubleValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }
}
