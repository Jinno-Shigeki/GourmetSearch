//
//  ViewController.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/06.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var categoryCollection: UICollectionView!
    
    var presenter = FirstViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        categoryCollection.register(UINib(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
}
//MARK: -
extension FirstViewController: UICollectionViewDelegate {
    
}
//MARK: -
extension FirstViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
             return presenter.category.count
        } else {
            return presenter.shopSystem.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionCell
        if indexPath.section == 0 {
            cell.categoryImage.image = UIImage(named: presenter.category[indexPath.row])
            cell.categoryLabel.text = presenter.category[indexPath.row]
        } else {
            cell.categoryImage.image = UIImage(named: presenter.shopSystem[indexPath.row])
            cell.categoryLabel.text = presenter.shopSystem[indexPath.row]
        }
        cellLayout()
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func cellLayout() {
        let layer = UICollectionViewFlowLayout()
        layer.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layer.itemSize = CGSize(width: 120, height: 90)
        categoryCollection.collectionViewLayout = layer
    }
    
}


