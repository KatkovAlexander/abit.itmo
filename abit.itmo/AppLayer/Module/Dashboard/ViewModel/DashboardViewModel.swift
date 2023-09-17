//
//  DashboardViewModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine

final class DashboardViewModel {
    
    // MARK: Internal properties
    
    @Published var tableViewModels = [DashboardTableViewCellType]()

}

// MARK: Internal methods

extension DashboardViewModel {
    
    func viewDidLoad() {
        build()
    }
}

// MARK: Private methods

private extension DashboardViewModel {
    
    func build() {
        var models = [DashboardTableViewCellType]()
        models.append(.educationalProgramms("1"))
        models.append(.questionnaire("2"))
        tableViewModels = models
    }
}

