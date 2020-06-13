//
//  FavoriteViewPresenter.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/11.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Firebase

class FavoriteViewPresenter {
    let db = Firestore.firestore()
    var shopData: [GourmetData] = []
    private let delegate: FavoriteViewProtocol
       
       init(view: FavoriteViewProtocol) {
           delegate = view
       }
    
    func loadBookmark(id: String) {
        updateShopData()
        db.collection("User").document("\(id)").collection("Bookmark").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Loading error")
            } else {
                for document in querySnapshot!.documents{
                    self.shopData.append(GourmetData(document: document))
                }
            }
            self.delegate.reloadData()
        }
    }
    
    func deleteBookmark(id: String, rowNumber: Int) {
        db.collection("User").document("\(id)").collection("Bookmark").document("\(shopData[rowNumber].documentID)").delete() { (err) in
            if let err = err {
                print("missing delete")
            } else {
                print("delete is succseed")
            }
        }
    }
    
    func updateShopData() {
        shopData.removeAll()
    }
}
