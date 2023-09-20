//
//  DashboardViewController.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine
import SnapKit
import UIKit

final class DashboardViewController: UIViewController {
    
    // MARK: Internal properties
    
    var viewModel: DashboardViewModel!

    // MARK: Private properties

    private var cancellableSet = Set<AnyCancellable>()
    private var models = [DashboardTableViewCellType]()
    
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
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
}

// MARK: UITableViewDataSource

extension DashboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.row] {
            case .educationalProgramms:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: EducationalProgrammsCell.self),
                    for: indexPath
                ) as? EducationalProgrammsCell else {
                    return UITableViewCell(style: .default, reuseIdentifier: nil)
                }
                cell.delegate = viewModel
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

private extension DashboardViewController {
    
    func setupUI() {
        view.backgroundColor = Colors.background.ui
        configureLayout()
        bindings()
        configureNavigationBar()
        registerCells()
    }
    
    func configureLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
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
        navigationItem.title = "ITMO.Abit"
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
    
    func registerCells() {
        tableView.register(
            EducationalProgrammsCell.self,
            forCellReuseIdentifier: String(describing: EducationalProgrammsCell.self)
        )
        tableView.register(
            QuestionnaireCell.self,
            forCellReuseIdentifier: String(describing: QuestionnaireCell.self)
        )
    }
}
