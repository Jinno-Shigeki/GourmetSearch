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
        categoryLabel.shadowColor = UIColor.init(named: "LightOrange")
        categoryLabel.shadowOffset = CGSize(width: 0.7, height: 0.7)
        categoryLabel.layer.shadowRadius = 9
        categoryLabel.layer.shadowOpacity = 1
    }
    func imageSet (imageName: String) {
        categoryImage.image = UIImage(named: imageName)
    }
}
