//
//  PortfolioViewController.swift
//  SimpleApp
//
//  Created by dev on 9/15/20.
//  Copyright © 2020 dev. All rights reserved.
//
import Firebase
import CodableFirebase
import FirebaseFirestoreSwift
import UIKit

class PortfolioViewController: UIViewController {
    
    private var company: [HistoryCompany] = [] {
        didSet {
//            collectionView.reloadData()
        }
    }
    @IBOutlet var TotalAmount: UILabel!
    @IBOutlet var portfolioCollectionView: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDatabaseListener()
        var sum = 0
        let moneySpentBuyingStocks = 10 * company.count
        for comp in company {
            sum += comp.priceBought
        }
        print(sum)
        print(company.count)
//        var portfolioSum = (moneySpentBuyingStocks / sum) * sum
//        self.TotalAmount.text =
//        "\(portfolioSum)"
        
    }
    
    
    
    func setupDatabaseListener() {
        Firestore.firestore().collection("Portfolio").getDocuments() { (query, error) in
            if let documents = query?.documents {
                self.company = documents.map { document in
                return try! FirestoreDecoder().decode(HistoryCompany.self, from: document.data())
              }
            } else {
                print("Document does not exist")
            }
        }
    }

 
}
