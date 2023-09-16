//
//  UITextField+extension.swift
//  abit.itmo
//
//  Created by Александр Катков on 16.09.2023.
//

import UIKit

extension UITextField {
        
    /// добавление кнопки "Готово"
    func addDoneButton() {
        let toolBar = UIToolbar(frame: CGRect.init(
            x: 0, y: 0,
            width: UIScreen.main.bounds.width, height: 50
        ))
        toolBar.barStyle = .default
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        toolBar.items = [flexSpace, doneButton]
        toolBar.sizeToFit()
        inputAccessoryView = toolBar
    }
    
    @objc func didTapDone() {
        resignFirstResponder()
    }
}
