//
//  Double+extension.swift
//  abit.itmo
//
//  Created by Александр Катков on 23.09.2023.
//

extension Double {
    
    var formatted: String {
        let decimal = Int((self * 100).truncatingRemainder(dividingBy: 100))
        if decimal == 0 {
            return String(format: "%.0f", self)
        } else if decimal % 10 == 0 {
            return String(format: "%.1f", self)
        } else {
            return String(format: "%.2f", self)
        }
    }
}
