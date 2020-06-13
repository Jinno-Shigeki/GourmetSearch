//
//  SecondViewController.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/06.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
import SDWebImage
protocol FavoriteViewProtocol {
    func reloadData()
}
class FavoriteViewController: UIViewController {
    var presenter: FavoriteViewPresenter!
    let userID = UserDefaults.standard.string(forKey: "UserID")
    @IBOutlet weak var favoriteList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteList.delegate = self
        favoriteList.dataSource = self
        // favoriteList.allowsMultipleSelectionDuringEditing = true
        // navigationItem.rightBarButtonItem = editButtonItem
        presenter = FavoriteViewPresenter(view: self)
        favoriteList.register(UINib(nibName: "ShopListCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    override func viewWillAppear(_ animated: Bool) {
        if let userId = userID  {
            presenter.loadBookmark(id: userId)
        }
    }
    //    override func setEditing(_ editing: Bool, animated: Bool) {
    //         super.setEditing(editing, animated: animated)
    //        favoriteList.isEditing = editing
    //    }
}
//MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewController(identifier: "ShopDetailVC") as! ShopDetailViewController
        nextVC.shopData = presenter.shopData[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            presenter.deleteBookmark(id: userID!, rowNumber: indexPath.row)
            presenter.shopData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
//MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.shopData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShopListCell
        cell.shopName.text = presenter.shopData[indexPath.row].name
        cell.location.text = presenter.shopData[indexPath.row].location
        cell.budget.text = presenter.shopData[indexPath.row].budget
        loadImage(cell, rowNumber: indexPath.row)
        return cell
    }
    func loadImage(_ cell: ShopListCell, rowNumber: Int) {
        let imageURL = URL(string: presenter.shopData[rowNumber].shopImage)
        cell.shopImage.sd_setImage(with: imageURL)
    }
}
//MARK: - FavoriteViewProtocol
extension FavoriteViewController: FavoriteViewProtocol {
    func reloadData() {
        favoriteList.reloadData()
    }
}

