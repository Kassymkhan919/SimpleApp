//
//  CollectionViewCell.swift
//  SimpleApp
//
//  Created by dev on 8/21/20.
//  Copyright © 2020 dev. All rights reserved.
//
import Firebase
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var stockPrice: UILabel!
    @IBOutlet var indexPrice: UILabel!
    @IBOutlet var companyName: UILabel!
    @IBOutlet var companyDescription: UILabel!
    
    func configure(with companyInfo: CompanyInfo) {
        
        stockPrice.text = "$\(companyInfo.stockPrice)"
        indexPrice.text = "$\(companyInfo.indexPrice)"
        companyName.text = companyInfo.name
        companyDescription.text = companyInfo.description
    }

}
