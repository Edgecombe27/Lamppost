//
//  TableViewCell.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/12/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class ToolbarCellView: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewController : ViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib(nibName: "ShortcutCellView", bundle: nil), forCellWithReuseIdentifier: "shortcut_cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:UIScreen.main.bounds.width/2-10,height: 30)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.layer.cornerRadius = 15
        collectionView.layer.masksToBounds = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewController.flyerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ShortcutCellView = self.collectionView.dequeueReusableCell(withReuseIdentifier: "shortcut_cell", for: indexPath) as! ShortcutCellView
        cell.render(withCollection: viewController.flyerData[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController.tableView.contentOffset = CGPoint(x: 0, y: (indexPath.row+1)*150-22)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
