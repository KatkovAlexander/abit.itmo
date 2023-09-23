//
//  OneItemInSectionLayout.swift
//  abit.itmo
//
//  Created by Александр Катков on 21.09.2023.
//

import UIKit

public struct OneItemInSectionLayout: SectionLayoutable {
    
    public var background: UICollectionReusableView.Type?
    
    public var section: NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1000)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: .zero,
            leading: AppConstants.normalSpacing,
            bottom: .zero,
            trailing: AppConstants.normalSpacing)
        return section
    }
    
    public var header: NSCollectionLayoutBoundarySupplementaryItem? {
        return nil
    }
    
    public var footer: NSCollectionLayoutBoundarySupplementaryItem? {
        return nil
    }
    
    public init() { }
}
