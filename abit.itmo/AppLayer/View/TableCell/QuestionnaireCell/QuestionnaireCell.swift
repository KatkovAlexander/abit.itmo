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
        static let fillDocumentsText = "Заполните анкету для подачи заявления"
        static let sendDocumentsText = "Ваша анкета готова для отправки на модерацию"
        static let onModerationText = "Анкету нельзя изменить пока она на модерации"
        static let failText = "Ваша анкета не прошла модерацию. Откройте, чтобы узнать подробности"
        static let successText = "Для изменения данных можно заполнить специальную форму"
        static let docImageViewSize = CGSize(width: 93, height: 93)
        static let sentButtonText = "Отправить"
        static let sentButtonSize = CGSize(width: 130, height: 32)
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
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = .zero
        label.text = Constants.titleText
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.dark.ui
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.darkGray.ui
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = .zero
        label.text = "0/3 заполнено"
        return label
    }()
    
    private lazy var sentButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var sentButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.sentButtonText, for: .normal)
        button.backgroundColor = UIColor.makeGradient(
            colors: [Colors.skyBlue.cg, Colors.roseGold.cg],
            size: Constants.sentButtonSize
        )
        button.setTitleColor(Colors.dark.ui, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 10
        button.addTarget(
            self,
            action: #selector(didTapSent),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var statusView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.darkGray.ui
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = .zero
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

// MARK: Internal methods

extension QuestionnaireCell {
    
    func bind(status: QuestionnaireCellStatus) {
        removeBottomSubviews()
        
        switch status {
            case .fillDocuments(let filled, let required):
                subtitleLabel.text = Constants.fillDocumentsText
                counterLabel.text = "\(filled)/\(required) заполнено"
                stackView.addArrangedSubview(counterLabel)
            case .sendDocuments:
                subtitleLabel.text = Constants.sendDocumentsText
                stackView.addArrangedSubview(sentButtonView)
            case .onModeration:
                subtitleLabel.text = Constants.onModerationText
                statusImageView.image = UIImage(systemName: "clock.fill")
                statusImageView.tintColor = Colors.gold.ui
                statusLabel.textColor = Colors.gold.ui
                statusLabel.text = "На модерации"
                stackView.addArrangedSubview(statusView)
            case .fail:
                subtitleLabel.text = Constants.failText
                statusImageView.image = UIImage(systemName: "xmark.circle.fill")
                statusImageView.tintColor = Colors.red.ui
                statusLabel.textColor = Colors.red.ui
                statusLabel.text = "Модерация не пройдена"
                stackView.addArrangedSubview(statusView)
            case .success:
                subtitleLabel.text = Constants.successText
                statusImageView.image = UIImage(systemName: "face.smiling")
                statusImageView.tintColor = Colors.green.ui
                statusLabel.textColor = Colors.green.ui
                statusLabel.text = "Модерация пройдена"
                stackView.addArrangedSubview(statusView)
        }
    }
}

// MARK: Action

@objc
private extension QuestionnaireCell {
    
    func didTapSent() {
        
    }
}

// MARK: Private methods

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
        sentButtonView.addSubview(sentButton)
        statusView.addSubview(statusImageView)
        statusView.addSubview(statusLabel)
        
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
        
        sentButton.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
//            make.trailing.greaterThanOrEqualToSuperview()
            make.size.equalTo(Constants.sentButtonSize)
        }
        
        statusImageView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview()
            make.leading.equalTo(statusImageView.snp.trailing)
                .offset(AppConstants.compactSpacing)
            make.height.greaterThanOrEqualTo(statusImageView.snp.height)
        }
    }
    
    func removeBottomSubviews() {
        counterLabel.removeFromSuperview()
        sentButtonView.removeFromSuperview()
        statusView.removeFromSuperview()
    }
}
