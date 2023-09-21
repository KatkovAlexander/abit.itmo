//
//  ProgramSectionModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

enum ProgramSectionType: String {
    
    case segmentSection
    case descriptionSection
    case myProgrammsSection
    case allProgrammsSection
}

struct ProgramSectionModel: Hashable {
    
    let type: ProgramSectionType
    let items: [AnyHashable]
    
    init(type: ProgramSectionType) {
        self.type = type
        self.items = [type.rawValue]
    }
    
    init(type: ProgramSectionType, item: AnyHashable) {
        self.type = type
        self.items = [item]
    }
    
    init(type: ProgramSectionType, items: [AnyHashable]) {
        self.type = type
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type.rawValue)
        hasher.combine(items)
    }

    static func == (
        lhs: ProgramSectionModel,
        rhs: ProgramSectionModel
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
