//
//  ProgramFactory.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

struct ProgramFactory {
    
    func build() -> UIViewController {
        let viewModel = ProgramViewModel()
        return ProgramViewController(viewModel: viewModel)
    }
}
