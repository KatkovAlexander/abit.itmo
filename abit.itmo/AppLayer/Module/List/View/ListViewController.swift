//
//  ListViewController.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine
import SnapKit
import UIKit

final class ListViewController: UIViewController {
    
    // MARK: Private properties
    
    private let viewModel: ListViewModel
    private var cancellableSet = Set<AnyCancellable>()
    
    // MARK: Initialization
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

