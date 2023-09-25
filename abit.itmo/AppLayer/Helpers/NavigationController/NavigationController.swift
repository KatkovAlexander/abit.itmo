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
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Colors.dark.ui
        appearance.titleTextAttributes = [
            .foregroundColor: Colors.white.ui,
            .font: UIFont.systemFont(
                ofSize: 17, weight: .semibold
            )
        ]
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = Colors.white.ui
        navigationBar.barTintColor = .white
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewControllers.last?.navigationItem.backBarButtonItem = backButton
        super.pushViewController(viewController, animated: animated)
    }
}
