//
//  RatingProgramDetailFactory.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

struct RatingProgramDetailFactory {
    
    func build(isPersonal: Bool) -> UIViewController {
        let viewModel = RatingProgramDetailViewModel()
        return RatingProgramDetailViewController(viewModel: viewModel)
    }
}
