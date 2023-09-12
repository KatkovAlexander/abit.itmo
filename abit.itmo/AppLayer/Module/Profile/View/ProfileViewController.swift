//
//  ProfileViewController.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine
import SnapKit
import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: Private properties
    
    private let viewModel: ProfileViewModel
    private var cancellableSet = Set<AnyCancellable>()
    
    // MARK: Initialization
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

