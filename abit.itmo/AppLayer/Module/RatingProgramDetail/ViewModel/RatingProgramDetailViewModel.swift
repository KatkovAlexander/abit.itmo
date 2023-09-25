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
    @Published var isHiddenShowMeButton: Bool
    
    // MARK: Private properties
    
    private let isPersonal: Bool
    private let enrolleePlace: Int?
    private let enrolleeSnils: String?
    private var openedEnrollees = [String: Bool]()
    
    // MARK: Initialization
    
    init(isPersonal: Bool) {
        self.isPersonal = isPersonal
        enrolleePlace = isPersonal ? 3 : nil
        enrolleeSnils = isPersonal ? "№14831458653" : nil
        isHiddenShowMeButton = !isPersonal
    }
}

// MARK: Internal methods

extension RatingProgramDetailViewModel {
    
    func viewDidLoad() {
        build()
    }
}

// MARK: RatingProgramEnrolleeCellDelegate

extension RatingProgramDetailViewModel: RatingProgramEnrolleeCellDelegate {
    
    func didTapEnrolleeCell(snils: String) {
        if openedEnrollees[snils] == true {
            openedEnrollees[snils] = false
        } else {
            openedEnrollees[snils] = true
        }
        build()
    }
}

// MARK: Private methods

private extension RatingProgramDetailViewModel {
    
    func build() {
        var models = [RatingProgramDetailCellType]()
        models.append(contentsOf: buildInfoSection())
        models.append(contentsOf: buildEnrollees())
        tableViewModels = models
    }
    
    func buildInfoSection() -> [RatingProgramDetailCellType] {
        var models = [RatingProgramDetailCellType]()
        let infoModel = RatingProgramDetailInfoCellModel(
            programName: "Биоинформатика и системная биология / Bioinformatics and systems biology",
            subprogramName: "01.04.02 Прикладная математика и информатика",
            enrolleePlace: enrolleePlace,
            numberOfPlaces: isPersonal ? 3 : 2
        )
        models.append(.programInfo(infoModel))
        return models
    }
    
    func buildEnrollees() -> [RatingProgramDetailCellType] {
        var models = [RatingProgramDetailCellType]()
        models.append(.enrollee(.init(
            position: 1,
            snils: "№17231458651",
            contest: "Конкурс “Портфолио” университета ИТМО",
            priority: 1,
            diplomaAverage: 4.98,
            isSendOriginal: true,
            status: .inOrder,
            totalScore: 102,
            examScore: 100,
            iaScores: 2,
            isOpened: openedEnrollees["№17231458651"] ?? false,
            isCurrentUser: enrolleeSnils == "№17231458651"
        )))
        models.append(.enrollee(.init(
            position: 2,
            snils: "№17231458652",
            contest: "МегаОлимпиада ИТМО",
            priority: 1,
            diplomaAverage: 4.98,
            isSendOriginal: false,
            status: .inOrder,
            totalScore: 98,
            examScore: 96,
            iaScores: 2,
            isOpened: openedEnrollees["№17231458652"] ?? false,
            isCurrentUser: enrolleeSnils == "№17231458652"
        )))
        
        if let enrolleeSnils = enrolleeSnils {
            models.append(.enrollee(.init(
                position: 3,
                snils: enrolleeSnils,
                contest: "ПИГА",
                priority: 1,
                diplomaAverage: 4.87,
                isSendOriginal: false,
                status: .inOrder,
                totalScore: 96,
                examScore: 95,
                iaScores: 1,
                isOpened: openedEnrollees[enrolleeSnils] ?? false,
                isCurrentUser: true
            )))
        } else {
            models.append(.enrollee(.init(
                position: 3,
                snils: "№17231458643",
                contest: "ПИГА",
                priority: 1,
                diplomaAverage: 4.87,
                isSendOriginal: false,
                status: .inOrder,
                totalScore: 96,
                examScore: 95,
                iaScores: 1,
                isOpened: openedEnrollees["№17231458643"] ?? false,
                isCurrentUser: enrolleeSnils == "№17231458643"
            )))
        }
        
        models.append(.enrollee(.init(
            position: 4,
            snils: "№17231458653",
            contest: "ПИГА",
            priority: 1,
            diplomaAverage: 4.6,
            isSendOriginal: false,
            status: .inAnotherOrder,
            totalScore: 91,
            examScore: 90,
            iaScores: 1,
            isOpened: openedEnrollees["№17231458653"] ?? false,
            isCurrentUser: enrolleeSnils == "№17231458653"
        )))
        models.append(.enrollee(.init(
            position: 5,
            snils: "№17231458654",
            contest: "ВЭ",
            priority: 1,
            diplomaAverage: 4.4,
            isSendOriginal: false,
            status: nil,
            totalScore: 80.7,
            examScore: 80.7,
            iaScores: 0,
            isOpened: openedEnrollees["№17231458654"] ?? false,
            isCurrentUser: enrolleeSnils == "№17231458654"
        )))
        models.append(.enrollee(.init(
            position: 6,
            snils: "№17231458655",
            contest: "ВЭ",
            priority: 1,
            diplomaAverage: 4.3,
            isSendOriginal: false,
            status: nil,
            totalScore: 79.7,
            examScore: 79.7,
            iaScores: 0,
            isOpened: openedEnrollees["№17231458655"] ?? false,
            isCurrentUser: enrolleeSnils == "№17231458655"
        )))
        models.append(.enrollee(.init(
            position: 7,
            snils: "№17231458656",
            contest: "ВЭ",
            priority: 1,
            diplomaAverage: 4.2,
            isSendOriginal: false,
            status: nil,
            totalScore: 78.7,
            examScore: 78.7,
            iaScores: 0,
            isOpened: openedEnrollees["№17231458656"] ?? false,
            isCurrentUser: enrolleeSnils == "№17231458656"
        )))
        models.append(.enrollee(.init(
            position: 8,
            snils: "№17231458657",
            contest: "ВЭ",
            priority: 1,
            diplomaAverage: 4.1,
            isSendOriginal: false,
            status: nil,
            totalScore: 77.7,
            examScore: 77.7,
            iaScores: 0,
            isOpened: openedEnrollees["№17231458657"] ?? false,
            isCurrentUser: enrolleeSnils == "№17231458657"
        )))
        models.append(.enrollee(.init(
            position: 9,
            snils: "№17231458658",
            contest: "ВЭ",
            priority: 1,
            diplomaAverage: 4,
            isSendOriginal: false,
            status: nil,
            totalScore: 76.7,
            examScore: 76.7,
            iaScores: 0,
            isOpened: openedEnrollees["№17231458658"] ?? false,
            isCurrentUser: enrolleeSnils == "№17231458658"
        )))
        return models
    }
}
