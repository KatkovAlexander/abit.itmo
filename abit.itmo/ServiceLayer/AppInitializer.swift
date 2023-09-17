//
//  AppInitializer.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

class AppInitializer {
    
    static let instance = AppInitializer()
    
    func appInit(_ windowScene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        
        GlobalRouter.instance.window = window
        GlobalRouter.instance.setMain()
        
        return window
    }
}
