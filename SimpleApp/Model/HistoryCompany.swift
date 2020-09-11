//
//  HistoryCompany.swift
//  SimpleApp
//
//  Created by dev on 8/26/20.
//  Copyright © 2020 dev. All rights reserved.
//
import Firebase
import Foundation

struct HistoryCompany: Codable {
//    let companyInfo: CompanyInfo
    let companyName: String
    let priceBought: Int
    let stockIndexIndicator: String
    let dateBought: Timestamp
    
    enum CodingKeys: String, CodingKey {
        case companyName = "CompanyName"
        case priceBought = "PriceBought"
        case stockIndexIndicator = "StockIndexIndicator"
        case dateBought = "DateBought"
    }
    
    
//    init(companyInfo: CompanyInfo, stockIndexIndicator: String) {
//        self.companyInfo = companyInfo.self
//        self.dateBought = Timestamp(date: Date())
//        self.stockIndexIndicator = stockIndexIndicator
//        self.priceBought = companyInfo.indexPrice
//    }
}
