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
    @Published var showEmptyView = true
    
    
    // MARK: Private properties
    
    private var selectedSegmentIndex = 0 {
        didSet {
            showAllPrograms = selectedSegmentIndex == 1
            configureEmptyView()
        }
    }
    private var showAllPrograms = false
    private var selectedPrograms = [MyProgramCellModel]() {
        didSet {
           configureEmptyView()
        }
    }
    private var allPrograms = [AllProgramCellModel]()

}

// MARK: Internal methods

extension ProgramViewModel {
    
    func viewDidLoad() {
        allPrograms = generateAllPrograms()
        configureEmptyView()
        build()
    }
    
    func didMyProgramCellChangePosition(oldPositon: Int, newPosition: Int) {
        let item = selectedPrograms.remove(at: oldPositon)
        selectedPrograms.insert(item, at: newPosition)
        build()
    }
}

// MARK: EmptyViewDelegate

extension ProgramViewModel: EmptyViewDelegate {
    
    func didTapBottomButton() {
        selectedSegmentIndex = 1
        build()
    }
}

// MARK: SegmentCellDelegate

extension ProgramViewModel: SegmentCellDelegate {
    
    func segmentControlSwitched(_ index: Int) {
        selectedSegmentIndex = index
        build()
    }
}

// MARK: MyProgramCellDelegate

extension ProgramViewModel: MyProgramCellDelegate {
    
    func didTapRemove(programId: String, subprogramId: String) {
        guard let programIndex = allPrograms.firstIndex(where: {$0.id == programId}),
              let subprogramIndex = allPrograms[programIndex].subprograms.firstIndex(
                where: {$0.id == subprogramId}
              )
        else { return }
        allPrograms[programIndex].subprograms[subprogramIndex].isSelected.toggle()
        
        selectedPrograms.removeAll(where: {
            $0.id == programId && $0.subprogramId == subprogramId
        })
        
        build()
    }
    
    func didTapSelect(programId: String) {
        print(programId)
    }
}

// MARK: AllProgramCellDelegate

extension ProgramViewModel: AllProgramCellDelegate {
    
    func didSelectSubprogram(programId: String, subprogramId: String) {
        guard let programIndex = allPrograms.firstIndex(where: {$0.id == programId}),
              let subprogramIndex = allPrograms[programIndex].subprograms.firstIndex(
                where: {$0.id == subprogramId}
              )
        else { return }
        allPrograms[programIndex].subprograms[subprogramIndex].isSelected.toggle()
        
        if allPrograms[programIndex].subprograms[subprogramIndex].isSelected {
            selectedPrograms.append(.init(
                id: allPrograms[programIndex].id,
                programName: allPrograms[programIndex].programName,
                subprogramId: allPrograms[programIndex].subprograms[subprogramIndex].id,
                subprogramName: allPrograms[programIndex].subprograms[subprogramIndex].subprogramName
            ))
        } else {
            selectedPrograms.removeAll(where: {
                $0.id == allPrograms[programIndex].id
                && $0.subprogramId == allPrograms[programIndex].subprograms[subprogramIndex].id
            })
        }
        build()
    }
    
    func didTapDetail(id: String) {
        print(id)
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
            items: selectedPrograms
        ))
        return section
    }
    
    func buildAllProgrammsSection() -> [ProgramSectionModel] {
        var section = [ProgramSectionModel]()
        section.append(.init(
            type: .allProgrammsSection,
            items: allPrograms
        ))
        return section
    }
    
    func generateAllPrograms() -> [AllProgramCellModel] {
        var programs = [AllProgramCellModel]()
        programs.append(.init(
            id: "2",
            programName: "Биоинформатика и системная биология / Bioinformatics and systems biology",
            subprograms: [
                .init(id: "1", subprogramName: "01.04.02 Прикладна\nматематика и информатика", isSelected: false),
            ]
        ))
        programs.append(.init(
            id: "1",
            programName: "Прикладная геномика",
            subprograms: [
                .init(id: "2", subprogramName: "06.04.01 Биология", isSelected: false),
                .init(id: "3", subprogramName: "19.04.01 Биотехнология", isSelected: false)
            ]
        ))
        return programs
    }
    
    func configureEmptyView() {
        showEmptyView = selectedPrograms.isEmpty && selectedSegmentIndex == 0
    }
}

