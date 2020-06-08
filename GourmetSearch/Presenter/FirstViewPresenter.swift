//
//  FirstViewPresenter.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/06.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Alamofire

class FirstViewPresenter {
    let category = ["和食","洋食","イタリアン","焼肉","寿司","ラーメン"]
    let shopSystem = ["飲み放題","食べ放題","ランチ","個室","デート"]
    var gourmetData: [GourmetData]  = []
    
    func getGourmetData(word: String) {
        let urlString = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
        let parameters: [String: Any] = ["keyid": "2ab0f587c42b6257ca957161c69732c9","freeword": word, "hit_per_page": 20]
        Alamofire.request(urlString, parameters: parameters).responseJSON {[weak self] (response) in
            guard let self = self else {return}
            if let data = response.data {
                self.parseJson(apiData: data)
            } else if let err = response.error {
                print("error")
            }
        }
    }
    
    func parseJson(apiData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Entity.self, from: apiData)
            decodedData.rest.forEach { (rest) in
                gourmetData.append(GourmetData(rest: rest))
            }
        } catch {
            print("error!")
        }
    }
}
