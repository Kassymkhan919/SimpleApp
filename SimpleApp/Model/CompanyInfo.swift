//
//  CompanyInfo.swift
//  SimpleApp
//
//  Created by dev on 8/24/20.
//  Copyright © 2020 dev. All rights reserved.
//
import Firebase
import Foundation

struct CompanyInfo: Codable {
    let description: String
    let name: String
    let indexPrice: Int
    let stockPrice: Int
    
    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case name = "Name"
        case indexPrice = "IndexPrice"
        case stockPrice = "StockPrice"
    }
}
