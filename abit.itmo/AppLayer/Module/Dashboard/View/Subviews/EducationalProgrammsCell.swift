//
//  EducationalProgrammsCell.swift
//  abit.itmo
//
//  Created by Александр Катков on 18.09.2023.
//

import SnapKit
import UIKit

final class EducationalProgrammsCell: UITableViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        static let titleText = "Образовательные\nпрограммы"
        static let selectText = "Выбрать"
        static let selectButtonSize = CGSize(width: 134, height: 32)
    }
    
    // MARK: Private properties
        
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "EducationalProgrammsBackground")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.white.ui
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = .zero
        label.text = Constants.titleText
        return label
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.selectText, for: .normal)
        button.backgroundColor = UIColor.makeGradient(
            colors: [Colors.skyBlue.cg, Colors.roseGold.cg],
            size: Constants.selectButtonSize
        )
        button.setTitleColor(Colors.dark.ui, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private extensio

private extension EducationalProgrammsCell {
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        configureLayout()
    }
    
    func configureLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(backgroundImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(selectButton)
        
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(AppConstants.compactSpacing)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.normalSpacing)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
                .inset(AppConstants.normalSpacing)
        }
        
        selectButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
                .offset(AppConstants.bigSpacing)
            make.leading.bottom.equalToSuperview()
                .inset(AppConstants.normalSpacing)
            make.size.equalTo(Constants.selectButtonSize)
        }
    }
}
