//
//  SegmentCell.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

import SnapKit
import UIKit

protocol SegmentCellDelegate: AnyObject {
    func segmentControlSwitched(_ index: Int)
}

final class SegmentCell: UICollectionViewCell {
    
    // MARK: Internal properties

    weak var delegate: SegmentCellDelegate?
    
    // MARK: Private properties
    
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: [
            "Мои",
            "Все"
        ])
        segmentControl.setTitleTextAttributes([
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            .foregroundColor: Colors.dark.ui
        ], for: .normal)
        segmentControl.setTitleTextAttributes([
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            .foregroundColor: Colors.white.ui
        ], for: .selected)
        segmentControl.addTarget(self, action: #selector(segmentTapped), for: .valueChanged)
        segmentControl.selectedSegmentTintColor = Colors.dark.ui
        return segmentControl
    }()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Internal methods

extension SegmentCell {
    
    func bind(model: SegmentCellModel) {
        segmentControl.selectedSegmentIndex = model.selectedIndex
    }
}

// MARK: Action

@objc
private extension SegmentCell {
    
    func segmentTapped() {
        delegate?.segmentControlSwitched(segmentControl.selectedSegmentIndex)
    }
}

// MARK: Private methods

private extension SegmentCell {
    
    func setupUI() {
        contentView.backgroundColor = Colors.background.ui
        configureLayout()
    }
    
    func configureLayout() {
        contentView.addSubview(segmentControl)
        
        segmentControl.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
                .inset(AppConstants.compactSpacing)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(36)
        }
    }
}
