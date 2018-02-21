//
//  ViewController.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2018-02-03.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit
import ContactsUI

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate, UIAlertViewDelegate {
    

    @IBOutlet var blurrView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var flyerData : [FlyerCollection] = []
    
    var contactHandler : ContactHandler!
    
    @IBOutlet weak var statusBarView: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        //Set size of the post
        
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
        
        loadingIndicator.layer.cornerRadius = 10
        loadingIndicator.layer.masksToBounds = true
        
        contactHandler = ContactHandler()
        renderContacts()
        
    }
    
    func renderContacts() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        contactHandler.importContacts(completion: { granted in
            if granted {
                self.flyerData = self.contactHandler.generateFlyers()
                self.flyerData.sort { (f1, f2) -> Bool in
                    print(f1.name)
                    return f1.name.compare(f2.name) == .orderedAscending
                }
                
                self.tableView.rowHeight = 150
                self.tableView.reloadData()
            }
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
        })
        
        
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
            cell.render(withCollection: flyerData[indexPath.section-1])
            return cell
        }
        let cell : HeaderCellView = self.tableView.dequeueReusableCell(withIdentifier: "header_cell", for: indexPath) as! HeaderCellView
        cell.viewController = self
        cell.collectionView.reloadData()
        return cell
        
    }
    
    func selectContacts() {
        
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contacts.forEach { contact in
            for number in contact.phoneNumbers {
                let phoneNumber = number.value
                print("number is = \(phoneNumber)")
            }
        }
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

