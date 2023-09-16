//
//  CustomTextField.swift
//  abit.itmo
//
//  Created by Александр Катков on 16.09.2023.
//

import SnapKit
import UIKit

protocol CustomTextFieldDelegate: AnyObject {
    func textFieldDidBeginEditing(_ key: String?, _ textField: UITextField)
    func textFieldDidEndEditing(_ key: String?, _ textField: UITextField)
    func textFieldDidChangeSelection(_ key: String?, _ textField: UITextField)
}

extension CustomTextFieldDelegate {
    func textFieldDidBeginEditing(_ key: String?, _ textField: UITextField) { }
    func textFieldDidEndEditing(_ key: String?, _ textField: UITextField) { }
    func textFieldDidChangeSelection(_ key: String?, _ textField: UITextField) { }
}

enum TextFieldType {
    case standard
    case password
    case email
}

/// Компонент - текстовое поле
final class CustomTextField: UITextField {
    
    // MARK: Constants
    
    enum Constants {
        static let textPaddingWithButton = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 54)
        static let textPaddingWithoutButton = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        static let textFieldHeight = 48
        static let cornerRadius: CGFloat = 6
        static let borderWidth = 1.0
        static let rightButtonSize = 28
        static let passwordHiddenImage = UIImage(systemName: "eye")
        static let passwordNotHiddenImage = UIImage(systemName: "eye.slash")
    }
    
    // MARK: Public Properties
    
    weak var customDelegate: CustomTextFieldDelegate?
        
    override var placeholder: String? {
        didSet {
            setupPlaceholder()
        }
    }
    
    var type: TextFieldType = .standard {
        didSet {
            setupTextFieldWithType()
        }
    }
    
    var key: String?
    
    // MARK: Private Properties
    
    private var textPadding = Constants.textPaddingWithButton
    
    private var hidePassword = true {
        didSet {
            isSecureTextEntry = hidePassword
            setupRightButton()
        }
    }
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(secureTextField), for: .touchUpInside)
        return button
    }()
    
    // MARK: Initialization
    
    public init() {
        super.init(frame: .zero)
        delegate = self
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UITextFieldDelegate

extension CustomTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.isSelected = true
        setupRightButton()
        setupBorderColor()
        customDelegate?.textFieldDidBeginEditing(key, textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.isSelected = false
        setupRightButton()
        setupBorderColor()
        customDelegate?.textFieldDidEndEditing(key, textField)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        customDelegate?.textFieldDidChangeSelection(key, textField)
    }
}

// MARK: Internal Methods

extension CustomTextField {

    func showError(_ show: Bool) {
        if show {
            layer.borderColor = Colors.red.cg
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Constants.textPaddingWithButton)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Constants.textPaddingWithButton)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Constants.textPaddingWithButton)
    }
}

// MARK: Action

@objc
private extension CustomTextField {
    
    func secureTextField() {
        if type == .password {
            hidePassword = !hidePassword
        }
    }
}

// MARK: Private extension

private extension CustomTextField {
    
    func setupUI() {
        autocorrectionType = .no
        textColor = Colors.font.ui
        backgroundColor = Colors.white.ui
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        addDoneButton()
        setupBorderColor()
        configureLayout()
    }
    
    func configureLayout() {
        addSubview(rightButton)
        
        snp.makeConstraints { make in
            make.height.equalTo(Constants.textFieldHeight)
        }
        
        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(AppConstants.normalSpacing)
            make.size.equalTo(Constants.rightButtonSize)
        }
    }
        
    func setupTextFieldWithType() {
        isSecureTextEntry = type == .password
        setupRightButton()
        setupKeyboard()
        textPadding = isSecureTextEntry ? Constants.textPaddingWithButton : Constants.textPaddingWithoutButton
    }
    
    func setupBorderColor() {
        layer.borderColor = isSelected
        ? Colors.darkBlue.cg
        : Colors.lightGray.cg
    }
    
    func setupRightButton() {
        if type == .password {
            let image = hidePassword
            ? Constants.passwordHiddenImage
            : Constants.passwordNotHiddenImage
            rightButton.setImage(
                image,
                for: .normal
            )
            rightButton.tintColor = isSelected ? Colors.font.ui : Colors.lightGray.ui
        }
    }
    
    func setupKeyboard() {
        switch type {
            case .email:
                keyboardType = .emailAddress
            case .standard, .password:
                keyboardType = .default
        }
        
        switch type {
            case .standard:
                autocapitalizationType = .sentences
            case .password, .email:
                autocapitalizationType = .none
        }
    }
    
    func setupPlaceholder() {
        guard let placeholder = placeholder else {
            return
        }
         
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: Colors.lightGray.ui,
                .font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ]
        )
    }
}
