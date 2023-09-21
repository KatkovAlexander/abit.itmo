//
//  RatingSectionModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 22.09.2023.
//

enum RatingSectionType: String {
    case segmentSection
    case myPrograms
    case allPrograms
}

struct RatingSectionModel: Hashable {
    
    let type: RatingSectionType
    let items: [AnyHashable]
    
    init(type: RatingSectionType) {
        self.type = type
        self.items = [type.rawValue]
    }
    
    init(type: RatingSectionType, item: AnyHashable) {
        self.type = type
        self.items = [item]
    }
    
    init(type: RatingSectionType, items: [AnyHashable]) {
        self.type = type
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type.rawValue)
        hasher.combine(items)
    }

    static func == (
        lhs: RatingSectionModel,
        rhs: RatingSectionModel
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

