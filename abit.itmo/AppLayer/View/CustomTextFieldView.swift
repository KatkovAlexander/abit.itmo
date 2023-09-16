//
//  CustomTextFieldView.swift
//  abit.itmo
//
//  Created by Александр Катков on 16.09.2023.
//

import SnapKit
import UIKit

protocol CustomTextFieldViewDelegate: AnyObject {
    func textFieldDidBeginEditing(_ key: String?, _ textField: UITextField)
    func textFieldDidEndEditing(_ key: String?, _ textField: UITextField)
    func textFieldDidChangeSelection(_ key: String?, _ textField: UITextField)
}

extension CustomTextFieldViewDelegate {
    func textFieldDidBeginEditing(_ key: String?, _ textField: UITextField) { }
    func textFieldDidEndEditing(_ key: String?, _ textField: UITextField) { }
    func textFieldDidChangeSelection(_ key: String?, _ textField: UITextField) { }
}

final class CustomTextFieldView: UIView {
        
    // MARK: Internal properties
    
    weak var delegate: CustomTextFieldViewDelegate?

    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var type: TextFieldType = .standard {
        didSet {
            textField.type = type
        }
    }
    
    var key: String? {
        didSet {
            textField.key = key
        }
    }
    
    // MARK: Private properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = AppConstants.compactSpacing
        return stackView
    }()
    
    private lazy var textField: CustomTextField = {
        let textField = CustomTextField()
        textField.customDelegate = self
        return textField
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textAlignment = .left
        label.textColor = Colors.red.ui
        label.font = .systemFont(ofSize: 14, weight: .regular)
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

extension CustomTextFieldView: CustomTextFieldDelegate {

    func textFieldDidBeginEditing(_ key: String?, _ textField: UITextField) {
        delegate?.textFieldDidBeginEditing(key, textField)
    }
    
    func textFieldDidEndEditing(_ key: String?, _ textField: UITextField) {
        delegate?.textFieldDidEndEditing(key, textField)
    }
    
    func textFieldDidChangeSelection(_ key: String?, _ textField: UITextField) {
        delegate?.textFieldDidChangeSelection(key, textField)
    }
}

// MARK: Internal methods

extension CustomTextFieldView {
    
    func showError(_ error: String?) {
        textField.showError(error != nil)
        errorLabel.isHidden = error == nil
        errorLabel.text = error
    }
}

// MARK: Private methods

private extension CustomTextFieldView {
    
    func setupUI() {
        configureLayout()
    }
    
    func configureLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(errorLabel)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
