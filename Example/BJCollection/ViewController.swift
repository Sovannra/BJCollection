//
//  ViewController.swift
//  BJCollection
//
//  Created by Sovannra on 12/11/2021.
//  Copyright (c) 2021 Sovannra. All rights reserved.
//

import UIKit
import BJCollection

class ViewController: UIViewController {

    var itemsArray: [CGFloat] = []
    lazy var vCollection: BJCollectionView = {
        let view = BJCollectionView(numberOfItems: 3, heightItems: 180, heightHeader: 200, stickyHeader: true)
        view.delegate = self
        view.dataSource = self
        view.showScrollIndicator = false
        view.register(cell: UICollectionViewCell.self)
        view.register(header: BJCollectionHeaderView.self)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "BJCollection"
        for _ in 0...14 {
            itemsArray.append(getRandomNumber())
        }
        view.backgroundColor = .white
        view.addSubview(vCollection)
        vCollection.fillSuperview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vCollection.frame = view.bounds
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    func getRandomNumber() -> CGFloat {
        return CGFloat.random(in: 250..<400)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeue(for: indexPath)
        cell.backgroundColor = getRandomColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 2, height: itemsArray[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: BJCollectionHeaderView = collectionView.dequeue(forHeader: indexPath)
        return header
    }
}

