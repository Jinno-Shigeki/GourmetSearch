//
//  GourmetData.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/09.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Firebase

struct GourmetData {
    let name: String
    let address: String
    let opentime: String
    let tel: String
    let shopImage: String
    let location: String
    let budget: String
    let documentID : String
    
    init(rest: Rest) {
        self.name = rest.name
        self.address = rest.address
        self.opentime = rest.opentime
        self.tel = rest.tel
        self.shopImage = rest.image_url.shop_image1 
        self.location = "[\(rest.code.prefname)] \(rest.access.station) \(rest.access.line) \(rest.access.walk)分"
        self.budget = "⭐︎ \(rest.budgetValue) ☀︎ \(rest.lunchValue)"
        self.documentID = ""
    }
    
    init(document: QueryDocumentSnapshot) {
        self.name = document.get("name") as! String
        self.address = document.get("address") as! String  
        self.opentime = document.get("opentime") as! String
        self.tel = document.get("tel") as! String
        self.shopImage = document.get("shopImage") as! String
        self.location = document.get("location") as! String
        self.budget = document.get("budget") as! String
        self.documentID = document.documentID
    }
}
