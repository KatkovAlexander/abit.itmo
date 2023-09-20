//
//  ProgramViewModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine

final class ProgramViewModel {
    
    // MARK: Internal properties
    
    @Published var collectionSections: [ProgramSectionModel] = []
    
    // MARK: Private properties
    
    var selectedSegmentIndex = 0
    var showAllPrograms = false

}

// MARK: Internal methods

extension ProgramViewModel {
    
    func viewDidLoad() {
        build()
    }
}

// MARK: SegmentCellDelegate

extension ProgramViewModel: SegmentCellDelegate {
    
    func segmentControlSwitched(_ index: Int) {
        showAllPrograms = index == 1
        build()
    }
}

// MARK: Private methods

private extension ProgramViewModel {
    
    func build() {
        var sections = [ProgramSectionModel]()
        sections.append(contentsOf: buildSegmentSection())
        if showAllPrograms {
            sections.append(contentsOf: buildAllProgrammsSection())
        } else {
            sections.append(contentsOf: buildMyProgrammsSection())
        }
        collectionSections = sections
    }
    
    func buildSegmentSection() -> [ProgramSectionModel] {
        var section = [ProgramSectionModel]()
        section.append(.init(
            type: .segmentSection,
            item: SegmentCellModel(selectedIndex: selectedSegmentIndex)
        ))
        return section
    }
    
    func buildMyProgrammsSection() -> [ProgramSectionModel] {
        var section = [ProgramSectionModel]()
        section.append(.init(type: .descriptionSection))
        section.append(.init(
            type: .myProgrammsSection,
            item: MyProgramCellModel(
                id: "1",
                programName: "Биоинформатика и системная биология / Bioinformatics and systems biology",
                subprogramName: "01.04.02 Прикладная математика и информатика"
            )
        ))
        return section
    }
    
    func buildAllProgrammsSection() -> [ProgramSectionModel] {
        var section = [ProgramSectionModel]()
        section.append(.init(
            type: .allProgrammsSection,
            items: [AllProgramCellModel(
                id: "1",
                programName: "Прикладная геномика",
                subprograms: [
                    .init(id: "1", subprogramName: "06.04.01 Биология", isSelected: true),
                    .init(id: "2", subprogramName: "19.04.01 Биотехнология", isSelected: false)
                ])
            ]
        ))
        return section
    }
}

