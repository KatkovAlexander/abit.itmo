//
//  UIColor+extension.swift
//  abit.itmo
//
//  Created by Александр Катков on 18.09.2023.
//

import UIKit

extension UIColor {
    
    static func makeGradient(colors: [CGColor], size: CGSize) -> UIColor {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        guard let image = gradient.getImageFrom() else {
            return Colors.red.ui
        }
        
        return UIColor(patternImage: image)
    }
}
