//
//  DescriptionCell.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

import SnapKit
import UIKit

final class DescriptionCell: UICollectionViewCell {
    
    // MARK: Private properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.subtitle.ui
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = .zero
        label.text = "Пожелание о поступлении на определенную программу определяется порядковым номером.\nСамая приоритетная - №1."
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


// MARK: Private methods

private extension DescriptionCell {
    
    func setupUI() {
        contentView.backgroundColor = .clear
        configureLayout()
    }
    
    func configureLayout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
                .inset(AppConstants.compactSpacing)
            make.horizontalEdges.equalToSuperview()
        }
    }
}
