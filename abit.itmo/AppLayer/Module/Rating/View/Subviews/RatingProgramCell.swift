//
//  RatingProgramCell.swift
//  abit.itmo
//
//  Created by Александр Катков on 22.09.2023.
//

import SnapKit
import UIKit

final class RatingProgramCell: UICollectionViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        static let kcpText = "КЦП: "
    }
    
    // MARK: Private properties
    
    private var id: String?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white.ui
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = AppConstants.compactSpacing
        return stackView
    }()
    
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.dark.ui
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var programNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.dark.ui
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var subprogramNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.dark.ui
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = .zero
        return label
    }()
        
    private lazy var kcpImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "two_person_fill")
//        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()
    
    private lazy var kcpLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.dark.ui
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = Constants.kcpText + String(100)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.numberOfLines = 1
        return label
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

extension RatingProgramCell {
    
    func bind(model: RatingProgramCellModel) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        id = model.id
        programNameLabel.text = model.programName
        kcpLabel.attributedText = configureKcp(model.kcp)
        subprogramNameLabel.text = model.subprogramName
        if let position = model.position {
            positionLabel.text = "\(position) место"
            stackView.addArrangedSubview(positionLabel)
        }
        stackView.addArrangedSubview(programNameLabel)
        stackView.addArrangedSubview(subprogramNameLabel)
        stackView.addArrangedSubview(bottomView)
    }
}

// MARK: Private methods

private extension RatingProgramCell {
    
    func setupUI() {
        contentView.backgroundColor = .clear
        configureLayout()
    }
    
    func configureLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        containerView.addSubview(bottomView)
        bottomView.addSubview(kcpImageView)
        bottomView.addSubview(kcpLabel)
//        bottomView.addSubview(subprogramNameLabel)
        
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
                .inset(AppConstants.compactSpacing)
            make.horizontalEdges.equalToSuperview()
        }
               
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(AppConstants.normalSpacing)
        }
        
        kcpLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(kcpImageView.snp.trailing).offset(AppConstants.compactSpacing)
            make.trailing.equalToSuperview()
            make.height.equalTo(kcpImageView.snp.height)
        }
        
        kcpImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(28)
        }
        
//        subprogramNameLabel.snp.makeConstraints { make in
//            make.verticalEdges.leading.equalToSuperview()
//            make.height.greaterThanOrEqualTo(kcpImageView.snp.height)
//        }
    }
    
    func configureKcp(_ kcp: Int) -> NSAttributedString {
        let attrText = NSMutableAttributedString(
            string: Constants.kcpText + String(kcp),
            attributes: [
                .foregroundColor: Colors.font.ui,
                .font: UIFont.systemFont(ofSize: 18, weight: .regular)
            ]
        )
        
        attrText.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: 18, weight: .semibold),
            range: NSRange.init(
                location: attrText.length - String(kcp).count,
                length: String(kcp).count
            )
        )
        
        return attrText
    }
}
