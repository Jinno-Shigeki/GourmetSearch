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
final class BookmarkViewController: UIViewController {
    var presenter: BookmarkViewPresenter!
    var userID = ""
    @IBOutlet private weak var favoriteList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteList.delegate = self
        favoriteList.dataSource = self
        navigationBarLayout()
        presenter = BookmarkViewPresenter(view: self)
        favoriteList.register(UINib(nibName: "ShopListCell", bundle: nil), forCellReuseIdentifier: "cell")
        userID = UserDefaults.standard.string(forKey: "UserID")!
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.loadBookmark(id: userID)
    }
    func navigationBarLayout() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
//MARK: - UITableViewDelegate
extension BookmarkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewController(identifier: "ShopDetailVC") as! ShopDetailViewController
        nextVC.shopData = presenter.shopData[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            UserDefaults.standard.removeObject(forKey: "\(presenter.shopData[indexPath.row].name)")
            print(presenter.shopData[indexPath.row].name)
            presenter.deleteBookmark(id: userID, rowNumber: indexPath.row)
            presenter.shopData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
//MARK: - UITableViewDataSource
extension BookmarkViewController: UITableViewDataSource {
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
        if presenter.shopData[rowNumber].shopImage == "" {
            cell.shopImage.image = UIImage(named: "noImage")
        } else {
            let imageURL = URL(string: presenter.shopData[rowNumber].shopImage)
            cell.shopImage.sd_setImage(with: imageURL)
        }
    }
}
//MARK: - FavoriteViewProtocol
extension BookmarkViewController: FavoriteViewProtocol {
    func reloadData() {
        favoriteList.reloadData()
    }
}

