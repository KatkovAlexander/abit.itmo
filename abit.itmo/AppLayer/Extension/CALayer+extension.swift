//
//  CALayer+extension.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

extension CALayer {
    
    func applyShadow() {
        shadowRadius = 8
        shadowOffset = .init(width: 4, height: 4)
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.5
    }
    
    func getImageFrom() -> UIImage? {
        UIGraphicsBeginImageContext(frame.size)
        
        render(in: UIGraphicsGetCurrentContext()!)
        
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return outputImage
    }
}
