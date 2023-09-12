//
//  AuthFactory.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import UIKit

struct AuthFactory {
    
    func build() -> UIViewController {
        let viewModel = AuthViewModel()
        return AuthViewController(viewModel: viewModel)
    }
}
