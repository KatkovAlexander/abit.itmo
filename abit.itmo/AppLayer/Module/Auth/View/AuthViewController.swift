//
//  AuthViewController.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine
import SnapKit
import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let horizontalSpacing = 50
        static let cornerRadius: CGFloat = 6
        static let logoImage = UIImage(named: "itmo_logo")
        static let forgotPasswordButtonText = "Забыли пароль?"
        static let enterButtonText = "Вход"
        static let noAccountText = "Ещё нет учётной записи?"
        static let registerButtonText = "Регистрация"
        static let enterWithText = "Войти с помощью"
        static let buttonsStackViewSpacing: CGFloat = 36
        static let appleLogoImage = UIImage(named: "apple_logo")
        static let vkLogoImage = UIImage(named: "vk_logo")
        static let yandexLogoImage = UIImage(named: "yandex_logo")
        static let bottomButtonSize = 48
    }
    
    // MARK: Private properties
    
    private let viewModel: AuthViewModel
    private var cancellableSet = Set<AnyCancellable>()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Constants.logoImage
        return imageView
    }()
    
    private lazy var loginTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.placeholder = "Имя пользователя или E-mail"
        textField.key = "login"
        textField.type = .email
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.placeholder = "Пароль"
        textField.key = "password"
        textField.type = .password
        textField.delegate = self
        return textField
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.forgotPasswordButtonText, for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(Colors.darkBlue.ui, for: .normal)
        button.setTitleColor(Colors.lightBlue.ui, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.enterButtonText, for: .normal)
        button.backgroundColor = Colors.darkBlue.ui
        button.setTitleColor(Colors.white.ui, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(
            self,
            action: #selector(didTapEnterButton),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var noAccountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = Colors.darkGray.ui
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = Constants.noAccountText
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.registerButtonText, for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(Colors.darkBlue.ui, for: .normal)
        button.setTitleColor(Colors.lightBlue.ui, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    private lazy var enterWithLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.darkGray.ui
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = Constants.enterWithText
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.buttonsStackViewSpacing
        return stackView
    }()
    
    private lazy var signInAppleButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.appleLogoImage, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var signInVkButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.vkLogoImage, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var signInYandexButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.yandexLogoImage, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    // MARK: Initialization
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension AuthViewController: CustomTextFieldViewDelegate {

    func textFieldDidChangeSelection(_ key: String?, _ textField: UITextField) {
        viewModel.textFieldDidChangeSelection(key: key, text: textField.text)
    }
    
    func textFieldDidEndEditing(_ key: String?, _ textField: UITextField) {
        viewModel.textFieldDidEndEditing(key: key, text: textField.text)
    }
}

// MARK: Action

@objc
private extension AuthViewController {
    
    func didTapView() {
        view.endEditing(true)
    }
    
    func didTapEnterButton() {
        view.endEditing(true)
        viewModel.didTapLoginButton()
    }
}

// MARK: Private extension

private extension AuthViewController {
    
    func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(didTapView)
        ))
        view.backgroundColor = Colors.white.ui
        configureLayout()
        bindings()
    }
    
    func configureLayout() {
        view.addSubview(logoImageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(enterButton)
        view.addSubview(noAccountLabel)
        view.addSubview(registerButton)
        view.addSubview(enterWithLabel)
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(signInAppleButton)
        buttonsStackView.addArrangedSubview(signInVkButton)
        buttonsStackView.addArrangedSubview(signInYandexButton)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(118)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(64)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalSpacing)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalSpacing)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom)
                .offset(AppConstants.compactSpacing)
            make.leading.equalTo(passwordTextField.snp.leading)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom)
                .offset(AppConstants.normalSpacing)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalSpacing)
            make.height.equalTo(48)
        }
        
        noAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(enterButton.snp.bottom)
                .offset(AppConstants.normalSpacing)
            make.leading.equalTo(enterButton.snp.leading)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(noAccountLabel.snp.top)
            make.trailing.equalTo(enterButton.snp.trailing)
                .inset(AppConstants.compactSpacing)
            make.leading.equalTo(noAccountLabel.snp.trailing)
                .offset(AppConstants.smallSpacing)
            make.height.equalTo(noAccountLabel.snp.height)
            make.width.equalTo(registerButton.titleLabel!.snp.width)
        }
        
        enterWithLabel.snp.makeConstraints { make in
            make.top.equalTo(noAccountLabel.snp.bottom)
                .offset(AppConstants.bigSpacing)
            make.centerX.equalToSuperview()
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(enterWithLabel.snp.bottom)
                .offset(AppConstants.normalSpacing)
            make.centerX.equalToSuperview()
        }
        
        signInAppleButton.snp.makeConstraints { make in
            make.size.equalTo(Constants.bottomButtonSize)
        }
        
        signInVkButton.snp.makeConstraints { make in
            make.size.equalTo(Constants.bottomButtonSize)
        }
        
        signInYandexButton.snp.makeConstraints { make in
            make.size.equalTo(Constants.bottomButtonSize)
        }
    }
    
    func bindings() {
        viewModel.$loginError
            .sink { [weak self] loginError in
                self?.loginTextField.showError(loginError)
            }
            .store(in: &cancellableSet)
        viewModel.$paswordError
            .sink { [weak self] paswordError in
                self?.passwordTextField.showError(paswordError)
            }
            .store(in: &cancellableSet)
    }
}

