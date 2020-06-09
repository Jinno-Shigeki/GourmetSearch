//
//  ViewController.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/06.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
final class FirstViewController: UIViewController {
    
    @IBOutlet private weak var categoryCollection: UICollectionView!
    @IBOutlet private weak var gourmetSearch: UISearchBar!
    
    var presenter = FirstViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        gourmetSearch.delegate = self
        categoryCollection.register(UINib(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    func nextScreen(_ searchText: String) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewController(withIdentifier: "ShopListVC") as! GourmetListViewController
        nextVC.searchText = searchText
         navigationController?.pushViewController(nextVC, animated: true)
    }
}
//MARK: - UICollectionViewDelegate
extension FirstViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            nextScreen(presenter.category[indexPath.row])
        } else {
            nextScreen(presenter.shopSystem[indexPath.row])
        }
    }
}
//MARK: - UICollectionViewDataSource
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
//MARK: - UISearchBarDelegate
extension FirstViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        gourmetSearch.endEditing(true)
        nextScreen(searchBar.text ?? "dinner")
    }
}

