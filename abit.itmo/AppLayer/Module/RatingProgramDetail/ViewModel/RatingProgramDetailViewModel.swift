//
//  RatingProgramDetailViewModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine

final class RatingProgramDetailViewModel {

    // MARK: Internal properties
    
    @Published var tableViewModels = [RatingProgramDetailCellType]()
}

// MARK: Internal methods

extension RatingProgramDetailViewModel {
    
    func viewDidLoad() {
        build()
    }
}

private extension RatingProgramDetailViewModel {
    
    func build() {
        var models = [RatingProgramDetailCellType]()
        models.append(contentsOf: buildInfoSection())
        tableViewModels = models
    }
    
    func buildInfoSection() -> [RatingProgramDetailCellType] {
        var models = [RatingProgramDetailCellType]()
        let infoModel = RatingProgramDetailInfoCellModel(
            programName: "Биоинформатика и системная биология / Bioinformatics and systems biology",
            subprogramName: "01.04.02 Прикладная математика и информатика",
            enrolleePlace: 5,
            numberOfPlaces: 18
        )
        models.append(.programInfo(infoModel))
        return models
    }
}
