//
//  SubprogramView.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

import SnapKit
import UIKit

protocol SubprogramViewDelegate: AnyObject {
    func didSelectSubprogram(id: String)
}

final class SubprogramView: UIView {
        
    // MARK: Internal properties
    
    weak var delegate: SubprogramViewDelegate?

    // MARK: Private properties
    
    private var id: String?
    
    private lazy var subprogramNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.dark.ui
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var checkboxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "checkbox")
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()
    
    private lazy var selectLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.dark.ui
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = .zero
        label.text = "Выбрать"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Internal methods

extension SubprogramView {
    
    func bind(model: SubprogramViewModel) {
        id = model.id
        subprogramNameLabel.text = model.subprogramName
        checkboxImageView.image = model.isSelected
        ? UIImage(named: "checkbox_fill")
        : UIImage(named: "checkbox")
    }
}


// MARK: Action

@objc
private extension SubprogramView {
    
    func didTap() {
        guard let id = id else { return }
        
        delegate?.didSelectSubprogram(id: id)
    }
}

// MARK: Private methods

private extension SubprogramView {
    
    func setupUI() {
        addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(didTap)
        ))
        backgroundColor = .clear
        configureLayout()
    }
    
    func configureLayout() {
        addSubview(subprogramNameLabel)
        addSubview(checkboxImageView)
        addSubview(selectLabel)
        
        subprogramNameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.greaterThanOrEqualTo(checkboxImageView.snp.height)
        }
        
        checkboxImageView.snp.makeConstraints { make in
            make.centerY.equalTo(subprogramNameLabel.snp.centerY)
            make.leading.equalTo(subprogramNameLabel.snp.trailing)
                .offset(AppConstants.normalSpacing)
            make.size.equalTo(20)
        }
        
        selectLabel.snp.makeConstraints { make in
            make.centerY.equalTo(subprogramNameLabel.snp.centerY)
            make.leading.equalTo(checkboxImageView.snp.trailing)
                .offset(AppConstants.compactSpacing)
            make.trailing.equalToSuperview()
            make.height.equalTo(checkboxImageView.snp.height)
        }
    }
}


