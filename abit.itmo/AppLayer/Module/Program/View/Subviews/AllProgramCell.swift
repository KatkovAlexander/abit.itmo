//
//  AllProgramCell.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

import SnapKit
import UIKit

protocol AllProgramCellDelegate: AnyObject {
    func didSelectSubprogram(programId: String, subprogramId: String)
    func didTapDetail(id: String)
}

final class AllProgramCell: UICollectionViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        static let selectButtonSize = CGSize(width: 134, height: 32)
    }
    
    // MARK: Internal properties
    
    weak var delegate: AllProgramCellDelegate?

    // MARK: Private properties
    
    private var id: String?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white.ui
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var programNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.dark.ui
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var subprogramsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = AppConstants.normalSpacing
        return stackView
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

extension AllProgramCell {
    
    func bind(model: AllProgramCellModel) {
        id = model.id
        programNameLabel.text = model.programName
        subprogramsStackView.subviews.forEach({ $0.removeFromSuperview() })
        for subprogram in model.subprograms {
            let subprogramView = SubprogramView()
            subprogramView.bind(model: subprogram)
            subprogramView.delegate = self
            subprogramsStackView.addArrangedSubview(subprogramView)
        }
    }
}

// MARK: SubprogramViewDelegate

extension AllProgramCell: SubprogramViewDelegate {

    func didSelectSubprogram(subprogramId: String) {
        guard let id = id else { return }
        delegate?.didSelectSubprogram(programId: id, subprogramId: subprogramId)
    }
}

// MARK: Action

@objc
private extension AllProgramCell {
    
    func didTapDetails() {
        guard let id = id else { return }
        delegate?.didTapDetail(id: id)
    }
}

// MARK: Private methods

private extension AllProgramCell {
    
    func setupUI() {
        contentView.backgroundColor = .clear
        configureLayout()
    }
    
    func configureLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(programNameLabel)
        containerView.addSubview(subprogramsStackView)
        containerView.addSubview(detailsButton)
        
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
                .inset(AppConstants.compactSpacing)
            make.horizontalEdges.equalToSuperview()
        }
               
        programNameLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(AppConstants.normalSpacing)
        }
        
        subprogramsStackView.snp.makeConstraints { make in
            make.top.equalTo(programNameLabel.snp.bottom).offset(AppConstants.normalSpacing)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.normalSpacing)
        }
        
        detailsButton.snp.makeConstraints { make in
            make.top.equalTo(subprogramsStackView.snp.bottom).offset(AppConstants.normalSpacing)
            make.leading.bottom.equalToSuperview().inset(AppConstants.normalSpacing)
            make.size.equalTo(Constants.selectButtonSize)
        }
    }
}
