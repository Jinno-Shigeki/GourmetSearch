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
    
    init(view: GourmetListViewProtocol) {
        self.view = view
    }
    
    func getGourmetData(word: String, scroll: Bool) {
        if scroll == false {
        refreshData()
        }
        let urlString = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
        let parameters: [String: Any] = ["keyid": "2ab0f587c42b6257ca957161c69732c9","freeword": word, "hit_per_page": 20]
        Alamofire.request(urlString, parameters: parameters).responseJSON {[weak self] (response) in
            guard let self = self else {return}
            if let data = response.data {
                self.parseJson(apiData: data)
                self.apiItems = data.count
            } else if let err = response.error {
                print("error")
            }
            self.view?.reloadData()
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
    func refreshData() {
        gourmetData.removeAll()
    }
}
