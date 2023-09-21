//
//  RatingProgramCellModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 22.09.2023.
//

struct RatingProgramCellModel: Hashable {
    
    let id: String
    let position: Int?
    let programName: String
    let subprogramName: String
    let kcp: Int
    
    init(id: String, position: Int? = nil, programName: String, subprogramName: String, kcp: Int) {
        self.id = id
        self.position = position
        self.programName = programName
        self.subprogramName = subprogramName
        self.kcp = kcp
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(position)
        hasher.combine(programName)
        hasher.combine(subprogramName)
        hasher.combine(kcp)
    }

    public static func == (
        lhs: RatingProgramCellModel,
        rhs: RatingProgramCellModel
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
