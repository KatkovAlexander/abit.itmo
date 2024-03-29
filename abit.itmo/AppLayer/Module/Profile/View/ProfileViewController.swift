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
    private var models = [ProfileTableViewCellType]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Colors.background.ui
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInset.top = AppConstants.compactSpacing
        return tableView
    }()
    
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
        setupUI()
        viewModel.viewDidLoad()
    }
}

// MARK: UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.row] {
            case .profile:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: ProfileTableCell.self),
                    for: indexPath
                ) as? ProfileTableCell else {
                    return UITableViewCell(style: .default, reuseIdentifier: nil)
                }
                return cell
            case .questionnaire(let status):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: QuestionnaireCell.self),
                    for: indexPath
                ) as? QuestionnaireCell else {
                    return UITableViewCell(style: .default, reuseIdentifier: nil)
                }
                cell.bind(status: status)
                return cell
        }
    }
}

// MARK: Private extension

private extension ProfileViewController {
    
    func setupUI() {
        configureLayout()
        registerCells()
        bindings()
        configureNavigationBar()
    }
    
    func configureLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func registerCells() {
        tableView.register(
            ProfileTableCell.self,
            forCellReuseIdentifier: String(describing: ProfileTableCell.self)
        )
        tableView.register(
            QuestionnaireCell.self,
            forCellReuseIdentifier: String(describing: QuestionnaireCell.self)
        )
    }
    
    func bindings() {
        viewModel.$tableViewModels
            .sink { [weak self] tableViewModels in
                self?.models = tableViewModels
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellableSet)
        
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Профиль"
        navigationController?.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(
                ofSize: 32, weight: .semibold
            ),
            .foregroundColor: UIColor.makeGradient(
                colors: [Colors.skyBlue.cg, Colors.roseGold.cg],
                size: CGSize(width: 146, height: 39)
            )
        ]
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(
                ofSize: 20, weight: .semibold
            ),
            .foregroundColor: UIColor.makeGradient(
                colors: [Colors.skyBlue.cg, Colors.roseGold.cg],
                size: CGSize(width: 93, height: 24)
            )
        ]
        appearance.backgroundColor = Colors.dark.ui
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
