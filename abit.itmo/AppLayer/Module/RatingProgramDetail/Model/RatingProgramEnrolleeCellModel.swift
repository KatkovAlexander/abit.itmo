//
//  RatingProgramEnrolleeCellModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 23.09.2023.
//

enum ProgramStatus: String {
    case inOrder = "Рекомендован"
    case inAnotherOrder = "Рекомендован на другую программу"
}

struct RatingProgramEnrolleeCellModel {
    let position: Int
    let snils: String
    let contest: String
    let priority: Int
    let diplomaAverage: Double
    let isSendOriginal: Bool
    let status: ProgramStatus?
    let totalScore: Double
    let examScore: Double
    let iaScores: Int
    let isOpened: Bool
    let isCurrentUser: Bool
}
