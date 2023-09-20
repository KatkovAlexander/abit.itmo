//
//  QuestionnaireCellStatus.swift
//  abit.itmo
//
//  Created by Александр Катков on 18.09.2023.
//

enum QuestionnaireCellStatus {
    
    case fillDocuments(_ filled: Int, _ required: Int)
    case sendDocuments
    case onModeration
    case fail
    case success
}
