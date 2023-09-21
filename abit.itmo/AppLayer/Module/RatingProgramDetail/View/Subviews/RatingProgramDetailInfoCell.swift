//
//  RatingProgramDetailInfoCell.swift
//  abit.itmo
//
//  Created by Александр Катков on 22.09.2023.
//

import SnapKit
import UIKit

final class RatingProgramDetailInfoCell: UITableViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        static let numberOfPlacesText = "Количество мест: "
    }
    
    // MARK: Internal properties
    
    weak var delegate: EducationalProgrammsCellDelegate?

    // MARK: Private properties
        
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = AppConstants.normalSpacing
        return stackView
    }()
    
    private lazy var programNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.subtitle.ui
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var subprogramNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.subtitle.ui
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var numberOfPlacesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var enrolleePlaceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.subtitle.ui
        label.font = .systemFont(ofSize: 22, weight: .bold)
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

extension RatingProgramDetailInfoCell {
    
    func bind(model: RatingProgramDetailInfoCellModel) {
        programNameLabel.text = model.programName
        subprogramNameLabel.text = model.subprogramName
        numberOfPlacesLabel.attributedText = configureNumberOfPlaces(model.numberOfPlaces)
        enrolleePlaceLabel.removeFromSuperview()
        if let enrolleePlace = model.enrolleePlace {
            stackView.addArrangedSubview(enrolleePlaceLabel)
            enrolleePlaceLabel.text = "Ваше место: \(enrolleePlace) из \(model.numberOfPlaces)"
        }
    }
}

// MARK: Private extension

private extension RatingProgramDetailInfoCell {
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        configureLayout()
    }
    
    func configureLayout() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(programNameLabel)
        stackView.addArrangedSubview(subprogramNameLabel)
        stackView.addArrangedSubview(numberOfPlacesLabel)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(AppConstants.normalSpacing)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.normalSpacing)
            make.bottom.equalToSuperview().inset(AppConstants.compactSpacing)
        }
    }
    
    func configureNumberOfPlaces(_ numberOfPlaces: Int) -> NSAttributedString {
        let attrText = NSMutableAttributedString(
            string: Constants.numberOfPlacesText + String(numberOfPlaces),
            attributes: [
                .foregroundColor: Colors.font.ui,
                .font: UIFont.systemFont(ofSize: 18, weight: .regular)
            ]
        )
        
        attrText.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: 18, weight: .semibold),
            range: NSRange.init(
                location: attrText.length - String(numberOfPlaces).count,
                length: String(numberOfPlaces).count
            )
        )
        
        return attrText
    }
}

