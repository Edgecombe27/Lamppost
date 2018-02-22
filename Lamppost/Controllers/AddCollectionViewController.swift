//
//  AddCollectionViewController.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/21/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit
import ContactsUI

class AddCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CNContactPickerDelegate, UITextFieldDelegate{
    

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewController : ViewController!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:80,height: 130)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        //flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: ContactFlyerCellView.NIB_NAME, bundle: nil), forCellWithReuseIdentifier: ContactFlyerCellView.IDENTIFIER)

        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FlyerCollection.COLLECTION_TYPES.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : ContactFlyerCellView = collectionView.dequeueReusableCell(withReuseIdentifier: ContactFlyerCellView.IDENTIFIER, for: indexPath) as! ContactFlyerCellView
        cell.render(withFlyer: Flyer(title: "Contacts", icon: UIImage(named: "logo-placeholder.png")!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func createButtonPressed(_ sender: Any) {
       
        viewController.blurrView.isHidden = true
        self.dismiss(animated: true, completion: {
            self.viewController.addToCollection(named: self.nameTextField.text!)
        })
        
    }
    
    @IBAction func exitViewTapped(_ sender: Any) {
        viewController.blurrView.isHidden = true
        self.dismiss(animated: true, completion: {
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
