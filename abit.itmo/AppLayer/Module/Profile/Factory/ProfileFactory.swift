//
//  ProfileFactory.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

struct ProfileFactory {
    
    func build() -> UIViewController {
        let viewModel = ProfileViewModel()
        return ProfileViewController(viewModel: viewModel)
    }
}
