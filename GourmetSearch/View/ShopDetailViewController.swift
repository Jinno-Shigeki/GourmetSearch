//
//  ShopDetailViewController.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/09.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
import SDWebImage
class ShopDetailViewController: UIViewController {
    
    var shopData: GourmetData?
    @IBOutlet private weak var shopImage: UIImageView!
    @IBOutlet private weak var shopName: UILabel!
    @IBOutlet private weak var shopDetailList: UITableView!
    
    override func viewDidLoad() {
        shopDetailList.delegate = self
        shopDetailList.dataSource = self
        shopDetailList.register(UINib(nibName: "ShopDetailListCell", bundle: nil), forCellReuseIdentifier: "cell")
        shopName.text = shopData?.name
        loadShopImage()
        super.viewDidLoad()
        
    }
    func loadShopImage() {
        let imageURL = URL(string: shopData?.shopImage ?? "")
        shopImage.sd_setImage(with: imageURL)
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

