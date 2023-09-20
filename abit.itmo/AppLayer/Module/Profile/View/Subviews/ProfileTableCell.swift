//
//  ProfileTableCell.swift
//  abit.itmo
//
//  Created by Александр Катков on 20.09.2023.
//

import SnapKit
import UIKit

final class ProfileTableCell: UITableViewCell {
    
    // MARK: Internal properties
    
    weak var delegate: EducationalProgrammsCellDelegate?

    // MARK: Private properties
        
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = Colors.white.ui
        return view
    }()
    
    private lazy var avatarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.dark.ui
        return view
    }()
    
    private lazy var avatarLabel: UILabel = {
        let label = UILabel()
        label.text = "A"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = UIColor.makeGradient(
            colors: [Colors.skyBlue.cg, Colors.roseGold.cg],
            size: CGSize(width: 24, height: 43)
        )
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Colors.dark.ui
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = .zero
        label.text = "Вахренев \nАким Николаевич"
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
    
    // MARK: Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarBackgroundView.layer.cornerRadius = avatarBackgroundView.frame.height / 2
    }

}

// MARK: Private extensio

private extension ProfileTableCell {
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        configureLayout()
    }
    
    func configureLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(avatarBackgroundView)
        avatarBackgroundView.addSubview(avatarLabel)
        containerView.addSubview(nameLabel)
        
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(AppConstants.compactSpacing)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.normalSpacing)
        }
        
        avatarBackgroundView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(AppConstants.normalSpacing)
            make.leading.equalToSuperview().inset(AppConstants.normalSpacing)
            make.size.equalTo(75)
        }
        
        avatarLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(avatarBackgroundView.snp.trailing)
                .offset(AppConstants.normalSpacing)
            make.trailing.equalToSuperview().inset(AppConstants.normalSpacing)
            
        }
    }
}
