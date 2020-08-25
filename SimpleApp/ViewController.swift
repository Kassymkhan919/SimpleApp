//
//  ViewController.swift
//  SimpleApp
//
//  Created by dev on 8/19/20.
//  Copyright © 2020 dev. All rights reserved.
//
import FirebaseFirestoreSwift
import Firebase
//import FirebaseDatabase
import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var stockButton: UIButton!
    @IBOutlet var indexButton: UIButton!
    
    
    private var companies: [CompanyInfo] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        db.collection("Companies")
    }
    
    func setupUI() {
        indexButton.layer.cornerRadius = 20
        indexButton.layer.masksToBounds = true
        stockButton.layer.cornerRadius = 20
        stockButton.layer.masksToBounds = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let companyinfo = companies[indexPath.row]
        cell.configure(with: companyinfo)
    
        return cell
    }
    
    @IBAction func didTapStockButton() {
    }
    
    @IBAction func didTapIndexButton() {
    }
    
    
    let companyName = ["Apple"]
    let companyDescription = ["Apple is first 2 trillion dollar company. These guys do know how to get money outta clients by removing charger from iPhone box."]
    
}

