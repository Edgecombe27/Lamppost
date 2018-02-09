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
        
        collectionView.register(UINib(nibName: "FlyerCellView", bundle: nil), forCellWithReuseIdentifier: "flyer_cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:UIScreen.main.bounds.width/2.5-10,height: 225)
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
        let cell : FlyerCellView = self.collectionView.dequeueReusableCell(withReuseIdentifier: "flyer_cell", for: indexPath) as! FlyerCellView
        cell.render(withFlyer: collection[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let flyer = (collectionView.cellForItem(at: indexPath) as! FlyerCellView).flyer as! ContactFlyer
        
        let actionSheet = UIAlertController(title: flyer.title, message: "Select an option", preferredStyle: .actionSheet)
        
        for action in flyer.getActions() {
            
            actionSheet.addAction(UIAlertAction(title: action, style: .default, handler: { actionSheet in
                flyer.performAction(action: action)
            }))
            
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func render(withCollection : FlyerCollection) {
        collection = withCollection
        collectionView.reloadData()
        sectionLabel.text = collection.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
