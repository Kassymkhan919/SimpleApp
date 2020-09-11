//
//  HistoryCellCollectionViewCell.swift
//  SimpleApp
//
//  Created by dev on 8/22/20.
//  Copyright © 2020 dev. All rights reserved.
//

import UIKit

class HistoryCellCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var dateBought: UILabel!
    @IBOutlet var companyName: UILabel!
    @IBOutlet var stockIndexIndicator: UILabel!
    @IBOutlet var priceBought: UILabel!
    
    static let dateFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.dateTimeStyle = .numeric
        return formatter
    }()
    
    func configure(with historyCompany: HistoryCompany){
        companyName.text = historyCompany.companyName
        stockIndexIndicator.text = historyCompany.stockIndexIndicator
        priceBought.text = "\(historyCompany.priceBought)"
        let formatter = HistoryCellCollectionViewCell.dateFormatter.localizedString(for: historyCompany.dateBought.dateValue(), relativeTo: Date())
        dateBought.text = "\(formatter)"
    }
    
}
