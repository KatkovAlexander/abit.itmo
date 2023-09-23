//
//  MyProgrammCellModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

import Foundation

class MyProgramCellModel: NSObject, NSItemProviderWriting {
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        ["MyProgramCellModel"]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping @Sendable (Data?, Error?) -> Void) -> Progress? {
        nil
    }
    
    let id: String
    let programName: String
    let subprogramId: String
    let subprogramName: String
    
    init(id: String, programName: String, subprogramId: String, subprogramName: String) {
        self.id = id
        self.programName = programName
        self.subprogramId = subprogramId
        self.subprogramName = subprogramName
    }
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(id)
        hasher.combine(programName)
        hasher.combine(subprogramId)
        hasher.combine(subprogramName)
        return hasher.finalize()
    }

    public static func == (
        lhs: MyProgramCellModel,
        rhs: MyProgramCellModel
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
