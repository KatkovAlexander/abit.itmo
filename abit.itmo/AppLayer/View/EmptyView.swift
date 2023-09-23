//
//  EmptyView.swift
//  abit.itmo
//
//  Created by Александр Катков on 24.09.2023.
//

import SnapKit
import UIKit

protocol EmptyViewDelegate: AnyObject {
    func didTapBottomButton()
}

final class EmptyView: UIView {
        
    // MARK: Internal properties
    
    weak var delegate: EmptyViewDelegate?

    // MARK: Private properties
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "empty_view")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.subtitle.ui
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = .zero
        label.text = "Программы не выбраны"
        return label
    }()
    
    private lazy var bottomButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = Colors.white.ui
        configuration.baseBackgroundColor = Colors.dark.ui
        configuration.title = "Добавить программы"
        configuration.titleAlignment = .center
        configuration.image = UIImage(systemName: "plus")
        configuration.imagePadding = 8
        configuration.imagePlacement = .leading
        configuration.cornerStyle = .medium
        let button = UIButton(configuration: configuration)
        button.addTarget(
            self,
            action: #selector(didTapBottomButton),
            for: .touchUpInside
        )
        return button
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

// MARK: Action

@objc
private extension EmptyView {
    
    func didTapBottomButton() {
        delegate?.didTapBottomButton()
    }
}

// MARK: Private extension

private extension EmptyView {
    
    func setupUI() {
        backgroundColor = .clear
        configureLayout()
    }
    
    func configureLayout() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(bottomButton)
        
        imageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 243, height: 267))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(AppConstants.compactSpacing)
            make.horizontalEdges.equalToSuperview()
        }
        
        bottomButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppConstants.bigSpacing)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
    }
}
