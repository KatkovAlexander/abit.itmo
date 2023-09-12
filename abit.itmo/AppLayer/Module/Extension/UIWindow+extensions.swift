//
//  UIWindow+extensions.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

extension UIWindow {

    func setRoot(_ root: UIViewController) {
        rootViewController = root
        makeKeyAndVisible()
    }
}
