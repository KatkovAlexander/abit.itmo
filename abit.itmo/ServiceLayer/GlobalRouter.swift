//
//  GlobalRouter.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

class GlobalRouter {
    
    static let instance = GlobalRouter()
    
    weak var window: UIWindow?
    
    func setLogin() {
        let module = AuthFactory().build()
        let navigation = NavigationController(rootViewController: module)

        navigation.navigationBar.shadowImage = UIImage()
        navigation.navigationBar.layer.shadowOffset = .init(width: 0, height: -10)
                
        window?.setRoot(navigation)
    }
}
