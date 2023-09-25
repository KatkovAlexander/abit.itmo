//
//  RatingProgramDetailViewController.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine
import SnapKit
import UIKit

final class RatingProgramDetailViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let showMeButtonSize = CGSize(width: 150, height: 40)
    }
    
    // MARK: Private properties
    
    private let viewModel: RatingProgramDetailViewModel
    private var cancellableSet = Set<AnyCancellable>()
    private var models = [RatingProgramDetailCellType]()
    
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
    
    private lazy var showMeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Показать меня", for: .normal)
        button.backgroundColor = UIColor.makeGradient(
            colors: [Colors.skyBlue.cg, Colors.roseGold.cg],
            size: Constants.showMeButtonSize
        )
//        button.isHidden = true
        button.setTitleColor(Colors.dark.ui, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 10
        button.addTarget(
            self,
            action: #selector(didTapShowMe),
            for: .touchUpInside
        )
        button.layer.applyShadow()
        return button
    }()
    
    // MARK: Initialization
    
    init(viewModel: RatingProgramDetailViewModel) {
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

extension RatingProgramDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.row] {
            case .programInfo(let model):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: RatingProgramDetailInfoCell.self),
                    for: indexPath
                ) as? RatingProgramDetailInfoCell else {
                    return UITableViewCell(style: .default, reuseIdentifier: nil)
                }
                cell.bind(model: model)
                return cell
            case .enrollee(let model):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: RatingProgramEnrolleeCell.self),
                    for: indexPath
                ) as? RatingProgramEnrolleeCell else {
                    return UITableViewCell(style: .default, reuseIdentifier: nil)
                }
                cell.bind(model: model)
                cell.delegate = viewModel
                return cell
        }
    }
}

// MARK: Action

@objc
private extension RatingProgramDetailViewController {
    
    func didTapShowMe() {
        guard let index = models.firstIndex(where: { type in
            switch type {
                case .programInfo:
                    return false
                case .enrollee(let model):
                    return model.isCurrentUser
            }
        }) else { return }
        tableView.scrollToRow(
            at: IndexPath(row: index, section: 0),
            at: .top,
            animated: true
        )
    }
}

// MARK: Private extension

private extension RatingProgramDetailViewController {
    
    func setupUI() {
        configureNavigationBar()
        configureLayout()
        bindings()
        registerCells()
    }
    
    func configureLayout() {
        view.addSubview(tableView)
        view.addSubview(showMeButton)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        showMeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppConstants.normalSpacing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                .inset(50)
            make.size.equalTo(Constants.showMeButtonSize)
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
        viewModel.$isHiddenShowMeButton
            .sink { [weak self] isHiddenShowMeButton in
                self?.showMeButton.isHidden = isHiddenShowMeButton
            }
            .store(in: &cancellableSet)
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Рейтинг"
        navigationController?.navigationBar.prefersLargeTitles = false

        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(
                ofSize: 20, weight: .semibold
            ),
            .foregroundColor: Colors.white.ui
        ]
        appearance.backgroundColor = Colors.dark.ui
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func registerCells() {
        tableView.register(
            RatingProgramDetailInfoCell.self,
            forCellReuseIdentifier: String(describing: RatingProgramDetailInfoCell.self)
        )
        tableView.register(
            RatingProgramEnrolleeCell.self,
            forCellReuseIdentifier: String(describing: RatingProgramEnrolleeCell.self)
        )
    }
}
