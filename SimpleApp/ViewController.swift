//
//  ViewController.swift
//  SimpleApp
//
//  Created by dev on 8/19/20.
//  Copyright © 2020 dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    @IBOutlet var stockButton: UIButton!
    @IBOutlet var indexButton: UIButton!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.companyDescription.text = companyDescription[indexPath.row]
        cell.companyName.text = companyName[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indexButton.layer.cornerRadius = 20
        indexButton.layer.masksToBounds = true
        stockButton.layer.cornerRadius = 20
        stockButton.layer.masksToBounds = true
    }

    
    @IBAction func didTapStockButton() {
    }
    
    @IBAction func didTapIndexButton() {
    }
    
    
    let companyName = ["Apple"]
    let companyDescription = ["Apple is first 2 trillion dollar company. These guys do know how to get money outta clients by removing charger from iPhone box."]
    
}

