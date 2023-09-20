//
//  AllProgramCellModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

struct AllProgramCellModel: Hashable {
    
    let id: String
    let programName: String
    let subprograms: [SubprogramViewModel]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(programName)
        hasher.combine(subprograms)
    }

    public static func == (
        lhs: AllProgramCellModel,
        rhs: AllProgramCellModel
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
