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
    case lightBlue
    case font
    case lightGray
    case red
    
    var ui: UIColor {
        UIColor(named: rawValue) ?? .blue
    }
    
    var cg: CGColor {
        self.ui.cgColor
    }
}
