//
//  MyProgramCell.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

import SnapKit
import UIKit

protocol MyProgramCellDelegate: AnyObject {
    func didTapRemove(programId: String, subprogramId: String)
    func didTapSelect(programId: String)
}

final class MyProgramCell: UICollectionViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        static let selectButtonSize = CGSize(width: 134, height: 32)
    }
    
    // MARK: Internal properties
    
    weak var delegate: MyProgramCellDelegate?

    // MARK: Private properties
    
    private var programId: String?
    private var subprogramId: String?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white.ui
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var priorityView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.dark.ui
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white.ui
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = Colors.dark.ui
        button.addTarget(
            self,
            action: #selector(didTapRemove),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var programNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.dark.ui
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var subprogramNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.dark.ui
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var detailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.backgroundColor = UIColor.makeGradient(
            colors: [Colors.skyBlue.cg, Colors.roseGold.cg],
            size: Constants.selectButtonSize
        )
        button.setTitleColor(Colors.dark.ui, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 10
        button.addTarget(
            self,
            action: #selector(didTapDetails),
            for: .touchUpInside
        )
        return button
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

extension MyProgramCell {
    
    func bind(index: Int, model: MyProgramCellModel) {
        programId = model.id
        subprogramId = model.subprogramId
        priorityLabel.text = "Приоритет \(index)"
        programNameLabel.text = model.programName
        subprogramNameLabel.text = model.subprogramName
    }
}

// MARK: Action

@objc
private extension MyProgramCell {
    
    func didTapRemove() {
        guard let programId = programId, let subprogramId = subprogramId else {
            return
        }
        delegate?.didTapRemove(programId: programId, subprogramId: subprogramId)
    }
    
    func didTapDetails() {
        guard let programId = programId else { return }
        delegate?.didTapSelect(programId: programId)
    }
}

// MARK: Private methods

private extension MyProgramCell {
    
    func setupUI() {
        layer.cornerRadius = 20
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .clear
        configureLayout()
    }
    
    func configureLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(priorityView)
        priorityView.addSubview(priorityLabel)
        containerView.addSubview(removeButton)
        containerView.addSubview(programNameLabel)
        containerView.addSubview(subprogramNameLabel)
        containerView.addSubview(detailsButton)
        
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
                .inset(AppConstants.compactSpacing)
            make.horizontalEdges.equalToSuperview()
        }
        
        priorityView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(AppConstants.normalSpacing)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(AppConstants.compactSpacing)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.normalSpacing)
        }
        
        removeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(AppConstants.normalSpacing)
            make.size.equalTo(28)
        }
        
        programNameLabel.snp.makeConstraints { make in
            make.top.equalTo(priorityView.snp.bottom).offset(AppConstants.normalSpacing)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.normalSpacing)
        }
        
        subprogramNameLabel.snp.makeConstraints { make in
            make.top.equalTo(programNameLabel.snp.bottom).offset(AppConstants.normalSpacing)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.normalSpacing)
        }
        
        detailsButton.snp.makeConstraints { make in
            make.top.equalTo(subprogramNameLabel.snp.bottom).offset(AppConstants.normalSpacing)
            make.leading.bottom.equalToSuperview().inset(AppConstants.normalSpacing)
            make.size.equalTo(Constants.selectButtonSize)
        }
    }
}
