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
    
    @IBOutlet weak var sectionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "ContactFlyerCellView", bundle: nil), forCellWithReuseIdentifier: "contact_flyer_cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:80,height: 100)
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
        
        let flyer = (collectionView.cellForItem(at: indexPath) as! ContactFlyerCellView).flyer as! ContactFlyer
        
        let contactViewController = ContactDetailViewController()
        contactViewController.flyer = flyer
        
        contactViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        let viewController = self.window?.rootViewController as! ViewController
        viewController.blurrView.isHidden = false
        contactViewController.viewController = viewController
        viewController.present(contactViewController, animated: true, completion: nil)
        
    }
    
    func render(withCollection : FlyerCollection) {
        collection = withCollection
        collection.sort()
        collectionView.reloadData()
        sectionLabel.text = collection.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
