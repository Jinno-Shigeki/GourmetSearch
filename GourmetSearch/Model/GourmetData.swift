//
//  GourmetData.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/09.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation

struct GourmetData {
    let name: String
    let address: String
    let opentime: String
    let tel: String
    let shopImage: String
    
    init (rest: Rest){
        self.name = rest.name
        self.address = rest.address
        self.opentime = rest.opentime
        self.tel = rest.tel
        self.shopImage = rest.image_url.shop_image1
    }
}
