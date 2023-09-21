//
//  RatingViewController.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine
import SnapKit
import UIKit

final class RatingViewController: UIViewController {
    
    // MARK: Internal properties

    var viewModel: RatingViewModel!
    
    // MARK: Private properties
    
    private var sections = [RatingSectionModel]()
    private var dataSource: UICollectionViewDiffableDataSource<RatingSectionModel, AnyHashable>?
    private var cancellableSet = Set<AnyCancellable>()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: generateLayout()
        )
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = Colors.background.ui
        return collectionView
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: UICollectionViewDelegate

extension RatingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if sections[indexPath.section].type == .myPrograms,
            let model = sections[indexPath.section].items as? [RatingProgramCellModel]
        {
            viewModel.didTapMyProgram(id: model[indexPath.item].id)
        } else if sections[indexPath.section].type == .myPrograms,
                  let model = sections[indexPath.section].items as? [RatingProgramCellModel] {
            viewModel.didTapPublicProgram(id: model[indexPath.item].id)
        }
    }
}

// MARK: Private methods

private extension RatingViewController {
    
    func setupUI() {
        view.backgroundColor = Colors.background.ui
        configureLayout()
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
        navigationItem.title = "Рейтинги"
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
            RatingProgramCell.self,
            forCellWithReuseIdentifier: String(describing: RatingProgramCell.self)
        )
    }
    
    func bindings() {
        viewModel.$collectionSections
            .sink { [weak self] collectionSections in
                self?.sections = collectionSections
                
                var snapshot = NSDiffableDataSourceSnapshot<RatingSectionModel, AnyHashable>()
                snapshot.appendSections(collectionSections)
                
                for section in collectionSections {
                    snapshot.appendItems(section.items, toSection: section)
                }
                
                self?.dataSource?.apply(snapshot, animatingDifferences: false)
            }
            .store(in: &cancellableSet)
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<RatingSectionModel, AnyHashable>(
            collectionView: collectionView,
            cellProvider: { (_, indexPath, data) -> UICollectionViewCell? in
                switch self.sections[indexPath.section].type {
                    case .segmentSection:
                        return self.configureSegmentCell(indexPath, data)
                    case .myPrograms, .allPrograms:
                        return self.configureProgramCell(indexPath, data)
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
    
    func configureProgramCell(
        _ indexPath: IndexPath,
        _ data: AnyHashable
    ) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: RatingProgramCell.self),
            for: indexPath
        ) as? RatingProgramCell,
              let data = data as? RatingProgramCellModel
        else {
            return UICollectionViewCell()
        }
        cell.bind(model: data)
        return cell
    }
}

