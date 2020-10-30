//
//  ViewController.swift
//  SimpleApp
//
//  Created by dev on 8/19/20.
//  Copyright © 2020 dev. All rights reserved.
//
import FirebaseFirestoreSwift
import Firebase
import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var stockButton: UIButton!
    @IBOutlet var indexButton: UIButton!
    @IBOutlet var buyTitle: UILabel!
    @IBOutlet var thanksMessage: UILabel!
    
    let db = Firestore.firestore()
    
    private let userDefaults = UserDefaults.standard
    
    private var companies: [CompanyInfo] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var documentIDs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let currentDate = Date()
//        var dateComponent = DateComponents()
//        dateComponent.day = 1
//        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
//        if date > 00:00
//            show new content
        
        
        setupUI()
//        setupDocIds()
//        setupDatabaseListener()
        performFetchIfNeeded()
        

    }
    
    private func performFetchIfNeeded() {
        let today = Date()
        
        if let lastFetchDate = userDefaults.object(forKey: "lastFetchDate") as? Date {
            let areSameDay = Calendar.current.dateComponents([.day], from: lastFetchDate, to: today).day == 0
            if !areSameDay {
//                fetchDocuments()
                setupDatabaseListener()
                userDefaults.set(today, forKey: "lastFetchDate")
            }
        } else {
//            fetchDocuments()
            setupDatabaseListener()
            userDefaults.set(today, forKey: "lastFetchDate")
        }
    }
    
    func setupDocIds() {
        db.collection("companies").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    self.documentIDs.append(document.documentID)
                }
            }
        }
    }
    
    func setupDatabaseListener() {
        db.collection("companies").addSnapshotListener { (snapshot, error) in
                    if let error = error {
        //                self.showError(with: error.localizedDescription)
        //                showError(with: error.localizedDescription)
                    }
                    else if let snapshot = snapshot {
                        self.companies = snapshot.documents.compactMap({ (document) -> CompanyInfo? in
                            let companyinfo = try? document.data(as: CompanyInfo.self)
                            return companyinfo
                        })
                    }
                }

        

        
//        let docRef = db.collection("companies").document("9uUUWDXWzlgQM0sJNDEW")
//        docRef.getDocument { (document, error) in
//            if let error = error {
//                print("Document does not exist")
//
//            } else {
//                self.documentIDs.append(document.data(as: String.self)!)
//            }
//        }
    }
    
    func setupUI() {
        indexButton.layer.cornerRadius = 20
        indexButton.layer.masksToBounds = true
        stockButton.layer.cornerRadius = 20
        stockButton.layer.masksToBounds = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companies.count
//        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyOfTheDayCell", for: indexPath) as! CollectionViewCell
        
        
        let companyinfo = companies[indexPath.row]
        cell.configure(with: companyinfo)
    
        return cell
    }
    
    @IBAction func didTapStockButton() {
        var ref: DocumentReference? = nil
        ref = db.collection("Portfolio").addDocument(data: [
            "CompanyName": companies[0].name,
            "PriceBought": companies[0].stockPrice,
            "StockIndexIndicator": "Stock",
            "DateBought": FieldValue.serverTimestamp(),
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        
        hideButtonAndTitle()
        showThanksMessage()
    }
    
    @IBAction func didTapIndexButton() {
        var ref: DocumentReference? = nil
        ref = db.collection("Portfolio").addDocument(data: [
            "CompanyName": companies[0].name,
            "PriceBought": companies[0].indexPrice,
            "StockIndexIndicator": "Index",
            "DateBought": FieldValue.serverTimestamp(),
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        hideButtonAndTitle()
        showThanksMessage()
    }
    
    func hideButtonAndTitle() {
        stockButton.isHidden = true
        indexButton.isHidden = true
        buyTitle.isHidden = true
    }
    
    func showThanksMessage() {
        thanksMessage.isHidden = false
    }
    
    
    let companyName = ["Apple"]
    let companyDescription = ["Apple is first 2 trillion dollar company. These guys do know how to get money outta clients by removing charger from iPhone box."]
    
}

