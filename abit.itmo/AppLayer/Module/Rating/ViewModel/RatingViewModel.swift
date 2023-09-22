//
//  RatingViewModel.swift
//  abit.itmo
//
//  Created by Александр Катков on 12.09.2023.
//

import Combine

final class RatingViewModel {
    
    // MARK: Internal properties
    
    @Published var collectionSections: [RatingSectionModel] = []
    
    // MARK: Private properties
    
    private weak var transitionHandler: TransitionHandler?
    var selectedSegmentIndex = 0
    var showAllPrograms = false
    
    // MARK: Initialization

    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }
}

// MARK: Internal methods

extension RatingViewModel {
    
    func viewDidLoad() {
        build()
    }
    
    func didTapMyProgram(id: String) {
        transitionHandler?.push(RatingProgramDetailFactory().build(isPersonal: true))
    }
    
    func didTapPublicProgram(id: String) {
        transitionHandler?.push(RatingProgramDetailFactory().build(isPersonal: false))
    }
}

// MARK: SegmentCellDelegate

extension RatingViewModel: SegmentCellDelegate {
    
    func segmentControlSwitched(_ index: Int) {
        showAllPrograms = index == 1
        build()
    }
}

// MARK: Private methods

private extension RatingViewModel {
    
    func build() {
        var sections = [RatingSectionModel]()
        sections.append(contentsOf: buildSegmentSection())
        if showAllPrograms {
            sections.append(contentsOf: buildAllPrograms())
        } else {
            sections.append(contentsOf: buildMyPrograms())
        }
        collectionSections = sections
    }
    
    func buildSegmentSection() -> [RatingSectionModel] {
        var section = [RatingSectionModel]()
        section.append(.init(
            type: .segmentSection,
            item: SegmentCellModel(selectedIndex: selectedSegmentIndex)
        ))
        return section
    }
    
    func buildMyPrograms() -> [RatingSectionModel] {
        var section = [RatingSectionModel]()
        section.append(.init(
            type: .myPrograms,
            item: RatingProgramCellModel(
                id: "1",
                position: 3,
                programName: "Биоинформатика и системная биология / Bioinformatics and systems biology",
                subprogramName: "01.04.02 Прикладная математика и информатика",
                kcp: 25
            )
        ))
        return section
    }
    
    func buildAllPrograms() -> [RatingSectionModel] {
        var section = [RatingSectionModel]()
        section.append(.init(
            type: .allPrograms,
            item: RatingProgramCellModel(
                id: "1",
                programName: "Биоинформатика и системная биология / Bioinformatics and systems biology",
                subprogramName: "01.04.02 Прикладная математика и информатика",
                kcp: 25
            )
        ))
        return section
    }
}
