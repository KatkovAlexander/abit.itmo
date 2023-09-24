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
    
    // MARK: Private properties
    
    private weak var transitionHandler: TransitionHandler?
    
    // MARK: Initialization
    
    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }
}

// MARK: Internal methods

extension DashboardViewModel {
    
    func viewDidLoad() {
        build()
    }
}

// MARK: EducationalProgrammsCellDelegate

extension DashboardViewModel: EducationalProgrammsCellDelegate {
    
    func didTapSelect() {
        transitionHandler?.push(ProgramFactory().build())
    }
}

// MARK: Private methods

private extension DashboardViewModel {
    
    func build() {
        var models = [DashboardTableViewCellType]()
        models.append(.educationalProgramms)
        models.append(.questionnaire(.success))
        tableViewModels = models
    }
}

