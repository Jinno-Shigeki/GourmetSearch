//
//  ShopDetailViewController.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/09.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
import SDWebImage
final class ShopDetailViewController: UIViewController {
    
    var presenter = ShopDetailViewPresenter()
    var shopData: GourmetData?
    
    @IBOutlet private weak var bookmarkButton: UIButton!
    @IBOutlet private weak var shopImage: UIImageView!
    @IBOutlet private weak var shopName: UILabel!
    @IBOutlet private weak var shopDetailList: UITableView!
    
    override func viewDidLoad() {
        shopDetailList.delegate = self
        shopDetailList.dataSource = self
        navigationBarLayout()
        shopDetailList.register(UINib(nibName: "ShopDetailListCell", bundle: nil), forCellReuseIdentifier: "cell")
        shopName.text = shopData?.name
        loadShopImage()
        if let shopName = shopData?.name {
            if UserDefaults.standard.string(forKey: "\(shopName)") != nil {
                bookmarkButton.setImage(UIImage(named: "yellowStar"), for: .normal)
                bookmarkButton.isEnabled = false
            }
        }
    }
    
    @IBAction func registerBookmark(_ sender: UIButton) {
        sender.setImage(UIImage(named: "yellowStar"), for: .normal)
        if let shopName = shopData?.name {
            UserDefaults.standard.set(shopName, forKey: "\(shopName)")
            print(shopName)
        }
        if let shopData = shopData, let user = UserDefaults.standard.string(forKey: "UserID") {
            presenter.sendShopData(data: shopData, id: user)
            sender.isEnabled = false
        }
    }
    
    func loadShopImage() {
        if shopData?.shopImage == "" {
            shopImage.image = UIImage(named: "noImage")
        } else {
            let imageURL = URL(string: shopData?.shopImage ?? "")
            shopImage.sd_setImage(with: imageURL)
        }
    }
    
    func navigationBarLayout() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
//MARK: -
extension ShopDetailViewController: UITableViewDelegate {
    
}
//MARK: -
extension ShopDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShopDetailListCell
        if indexPath.row == 0 {
            cell.detailTitle.text = StaticData.opentime
            cell.titleDetail.text = shopData?.opentime
        } else if indexPath.row == 1 {
            cell.detailTitle.text = StaticData.access
            cell.titleDetail.text = shopData?.location
        } else if indexPath.row == 2 {
            cell.detailTitle.text = StaticData.address
            cell.titleDetail.text = shopData?.address
        } else if indexPath.row == 3 {
            cell.detailTitle.text = StaticData.tel
            cell.titleDetail.text = shopData?.tel
        }
        return cell
    }
}

