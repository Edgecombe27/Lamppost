//
//  ViewController.swift
//  kiOSk
//
//  Created by Spencer Edgecombe on 2018-02-03.
//  Copyright © 2018 kiOSK. All rights reserved.
//

import UIKit
import ContactsUI

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate {
    

    @IBOutlet var blurrView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusBarView: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private var selectedCollections : [FlyerCollection]!
    private var selectedFlyers : [String : [Flyer]]!
    private var selectedCollection : FlyerCollection!
    private var userData : UserData!
    private var flyerData : [FlyerCollection] = []
    private var contactHandler : ContactHandler!
    private var inEditMode = false
    
    override func viewDidLoad() {
        //Set size of the post
        
        setUpViews()
        renderContacts()
        
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
        
        tableView.register(UINib(nibName: FlyerCollectionCellView.NIB_NAME, bundle: nil), forCellReuseIdentifier: FlyerCollectionCellView.IDENTIFIER)
        tableView.register(UINib(nibName: HeaderCellView.NIB_NAME, bundle: nil), forCellReuseIdentifier: HeaderCellView.IDENTIFIER)
        self.tableView.rowHeight = 150
        
        loadingIndicator.layer.cornerRadius = 10
        loadingIndicator.layer.masksToBounds = true
        loadingIndicator.isHidden = true
    }
    
    // Loads user data from UserDefaults and populates flyerData with stored data
    func loadUserData() {
        userData = UserData()
        
        if userData.isEmpty() {
            //no saved data
        } else {
            flyerData = userData.getFlyerData()
            tableView.reloadData()
        }
        
    }
    
    // Loads saved data and fetches all contacts to populate flyerData
    func renderContacts() {
        flyerData = []
        contactHandler = ContactHandler()
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        loadUserData()
        contactHandler.requestPermission(completion: { granted in
            if granted {
                self.contactHandler.importContacts()
                self.flyerData.append(contentsOf: self.contactHandler.generateFlyers())
                self.tableView.reloadData()
            }
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
        })
    }
    
    // Adds selected contacts to a new or existing collection
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contacts.forEach { contact in
            
            selectedCollection.addFlyer(flyer: contactHandler.getFlyerFromContact(contact: contact))
            
        }
        selectedCollection.sort()
        selectedCollection.isGroup = true
        
        if !userData.collectionExists(collectionName: selectedCollection.name) {
            flyerData.insert(selectedCollection, at: selectedCollection.order-1)
        }
        
        userData.addCollection(collection: selectedCollection)
        
        tableView.reloadData()
        
    }
    
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
    }
    
    // Creates a new collection or selects existing one with collectionName
    // then launches contact picker to add to that collection
    func addToCollection(named: String) {
        
        if userData.collectionExists(collectionName: named) {
            for coll in flyerData {
                if coll.name == named {
                    selectedCollection = coll
                    break
                }
            }
        } else {
            selectedCollection = FlyerCollection(withName: named, order: UserData.numGroups+1, andFlyers: [])
        }
        
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return flyerData.count+1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Flyer Collection Cells
        if indexPath.section > 0 {
            let cell : FlyerCollectionCellView = self.tableView.dequeueReusableCell(withIdentifier: FlyerCollectionCellView.IDENTIFIER, for: indexPath) as! FlyerCollectionCellView
            cell.viewController = self
            cell.render(withCollection: flyerData[indexPath.section-1])
            return cell
        }
        
        // Header Cell
        let cell : HeaderCellView = self.tableView.dequeueReusableCell(withIdentifier: HeaderCellView.IDENTIFIER, for: indexPath) as! HeaderCellView
        cell.viewController = self
        cell.collectionView.reloadData()
        return cell
        
    }
    
    // Renders edit buttons and clears selected flyers and collections
    func enterEditMode() {
        inEditMode = true
        selectedCollections = []
        selectedFlyers = [:]
        tableView.reloadData()
    }
    
    // Renders normal mode
    func exitEditMode() {
        inEditMode = false
        tableView.reloadData()
    }
    
    func selectCollection(collection: FlyerCollection) {
        selectedCollections.append(collection)
    }
    
    func unselectCollection(collection: FlyerCollection) {
        var i = 0
        
        for col in selectedCollections {
            if col.name == collection.name {
                selectedCollections.remove(at: i)
                break
            }
            i = i + 1
        }
    }
    
    func selectFlyer(flyer : Flyer, collection: FlyerCollection) {
        if selectedFlyers[collection.name] == nil{
            selectedFlyers[collection.name] = []
        }
        selectedFlyers[collection.name]?.append(flyer)
    }
    
    func unselectFlyer(flyer : Flyer, collection : FlyerCollection) {
        var i = 0
        for fly in selectedFlyers[collection.name]! {
            if fly.title == flyer.title {
                selectedFlyers[collection.name]?.remove(at: i)
                break
            }
            i = i + 1
        }
    }
    
    // Removes all selected folders from UserData and flyerData
    func deleteSelected() {
        for collection in selectedCollections {
            userData.removeCollection(collection: collection)
        }
        for collection in selectedFlyers {
            for flyer in collection.value {
                userData.removeFlyer(flyer: flyer, fromCollection: FlyerCollection(withName: collection.key, order: 0, andFlyers: []))
            }
        }
        renderContacts()
        selectedFlyers = [:]
        selectedCollections = []
    }
    
    func isInEditMode() -> Bool{
        return inEditMode
    }
    
    func getFlyerCount() -> Int {
        return flyerData.count
    }
    
    func getCollection(at: Int) -> FlyerCollection {
        return flyerData[at]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

