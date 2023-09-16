//
//  String+extension.swift
//  abit.itmo
//
//  Created by Александр Катков on 16.09.2023.
//

import Foundation

extension String {
    
    /// Проверка  email
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
