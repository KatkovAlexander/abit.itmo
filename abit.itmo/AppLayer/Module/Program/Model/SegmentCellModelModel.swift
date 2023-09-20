//
//  SegmentCellModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

struct SegmentCellModel: Hashable {
    
    let selectedIndex: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(selectedIndex)
    }

    public static func == (
        lhs: SegmentCellModel,
        rhs: SegmentCellModel
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
