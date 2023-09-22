//
//  RatingProgramEnrolleeCell.swift
//  abit.itmo
//
//  Created by Александр Катков on 23.09.2023.
//

import SnapKit
import UIKit

protocol RatingProgramEnrolleeCellDelegate: AnyObject {
    
    func didTapEnrolleeCell(snils: String)
}

final class RatingProgramEnrolleeCell: UITableViewCell {
        
    // MARK: Internal properties
    
    weak var delegate: RatingProgramEnrolleeCellDelegate?

    // MARK: Private properties
        
    private var snils: String?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.dark.ui
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = AppConstants.compactSpacing
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var contestLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var diplomaAverageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var originalDiplomaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var totalScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var iaScoresLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var examScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var admissionStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
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

// MARK: Internal properties

extension RatingProgramEnrolleeCell {
    
    func bind(model: RatingProgramEnrolleeCellModel) {
        snils = model.snils
        configureStackView(model.isOpened, model.isCurrentUser)
        
        titleLabel.text = "\(model.position). \(model.snils)"
        contestLabel.attributedText = configureAttributedText("Вид испытания\n", model.contest)
        priorityLabel.attributedText = configureAttributedText("Приоритет: ", String(model.priority))
        diplomaAverageLabel.attributedText = configureAttributedText(
            "Средний балл: ", model.diplomaAverage.formatted
        )
        originalDiplomaLabel.attributedText = configureAttributedText(
            "Оригиналы документов: ", model.isSendOriginal ? "Да" : "Нет")
        totalScoreLabel.attributedText = configureAttributedText(
            "Балл ВИ+ИД: ", model.totalScore.formatted
        )
        iaScoresLabel.attributedText = configureAttributedText(
            "ИД: ", String(model.iaScores))
        examScoreLabel.attributedText = configureAttributedText(
            "Балл ВИ: ", model.examScore.formatted
        )
        admissionStatusLabel.attributedText = configureAttributedText(
            "Статус поступления: ",
            model.status?.rawValue ?? "Не рекомендован"
        )
        chevronImageView.image = model.isOpened
        ? UIImage(systemName: "chevron.compact.up")
        : UIImage(systemName: "chevron.compact.down")
        
        configureBackgroundColor(model.isCurrentUser, model.status, model.isSendOriginal)
    }
}

// MARK: Action

@objc
private extension RatingProgramEnrolleeCell {
    
    func didTap() {
        guard let snils = snils else { return }
        delegate?.didTapEnrolleeCell(snils: snils)
    }
}

// MARK: Private extension

private extension RatingProgramEnrolleeCell {
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(didTap)
        ))
        configureLayout()
    }
    
    func configureLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(chevronImageView)
        containerView.addSubview(stackView)
        
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(AppConstants.compactSpacing)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.normalSpacing)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(AppConstants.normalSpacing)
            make.size.equalTo(28)
        }
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(AppConstants.normalSpacing)
            make.leading.equalToSuperview().inset(AppConstants.normalSpacing)
            make.trailing.equalTo(chevronImageView.snp.leading).inset(-AppConstants.bigSpacing)
        }
    }
    
    func configureAttributedText(_ text: String, _ boldText: String) -> NSAttributedString {
        let attrText = NSMutableAttributedString(
            string: text + boldText,
            attributes: [
                .foregroundColor: Colors.dark.ui,
                .font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ]
        )
        
        attrText.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: 16, weight: .bold),
            range: NSRange.init(
                location: attrText.length - boldText.count,
                length: boldText.count
            )
        )
        
        return attrText
    }
    
    func configureStackView(_ isOpened: Bool, _ isCurrentUser: Bool) {
        stackView.subviews.forEach {$0.removeFromSuperview()}
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contestLabel)
        if isOpened {
            stackView.addArrangedSubview(priorityLabel)
            stackView.addArrangedSubview(diplomaAverageLabel)
            stackView.addArrangedSubview(originalDiplomaLabel)
            stackView.addArrangedSubview(totalScoreLabel)
            stackView.addArrangedSubview(iaScoresLabel)
            stackView.addArrangedSubview(examScoreLabel)
            if isCurrentUser {
                stackView.addArrangedSubview(admissionStatusLabel)
            }
        }
    }
    
    func configureBackgroundColor(
        _ isCurrentUser: Bool,
        _ status: ProgramStatus?,
        _ isSendOriginal: Bool
    ) {
        containerView.layer.borderWidth = 0
        if isCurrentUser {
            if containerView.bounds.width == 0 || containerView.bounds.height == 0 {
                containerView.backgroundColor = Colors.skyBlue.ui
            } else {
                containerView.backgroundColor = UIColor.makeGradient(
                    colors: [Colors.skyBlue.cg, Colors.roseGold.cg],
                    size: CGSize(width: containerView.bounds.width, height: containerView.bounds.height + 1000)
                )
            }
        } else if status == .inOrder && isSendOriginal {
            if containerView.bounds.width == 0 || containerView.bounds.height == 0 {
                containerView.backgroundColor = Colors.cianBlue.ui
            } else {
                containerView.backgroundColor = UIColor.makeGradient(
                    colors: [Colors.cianBlue.cg, Colors.cianGreen.cg],
                    size: CGSize(width: containerView.bounds.width, height: containerView.bounds.height + 1000)
                )
            }
        } else if status == .inOrder && !isSendOriginal {
            containerView.backgroundColor = Colors.yellow.ui
        } else if status == .inAnotherOrder {
            containerView.backgroundColor = Colors.cardGray.ui
        } else if status == nil {
            containerView.backgroundColor = Colors.background.ui
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = Colors.subtitle.cg
        }
    }
}
