//
//  CategoryCollectionCelll.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/07.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 7
    }
}
