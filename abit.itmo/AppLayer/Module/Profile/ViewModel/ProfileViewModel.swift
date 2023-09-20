//
//  ProfileViewModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine

final class ProfileViewModel {
    
    // MARK: Internal properties
    
    @Published var tableViewModels = [ProfileTableViewCellType]()

}

// MARK: Internal methods

extension ProfileViewModel {
    
    func viewDidLoad() {
        build()
    }
}

private extension ProfileViewModel {
    
    func build() {
        var models = [ProfileTableViewCellType]()
        models.append(.profile)
        models.append(.questionnaire(.fillDocuments(1, 2)))
        tableViewModels = models
    }
}
