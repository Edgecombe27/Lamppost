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
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    static let NIB_NAME = "HeaderCellView"
    static let IDENTIFIER = "header_cell"

    var viewController : ViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: ShortcutCellView.NIB_NAME, bundle: nil), forCellWithReuseIdentifier: ShortcutCellView.IDENTIFIER)
        collectionView.dataSource = self
        collectionView.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:UIScreen.main.bounds.width/4,height: 30)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        deleteButton.isEnabled = false
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewController.flyerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ShortcutCellView = self.collectionView.dequeueReusableCell(withReuseIdentifier: ShortcutCellView.IDENTIFIER, for: indexPath) as! ShortcutCellView
        cell.render(withCollection: viewController.flyerData[indexPath.row], index: indexPath.row)
        //var size : CGFloat = CGFloat(viewController.flyerData[indexPath.row].name.characters.count*5)
        //cell.bounds = CGRect(x: cell.bounds.minX, y: cell.bounds.minY, width: size, height: 30)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController.tableView.contentOffset = CGPoint(x: 0, y: (indexPath.row+1)*150-22)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        let deleteAlert = UIAlertController(title: "Delete flyers", message: "Are you sure you want to delete these flyers?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            self.viewController.deleteSelected()
        })
        
        deleteAlert.addAction(action)
        viewController.present(deleteAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        if viewController.inEditMode {
            deleteButton.isEnabled = false
            editButton.title = "Edit"
            deleteButton.title = ""
            viewController.exitEditMode()
        } else {
            deleteButton.isEnabled = true
            deleteButton.title = "delete"
            editButton.title = "Done"
            viewController.enterEditMode()
        }
        
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        let settingsViewController = SettingsViewController()
        settingsViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        viewController.blurrView.isHidden = false
        settingsViewController.viewController = viewController
        viewController.present(settingsViewController, animated: true, completion: nil)
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
