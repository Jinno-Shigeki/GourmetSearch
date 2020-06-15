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
    let toolbar = UIToolbar()
    var presenter = FirstViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        gourmetSearch.delegate = self
        viewItemsLayout()
        toolBarCustom()
        categoryCollection.register(UINib(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        categoryCollection.register(UINib(nibName: "CategoryCollectionHeader", bundle: nil), forCellWithReuseIdentifier: "header")
        if UserDefaults.standard.string(forKey: "UserID") == nil {
            CreateUsers()
        }
    }
    
    private func nextScreen(_ searchText: String) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewController(withIdentifier: "ShopListVC") as! GourmetListViewController
        nextVC.searchText = searchText
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func CreateUsers (){
        let id = presenter.createID()
        presenter.sendID(id: id)
        UserDefaults.standard.set(id, forKey: "UserID")
    }
    private func viewItemsLayout() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        gourmetSearch.backgroundImage = UIImage()
        gourmetSearch.searchTextField.backgroundColor = .white
        tabBarController?.tabBar.backgroundImage = UIImage()
        tabBarController?.tabBar.shadowImage = UIImage()
    }
    private func toolBarCustom() {
        let closeButton = UIBarButtonItem(title: "close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(tapCloseButton(_:)))
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        closeButton.tintColor = .orange
        toolbar.barTintColor = UIColor.init(named: "LightYellow")
        toolbar.setItems([flexibleItem,closeButton], animated: true)
        toolbar.sizeToFit()
        gourmetSearch.inputAccessoryView = toolbar
    }
    @objc func tapCloseButton(_ sender: UIButton){
        gourmetSearch.endEditing(true)
    }
}
//MARK: - UICollectionViewDelegate
extension FirstViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gourmetSearch.endEditing(true)
        categoryCollection.deselectItem(at: indexPath, animated: true)
        if indexPath.section == 1 {
            nextScreen(StaticData.category[indexPath.row])
        } else if indexPath.section == 3{
            nextScreen(StaticData.shopSituation[indexPath.row])
        }
    }
}
//MARK: - UICollectionViewDataSource
extension FirstViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return StaticData.category.count
        } else if section == 3{
            return StaticData.shopSituation.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionCell
        let header = collectionView.dequeueReusableCell(withReuseIdentifier: "header", for: indexPath) as! CategoryCollectionHeader
        if indexPath.section == 0 {
            header.headerLabel.text = StaticData.headerName[0]
            return header
        } else if indexPath.section == 1{
            cell.categoryLabel.text = StaticData.category[indexPath.row]
            cell.imageSet(imageName: StaticData.category[indexPath.row])
            return cell
        } else if indexPath.section == 2{
            header.headerLabel.text = StaticData.headerName[1]
            return header
        } else {
            cell.categoryLabel.text = StaticData.shopSituation[indexPath.row]
            cell.imageSet(imageName:  StaticData.shopSituation[indexPath.row])
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
}

extension FirstViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 || indexPath.section == 3{
            return CGSize(width: 120, height: 90)
        } else {
            return CGSize(width: 400, height: 40)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        } else {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
}
//MARK: - UISearchBarDelegate
extension FirstViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        gourmetSearch.endEditing(true)
        nextScreen(searchBar.text ?? "")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
        searchBar.endEditing(true)
    }
}

