//
//  ViewController.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2018-02-03.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit
import ContactsUI

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate {
    

    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet var blurrView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusBarView: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var selectedCollections : [FlyerCollection]!
    var selectedFlyers : [String : [Flyer]]!
    var selectedCollection : FlyerCollection!
    var userData : UserData!
    var flyerData : [FlyerCollection] = []
    var contactHandler : ContactHandler!
    var inEditMode = false
    
    override func viewDidLoad() {
        //Set size of the post
        
        setUpViews()
        loadUserData()
        
        contactHandler = ContactHandler()
        
    }
    
    
    func setUpViews() {
        let gradient = CAGradientLayer()
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
            statusBarView.bounds = CGRect(x: statusBarView.bounds.minX, y: statusBarView.bounds.minY, width: statusBarView.bounds.width, height: 44)
            gradient.frame = statusBarView.bounds
        } else {
            statusBarView.bounds = CGRect(x: statusBarView.bounds.minX, y: statusBarView.bounds.minY, width: statusBarView.bounds.width, height: 33)
            gradient.frame = statusBarView.bounds
        }
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        statusBarView.layer.mask = gradient
        
        tableView.register(UINib(nibName: "FlyerCollectionCellView", bundle: nil), forCellReuseIdentifier: "flyer_collection_cell")
        
        tableView.register(UINib(nibName: "HeaderCellView", bundle: nil), forCellReuseIdentifier: "header_cell")
        
        self.tableView.rowHeight = 150
        loadingIndicator.layer.cornerRadius = 10
        loadingIndicator.layer.masksToBounds = true
        loadingIndicator.isHidden = true
    }
    
    func loadUserData() {
        userData = UserData()
        
        if userData.isEmpty() {
            noDataLabel.isHidden = false
        } else {
            flyerData = userData.getFlyerData()
            tableView.reloadData()
        }
        
    }
    
    func renderContacts() {
        /*loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        contactHandler.im(completion: { granted in
            if granted {
                self.flyerData = self.contactHandler.generateFlyers()
                self.flyerData.sort { (f1, f2) -> Bool in
                    print(f1.name)
                    return f1.name.compare(f2.name) == .orderedAscending
                }
                
                self.tableView.reloadData()
            }
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
        })*/
    }
    
    func selectContacts() {
        
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contacts.forEach { contact in
            
            selectedCollection.addFlyer(flyer: contactHandler.getFlyerFromContact(contact: contact))
            
        }
        selectedCollection.sort()
        
        userData.addCollection(collection: selectedCollection)
        
        tableView.reloadData()
        
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }
    
    func addToCollection(named: String) {
        
        noDataLabel.isHidden = true
        tableView.reloadData()
        
        for coll in flyerData {
            if coll.name == named {
                selectedCollection = coll
                break
            }
        }
        
        selectContacts()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return flyerData.count+1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section > 0 {
            let cell : FlyerCollectionCellView = self.tableView.dequeueReusableCell(withIdentifier: "flyer_collection_cell", for: indexPath) as! FlyerCollectionCellView
            cell.viewController = self
            cell.render(withCollection: flyerData[indexPath.section-1])
            return cell
        }
        let cell : HeaderCellView = self.tableView.dequeueReusableCell(withIdentifier: "header_cell", for: indexPath) as! HeaderCellView
        cell.viewController = self
        cell.collectionView.reloadData()
        return cell
        
    }
    
    func enterEditMode() {
        inEditMode = true
        selectedCollections = []
        selectedFlyers = [:]
        tableView.reloadData()
    }
    
    func exitEditMode() {
        inEditMode = false
        for collection in selectedCollections {
            userData.removeCollection(collection: collection)
        }
        for collection in selectedFlyers {
            for flyer in collection.value {
                userData.removeFlyer(flyer: flyer, fromCollection: FlyerCollection(withName: collection.key, order: 0, andFlyers: []))
            }
        }
        loadUserData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

