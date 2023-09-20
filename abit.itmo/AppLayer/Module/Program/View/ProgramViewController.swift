//
//  ProgramViewController.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine
import SnapKit
import UIKit

final class ProgramViewController: UIViewController {
    
    // MARK: Private properties
    
    private var sections = [ProgramSectionModel]()
    private var dataSource: UICollectionViewDiffableDataSource<ProgramSectionModel, AnyHashable>?
    private let viewModel: ProgramViewModel
    private var cancellableSet = Set<AnyCancellable>()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: generateLayout()
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = Colors.background.ui
        return collectionView
    }()
    
    // MARK: Initialization
    
    init(viewModel: ProgramViewModel) {
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

private extension ProgramViewController {
    
    func setupUI() {
        view.backgroundColor = Colors.background.ui
        configureLayout()
        configureNavigationBar()
        registerCells()
        bindings()
        createDataSource()
    }
    
    func configureLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Программы"
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
    
    func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            return OneItemInSectionLayout().buildSectionLayout()
        }
    }
    
    func registerCells() {
        collectionView.register(
            SegmentCell.self,
            forCellWithReuseIdentifier: String(describing: SegmentCell.self)
        )
        collectionView.register(
            DescriptionCell.self,
            forCellWithReuseIdentifier: String(describing: DescriptionCell.self)
        )
        collectionView.register(
            MyProgramCell.self,
            forCellWithReuseIdentifier: String(describing: MyProgramCell.self)
        )
        collectionView.register(
            AllProgramCell.self,
            forCellWithReuseIdentifier: String(describing: AllProgramCell.self)
        )
    }
    
    func bindings() {
        viewModel.$collectionSections
            .sink { [weak self] collectionSections in
                self?.sections = collectionSections
                
                var snapshot = NSDiffableDataSourceSnapshot<ProgramSectionModel, AnyHashable>()
                snapshot.appendSections(collectionSections)
                
                for section in collectionSections {
                    snapshot.appendItems(section.items, toSection: section)
                }
                
                self?.dataSource?.apply(snapshot, animatingDifferences: false)
            }
            .store(in: &cancellableSet)
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ProgramSectionModel, AnyHashable>(
            collectionView: collectionView,
            cellProvider: { (_, indexPath, data) -> UICollectionViewCell? in
                switch self.sections[indexPath.section].type {
                    case .segmentSection:
                        return self.configureSegmentCell(indexPath, data)
                    case .descriptionSection:
                        return self.configureDescriptionCell(indexPath)
                    case .myProgrammsSection:
                        return self.configureMyProgramCell(indexPath, data)
                    case .allProgrammsSection:
                        return self.configureAllProgramCell(indexPath, data)
                }
            }
        )
    }
    
    func configureSegmentCell(
        _ indexPath: IndexPath,
        _ data: AnyHashable
    ) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: SegmentCell.self),
            for: indexPath
        ) as? SegmentCell,
              let data = data as? SegmentCellModel
        else {
            return UICollectionViewCell()
        }
        cell.bind(model: data)
        cell.delegate = viewModel
        return cell
    }
    
    func configureDescriptionCell(
        _ indexPath: IndexPath
    ) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: DescriptionCell.self),
            for: indexPath
        ) as? DescriptionCell
        else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func configureMyProgramCell(
        _ indexPath: IndexPath,
        _ data: AnyHashable
    ) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: MyProgramCell.self),
            for: indexPath
        ) as? MyProgramCell,
              let data = data as? MyProgramCellModel
        else {
            return UICollectionViewCell()
        }
        cell.bind(index: indexPath.row + 1, model: data)
//        cell.delegate = viewModel
        return cell
    }
    
    func configureAllProgramCell(
        _ indexPath: IndexPath,
        _ data: AnyHashable
    ) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: AllProgramCell.self),
            for: indexPath
        ) as? AllProgramCell,
              let data = data as? AllProgramCellModel
        else {
            return UICollectionViewCell()
        }
        cell.bind(model: data)
//        cell.delegate = viewModel
        return cell
    }
}
