//
//  ProgramSectionModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

enum ProgramSectionType {
    
    case segmentSection
    case descriptionSection
    case myProgrammsSection
    case allProgrammsSection
    
    var hash: String {
        switch self {
            case .segmentSection:
                return "1"
            case .descriptionSection:
                return "2"
            case .myProgrammsSection:
                return "3"
            case .allProgrammsSection:
                return "4"
        }
    }
}

struct ProgramSectionModel: Hashable {
    
    let type: ProgramSectionType
    let items: [AnyHashable]
    
    init(type: ProgramSectionType) {
        self.type = type
        self.items = [type.hash]
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
        hasher.combine(type.hash)
        hasher.combine(items)
    }

    static func == (
        lhs: ProgramSectionModel,
        rhs: ProgramSectionModel
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
