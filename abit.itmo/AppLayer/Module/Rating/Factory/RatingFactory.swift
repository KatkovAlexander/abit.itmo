//
//  RatingFactory.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

struct RatingFactory {
    
    func build() -> UIViewController {
        let viewController = RatingViewController()
        let viewModel = RatingViewModel(transitionHandler: viewController)
        viewController.viewModel = viewModel
        return viewController
    }
}
