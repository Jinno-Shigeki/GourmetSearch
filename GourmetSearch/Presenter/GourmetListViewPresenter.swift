//
//  GourmetListViewPresenter.swift
//  GourmetSearch
//
//  Created by 神野成紀 on 2020/06/09.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Alamofire

class GourmetListViewPresenter {
    var gourmetData: [GourmetData]  = []
    private var view: GourmetListViewProtocol?
    var apiItems = 0
    var offsetCount = 1
    
    init(view: GourmetListViewProtocol) {
        self.view = view
    }
    
    func getGourmetData(word: String, scroll: Bool) {
        if scroll == false {
            refreshData()
        }
        let urlString = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
        let parameters: [String: Any] = ["keyid": "12fd216ec6a015eeff6f895b35f74482","freeword": word, "hit_per_page": 20,"offset": offsetCount]
        Alamofire.request(urlString, parameters: parameters).responseJSON {[weak self] (response) in
            guard let self = self else {return}
            if let data = response.data {
                self.parseJson(apiData: data)
            } else if let err = response.error {
                print("error")
            }
            self.offsetCount += 20
            self.view?.reloadData()
        }
    }
    
    func parseJson(apiData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Entity.self, from: apiData)
            apiItems = decodedData.rest.count
            decodedData.rest.forEach { (rest) in
                gourmetData.append(GourmetData(rest: rest))
            }
        } catch {
            print("error!")
        }
    }
    func refreshData() {
        gourmetData.removeAll()
        offsetCount = 1
    }
}
