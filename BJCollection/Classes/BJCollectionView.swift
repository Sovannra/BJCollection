//
//  BJCollectionView.swift
//  BJCollection
//
//  Created by Sovannra on 13/12/21.
//

import UIKit

public enum BJCollectionViewFlowLayoutStyle {
    case normal
    case waterfall
}

public class BJCollectionView: UICollectionView {
    
    public var showScrollIndicator: Bool {
        get {
            return self.showScrollIndicator
        }
        set {
            self.showsHorizontalScrollIndicator = newValue
            self.showsVerticalScrollIndicator = newValue
        }
    }
            
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .clear
    }
    
    var itemsArray: [CGFloat] = []
    
    public convenience init(
        numberOfItems: Int?=nil,
        heightItems: CGFloat?=nil,
        heightHeader: CGFloat?=nil,
        spacingBetweenItems: CGFloat?=nil,
        scrollDirection: UICollectionView.ScrollDirection?=nil,
        flowLayoutStyle: BJCollectionViewFlowLayoutStyle = .normal,
        stickyHeader: Bool?=nil
    ) {
        switch flowLayoutStyle {
        case .normal:
            let layout = BaseCollectionViewFlowLayout()
            layout.numberOfItemsInRow = numberOfItems ?? layout.numberOfItemsInRow
            layout.spacingBetweenItems = spacingBetweenItems ?? layout.spacingBetweenItems
            layout.heightItems = heightItems ?? layout.heightItems
            layout.direction = scrollDirection ?? layout.direction
            layout.heightHeader = heightHeader ?? layout.heightHeader
            layout.stickyHeader = stickyHeader ?? layout.stickyHeader
            self.init(frame: .zero, collectionViewLayout: layout)
        case .waterfall:
            let layout = CHTCollectionViewWaterfallLayout()
            layout.columnCount = numberOfItems ?? 2
            layout.minimumColumnSpacing = spacingBetweenItems ?? 3.0
            layout.minimumInteritemSpacing = spacingBetweenItems ?? 3.0
            layout.itemRenderDirection = .leftToRight
            self.init(frame: .zero, collectionViewLayout: layout)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}