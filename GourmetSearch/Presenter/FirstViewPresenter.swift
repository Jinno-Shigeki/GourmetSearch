//
//  FirstViewPresenter.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/06.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Firebase

class FirstViewPresenter {
    let db = Firestore.firestore()
    let category = ["和食","洋食","イタリアン","焼肉","寿司","ラーメン"]
    let shopSystem = ["飲み放題","食べ放題","ランチ","個室","デート"]
    
    func createID() -> String{
        let base = "ABCDEFGHIJKLMNOPQRSTUVWSYNZabcdefghijkhmnopqrstuvwsynz0123456789"
        var createdID = ""
        for _ in 0..<16 {
            let randomElemrnt = base.randomElement()
            createdID += String(randomElemrnt!)
        }
        return createdID
    }
    
    func sendID (id: String) {
        db.collection("User").document("\(id)").setData(["ID" : "\(id)"]) { (err) in
            if let err = err {
                print("Error adding data.")
            } else {
                print("Success!")
            }
        }
    }
}
