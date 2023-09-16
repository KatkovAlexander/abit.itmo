//
//  NavigationController.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

class NavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        commonInit()
    }

    private func commonInit() {
        applyShadow()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white        
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = .black
        navigationBar.barTintColor = .white
        
    }
    
    private func applyShadow() {
        navigationBar.shadowImage = UIImage()

        navigationBar.layer.applyNavBarShadow()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewControllers.last?.navigationItem.backBarButtonItem = backButton
        super.pushViewController(viewController, animated: animated)
    }
}
