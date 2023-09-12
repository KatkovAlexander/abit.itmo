//
//  CALayer+extension.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

extension CALayer {

    func applyNavBarShadow() {
        shadowRadius = 8
        shadowOffset = .init(width: 0, height: 4)
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.05
    }
}
