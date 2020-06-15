//
//  GourmetListViewController.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/09.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
import SDWebImage

protocol GourmetListViewProtocol {
    func reloadData()
}

final class GourmetListViewController: UIViewController {
    @IBOutlet private weak var gourmetSearch: UISearchBar!
    @IBOutlet private weak var shopList: UITableView!
    let toolbar = UIToolbar()
    
    var presenter: GourmetListViewPresenter!
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopList.delegate = self
        shopList.dataSource = self
        gourmetSearch.delegate = self
        viewItemsLayout()
        toolBarCustom()
        shopList.register(UINib(nibName: "ShopListCell", bundle: nil), forCellReuseIdentifier: "cell")
        presenter = GourmetListViewPresenter(view: self)
        gourmetSearch.text = searchText
        presenter.getGourmetData(word: searchText, scroll: false)
    }
    
    private func loadShopImage(row: Int, cell: ShopListCell) {
        if presenter.gourmetData[row].shopImage == "" {
            cell.shopImage.image = UIImage(named: "noImage")
        } else {
            let shopImageURL = URL(string: presenter.gourmetData[row].shopImage)
            cell.shopImage.sd_setImage(with: shopImageURL)
        }
    }
    
    private func viewItemsLayout() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        gourmetSearch.backgroundImage = UIImage()
        gourmetSearch.searchTextField.backgroundColor = .white
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
//MARK: - UITableViewDelegate
extension GourmetListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewController(identifier: "ShopDetailVC") as! ShopDetailViewController
        nextVC.shopData = presenter.gourmetData[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let targetCell = presenter.gourmetData.count - indexPath.row
        if presenter.gourmetData.count >= 20 && targetCell == 3 && presenter.apiItems >= 20{
            presenter.getGourmetData(word: gourmetSearch.text ?? "", scroll: true)
        }
    }
}
//MARK: - UITableViewDataSource
extension GourmetListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.gourmetData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShopListCell
        cell.shopName.text = presenter.gourmetData[indexPath.row].name
        cell.location.text = presenter.gourmetData[indexPath.row].location
        cell.budget.text = presenter.gourmetData[indexPath.row].budget
        loadShopImage(row: indexPath.row, cell: cell)
        return cell
    }
}
//MARK: -
extension GourmetListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            presenter.getGourmetData(word: searchBar.text!, scroll: false)
            searchBar.endEditing(true)
        } else {
            searchBar.placeholder = StaticData.placeholder
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
        searchBar.endEditing(true)
    }
}

//MARK: - GourmetListViewProtocol
extension GourmetListViewController: GourmetListViewProtocol {
    func reloadData() {
        shopList.reloadData()
    }
}

