//
//  ListFactory.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

struct ListFactory {
    
    func build() -> UIViewController {
        let viewModel = ListViewModel()
        return ListViewController(viewModel: viewModel)
    }
}
