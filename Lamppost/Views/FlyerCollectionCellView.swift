//
//  FlyerCollectionCellView.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/8/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class FlyerCollectionCellView: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    var collection : FlyerCollection! 
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    var viewController : ViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "ContactFlyerCellView", bundle: nil), forCellWithReuseIdentifier: "contact_flyer_cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:80,height: 130)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ContactFlyerCellView = self.collectionView.dequeueReusableCell(withReuseIdentifier: "contact_flyer_cell", for: indexPath) as! ContactFlyerCellView
        cell.render(withFlyer: collection[indexPath.row])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !viewController.inEditMode {
            let flyer = (collectionView.cellForItem(at: indexPath) as! ContactFlyerCellView).flyer as! ContactFlyer
        
            let contactViewController = ContactDetailViewController()
            contactViewController.flyer = flyer
        
            contactViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            let viewController = self.window?.rootViewController as! ViewController
            viewController.blurrView.isHidden = false
            contactViewController.viewController = viewController
            viewController.present(contactViewController, animated: true, completion: nil)
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! ContactFlyerCellView
            
            if cell.alpha == 1 {
                cell.alpha = 0.4
                if viewController.selectedFlyers[collection.name] == nil{
                    viewController.selectedFlyers[collection.name] = []
                }
                viewController.selectedFlyers[collection.name]?.append(cell.flyer)
                
            } else {
                cell.alpha = 1
                var i = 0
                for flyer in viewController.selectedFlyers[collection.name]! {
                    if flyer.title == cell.flyer.title {
                        viewController.selectedFlyers[collection.name]?.remove(at: i)
                        break
                    }
                    i = i + 1
                }
            }
            
        }
        
    }
    
    func render(withCollection : FlyerCollection) {
        collection = withCollection
        collection.sort()
        collectionView.reloadData()
        sectionLabel.text = collection.name
        
        if viewController.inEditMode && collection.isGroup {
            selectButton.setTitle("select", for: .normal)
            selectButton.isHidden = false
            addButton.isHidden = false
        } else {
           selectButton.isHidden = true
            addButton.isHidden = true
        }
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        viewController.addToCollection(named: collection.name)
    }
    
    @IBAction func selectButtonPressed(_ sender: Any) {
        
        
        if selectButton.titleLabel?.text == "select" {
            selectButton.setTitle("unselect", for: .normal)
            viewController.selectedCollections.append(collection)
            collectionView.alpha = 0.4
        } else {
            selectButton.setTitle("select", for: .normal)
            
            var i = 0
            
            for col in viewController.selectedCollections {
                if col.name == collection.name {
                    viewController.selectedCollections.remove(at: i)
                    break
                }
                i = i + 1
            }
            collectionView.alpha = 1
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
