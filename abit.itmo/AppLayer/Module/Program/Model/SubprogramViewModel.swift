//
//  SubprogramViewModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

struct SubprogramViewModel: Hashable {
    
    let id: String
    let subprogramName: String
    let isSelected: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(subprogramName)
        hasher.combine(isSelected)
    }

    public static func == (
        lhs: SubprogramViewModel,
        rhs: SubprogramViewModel
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
