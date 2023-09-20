//
//  MyProgrammCellModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

struct MyProgramCellModel: Hashable {
    
    let id: String
    let programName: String
    let subprogramName: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(programName)
        hasher.combine(subprogramName)
    }

    public static func == (
        lhs: MyProgramCellModel,
        rhs: MyProgramCellModel
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
