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
    let budget: StringOrInt
    let lunch: StringOrInt
    let image_url: ImageUrl
    let access: Access
    let code: Code
}

extension Rest {
    var budgetValue: String{
        switch self.budget {
        case .int(let int):
            return String(int)
        case .str(let string):
            return string
        }
    }
    var lunchValue: String{
        switch self.lunch {
        case .int(let int):
            return String(int)
        case .str(let string):
            return string
        }
    }
}
    
    struct ImageUrl: Decodable {
        let shop_image1: String
    }
    
    struct Access: Decodable {
        let line: String
        let station: String
        let walk: String
    }
    
    struct Code: Decodable {
        let prefname: String
    }
    
    enum StringOrInt: Decodable {
        case str(String)
        case int(Int)
        
        init(from decoder: Decoder) throws {
            if let value = try? decoder.singleValueContainer().decode(Int.self){
                self = .int(value)
                return
            }
            if let value = try? decoder.singleValueContainer().decode(String.self){
                self = .str(value)
                return
            }
            throw error.missingValue
        }
        enum error: Error {
            case missingValue
    }
}

