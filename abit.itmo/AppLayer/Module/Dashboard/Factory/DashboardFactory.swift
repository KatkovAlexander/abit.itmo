//
//  DashboardFactory.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

struct DashboardFactory {
    
    func build() -> UIViewController {
        let viewController = DashboardViewController()
        let viewModel = DashboardViewModel(transitionHandler: viewController)
        viewController.viewModel = viewModel
        return viewController
    }
}
