//
//  TabBarObject.swift
//  abit.itmo
//
//  Created by Александр Катков on 13.09.2023.
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    
    case menu
    case list
    case profile
}

struct TabBarModule {
    
    private let type: TabBarItemType
    
    init(type: TabBarItemType){
        self.type = type
    }
    
    func configure() -> UIViewController {
        switch type {
        case .menu:
            return AuthFactory().build()
        case .list:
            return AuthFactory().build()
        case .profile:
            return AuthFactory().build()
        }
    }
}

struct TabBarPresentation {
    
    private let type: TabBarItemType
    
    init(type: TabBarItemType){
        self.type = type
    }
    
    var title: String {
        switch type {
        case .menu:
            return "Дашборд"
        case .list:
            return "Списки"
        case .profile:
            return "Профиль"
        }
    }
    
    var image: UIImage? {
        switch type {
        case .menu:
            return UIImage(systemName: "menucard")
        case .list:
            return UIImage(systemName: "message")
        case .profile:
            return UIImage(systemName: "person")
        }
    }
    
    var selectedImage: UIImage? {
        switch type {
        case .menu:
            return UIImage(systemName: "menucard.fill")
        case .list:
            return UIImage(systemName: "message.fill")
        case .profile:
            return UIImage(systemName: "person.fill")
        }
    }
}

