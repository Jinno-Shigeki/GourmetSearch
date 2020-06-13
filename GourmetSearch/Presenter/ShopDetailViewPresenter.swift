//
//  ShopDetailViewPresenter.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/11.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Firebase

class ShopDetailViewPresenter {
    let db = Firestore.firestore()
    
    func sendShopData(data: GourmetData, id: String) {
        db.collection("User").document(id).collection("Bookmark").addDocument(data: ["name": data.name, "address": data.address, "opentime": data.opentime, "tel": data.tel, "shopImage": data.shopImage, "location": data.location, "budget": data.budget]) { (err) in
            if let err = err {
                print("adding error")
            } else {
                print("complete!")
                let name: String
            }
        }
    }
}
