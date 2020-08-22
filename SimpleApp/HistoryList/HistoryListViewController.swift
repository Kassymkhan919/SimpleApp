//
//  HistoryListViewController.swift
//  SimpleApp
//
//  Created by dev on 8/22/20.
//  Copyright © 2020 dev. All rights reserved.
//

import UIKit

class HistoryListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let companyName = ["Apple", "Google"]
    let dateBought = ["21 August 2020", "22 August 2020"]
    let priceBought = ["199", "150"]
    let stockIndex = ["Stock", "Index"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "historyCell", for: indexPath) as! HistoryCellCollectionViewCell
        
        cell.companyName.text = companyName[indexPath.row]
        cell.dateBought.text = dateBought[indexPath.row]
        cell.priceBought.text = priceBought[indexPath.row]
        cell.stockIndexIndicator.text = stockIndex[indexPath.row]
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "History"
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
