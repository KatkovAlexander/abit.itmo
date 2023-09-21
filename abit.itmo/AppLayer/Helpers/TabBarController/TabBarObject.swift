//
//  TabBarObject.swift
//  abit.itmo
//
//  Created by Александр Катков on 13.09.2023.
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    
    case dashboard
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
        case .dashboard:
            return DashboardFactory().build()
        case .list:
            return RatingFactory().build()
        case .profile:
            return ProfileFactory().build()
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
        case .dashboard:
            return "Главная"
        case .list:
            return "Рейтинг"
        case .profile:
            return "Профиль"
        }
    }
    
    var image: UIImage? {
        switch type {
        case .dashboard:
            return UIImage(systemName: "house")
        case .list:
            return UIImage(systemName: "square.on.square")
        case .profile:
            return UIImage(systemName: "person")
        }
    }
    
    var selectedImage: UIImage? {
        switch type {
        case .dashboard:
            return UIImage(systemName: "house.fill")
        case .list:
            return UIImage(systemName: "square.fill.on.square.fill")
        case .profile:
            return UIImage(systemName: "person.fill")
        }
    }
}

