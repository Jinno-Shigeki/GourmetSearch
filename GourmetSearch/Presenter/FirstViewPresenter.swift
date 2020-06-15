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
    func createID() -> String {
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
                print(err)
            } else {
                print("Success!")
            }
        }
    }
}
