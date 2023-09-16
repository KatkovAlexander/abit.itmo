//
//  AuthViewModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine

final class AuthViewModel {

    // MARK: Internal properties
    
    @Published var loginError: String?
    @Published var paswordError: String?
    
    // MARK: Private properties
    
    private var enteredLogin: String?
    private var enteredPassword: String?
    private var correctEmail = "itmo@itmo.ru"
    private var correctLogin = "itmo"
    private var correctPassword = "itmo2023"
}

// MARK: Internal methods

extension AuthViewModel {
    
    func textFieldDidChangeSelection(key: String?, text: String?) {
        switch key {
            case "login":
                enteredLogin = text
            case "password":
                enteredPassword = text
            default:
                print("no such key")
        }
    }
    
    func textFieldDidEndEditing(key: String?, text: String?) {
        var errorText: String?
        if text == nil || text == "" {
            errorText = "Поле обязательно для заполнения"
        }
        
        switch key {
            case "login":
                loginError = errorText
            case "password":
                paswordError = errorText
            default:
                print("no such key")
        }
    }
    
    func didTapLoginButton() {
        if enteredLogin == nil || enteredLogin == "" {
            loginError = "Поле обязательно для заполнения"
        } else if  enteredLogin != correctLogin {
            loginError = "Неправильный e-mail или логин"
        } else if enteredPassword == nil || enteredPassword == "" {
            loginError = "Поле обязательно для заполнения"
        } else if enteredPassword != correctPassword {
            paswordError = "Неправильный пароль"
        } else {
            GlobalRouter.instance.setMain()
        }
    }
}
