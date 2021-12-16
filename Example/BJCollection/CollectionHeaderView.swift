//
//  CollectionHeaderView.swift
//  BJCollection_Example
//
//  Created by Sovannra on 16/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

public class BJCollectionHeaderView: UICollectionReusableView  {
    
    lazy var vImage: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "spider-man-no-way-home")
        view.image = image
        view.contentMode = .scaleAspectFill
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.clipsToBounds = true
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(vImage)
        vImage.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
