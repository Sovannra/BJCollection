//
//  BJCollectionViewFlowLayout.swift
//  BJCollection
//
//  Created by Sovannra on 13/12/21.
//

import UIKit

class BaseCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var numberOfItemsInRow: Int = 3
    var spacingBetweenItems: CGFloat = 2.0
    var heightItems: CGFloat = 0
    var heightHeader: CGFloat = 0
    var direction: UICollectionView.ScrollDirection = .vertical
    var stickyHeader: Bool = false
    
    override func prepare() {
        super.prepare()
        updateLayout()
        updateHeaderLayout()
    }
    
    fileprivate func updateLayout() {
        guard let collectionView = self.collectionView else { return }
        
        switch direction {
        case .horizontal:
            itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        case .vertical:
            let margins = spacingBetweenItems + 1
            let width = (collectionView.frame.width - margins) / CGFloat(numberOfItemsInRow) - spacingBetweenItems
            if heightItems <= 0 {
                heightItems = width
            }
            itemSize = CGSize(width: width, height: heightItems)
        @unknown default:
            fatalError()
        }
        sectionInset = UIEdgeInsets(top: spacingBetweenItems, left: spacingBetweenItems, bottom: spacingBetweenItems, right: spacingBetweenItems)
        scrollDirection = direction
        minimumLineSpacing = spacingBetweenItems
        minimumInteritemSpacing = spacingBetweenItems
    }
    
    fileprivate func updateHeaderLayout() {
        guard let collectionView = self.collectionView else { return }
        
        if heightHeader > 0 {
            headerReferenceSize = CGSize(width: collectionView.frame.width, height: heightHeader)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        if stickyHeader {
            layoutAttributes?.forEach({ (attribute) in
                if attribute.representedElementKind == UICollectionView.elementKindSectionHeader && attribute.indexPath.section == 0 {
                    
                    guard let collectionView = self.collectionView else { return }
                    
                    let contentOffsetY = collectionView.contentOffset.y
                    
                    if contentOffsetY > 0 {
                        return
                    }
                    
                    let width = collectionView.frame.width
                    let height = attribute.frame.height - contentOffsetY
                    
                    //Header
                    attribute.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
                }
            })
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
