//
//  GourmetData.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/07.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation

struct Entity: Decodable {
    var rest: [Rest]
}

struct Rest: Decodable {
    let name: String
    let address: String
    let opentime: String
    let tel: String
    let image_url: ImageUrl
}
struct ImageUrl: Decodable {
    let shop_image1: String
}


    

