//
//  Colors.swift
//  abit.itmo
//
//  Created by Александр Катков on 14.09.2023.
//

import UIKit

enum Colors: String {
    
    case white
    case darkBlue
    case darkGray
    case mediumGray
    case lightBlue
    case skyBlue
    case roseGold
    case font
    case lightGray
    case red
    case dark
    case background
    
    var ui: UIColor {
        UIColor(named: rawValue) ?? .blue
    }
    
    var cg: CGColor {
        self.ui.cgColor
    }
}
