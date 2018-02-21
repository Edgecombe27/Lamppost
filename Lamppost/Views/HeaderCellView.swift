//
//  HeaderCellView.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/13/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class HeaderCellView: UITableViewCell , UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    var viewController : ViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: "ShortcutCellView", bundle: nil), forCellWithReuseIdentifier: "shortcut_cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:UIScreen.main.bounds.width/4,height: 30)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewController.flyerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ShortcutCellView = self.collectionView.dequeueReusableCell(withReuseIdentifier: "shortcut_cell", for: indexPath) as! ShortcutCellView
        cell.render(withCollection: viewController.flyerData[indexPath.row], index: indexPath.row)
        //var size : CGFloat = CGFloat(viewController.flyerData[indexPath.row].name.characters.count*5)
        //cell.bounds = CGRect(x: cell.bounds.minX, y: cell.bounds.minY, width: size, height: 30)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController.tableView.contentOffset = CGPoint(x: 0, y: (indexPath.row+1)*150-22)
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        if viewController.inEditMode {
            viewController.exitEditMode()
        } else {
            viewController.enterEditMode()
        }
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
            viewController.tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        let addCollectionViewController = AddCollectionViewController()
        addCollectionViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        viewController.blurrView.isHidden = false
        addCollectionViewController.viewController = viewController
        viewController.present(addCollectionViewController, animated: true, completion: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
