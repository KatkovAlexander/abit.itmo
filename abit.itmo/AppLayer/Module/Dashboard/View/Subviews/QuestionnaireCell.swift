//
//  QuestionnaireCell.swift
//  abit.itmo
//
//  Created by Александр Катков on 18.09.2023.
//

import SnapKit
import UIKit

final class QuestionnaireCell: UITableViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        static let titleText = "Анкета абитуриента"
        static let subtitleText = "Заполните анкету для подачи заявления"
        static let docImageViewSize = CGSize(width: 93, height: 93)
    }
    // MARK: Private properties
        
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white.ui
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var docImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "gradienDocOnClipboard")
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = AppConstants.compactSpacing
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.dark.ui
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = .zero
        label.text = Constants.titleText
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.dark.ui
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = .zero
        label.text = Constants.subtitleText
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.darkGray.ui
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = .zero
        label.text = "0/3 заполнено"
        return label
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

private extension QuestionnaireCell {
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        configureLayout()
    }
    
    func configureLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(docImageView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(counterLabel)
        
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(AppConstants.compactSpacing)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.normalSpacing)
        }
        
        docImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
                .inset(AppConstants.bigSpacing)
            make.size.equalTo(Constants.docImageViewSize)
        }
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
                .inset(AppConstants.normalSpacing)
            make.trailing.equalTo(docImageView.snp.leading)
                .inset(-AppConstants.bigSpacing)
            make.height.greaterThanOrEqualTo(docImageView.snp.height)
        }
    }
}
