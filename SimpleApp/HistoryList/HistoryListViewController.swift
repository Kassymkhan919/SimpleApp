//
//  HistoryListViewController.swift
//  SimpleApp
//
//  Created by dev on 8/22/20.
//  Copyright © 2020 dev. All rights reserved.
//

import FirebaseFirestoreSwift
import Firebase
import CodableFirebase
import UIKit

extension DocumentReference: DocumentReferenceType {}
extension GeoPoint: GeoPointType {}
extension FieldValue: FieldValueType {}
extension Timestamp: TimestampType {}

class HistoryListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let companyName = ["Apple", "Google"]
    let dateBought = ["21 August 2020", "22 August 2020"]
    let priceBought = ["199", "150"]
    let stockIndex = ["Stock", "Index"]
    
    let db = Firestore.firestore()

    
    @IBOutlet var collectionView: UICollectionView!
    
    private var company: [HistoryCompany] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "History"
        
        setupDatabaseListener()
        print(company.count)
        
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
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return company.count
//        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "historyCell", for: indexPath) as! HistoryCellCollectionViewCell
        
        let historyCompany = company[indexPath.row]
        cell.configure(with: historyCompany)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
