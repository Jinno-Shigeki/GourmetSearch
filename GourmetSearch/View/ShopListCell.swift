//
//  ShopListCell.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/09.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class ShopListCell: UITableViewCell {

    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var budget: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
