//
//  ContactDetailViewController.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/16/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    var viewController : ViewController!
    var flyer : ContactFlyer!
    var actions : [String : ContactAction] = [:]
    var labels : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: ActionCellView.NIB_NAME, bundle: nil), forCellWithReuseIdentifier: ActionCellView.IDENTIFIER)
        collectionView.dataSource = self
        collectionView.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:100,height: 100)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        
        contentView.layer.masksToBounds = true
        
        imageView.image = flyer.icon
        imageView.layer.cornerRadius = imageView.frame.width/2.0
        imageView.clipsToBounds = true
        
        nameLabel.text = "\(flyer.details["first_name"] as! String) \(flyer.details["last_name"] as! String)"
        if !(flyer.details["nickname"] as! String).isEmpty {
            nameLabel.text = nameLabel.text! + " (\(flyer.details["nickname"] as! String))"
        }
        
        for action in flyer.getActions() as! [ContactAction] {
            if action.type == flyer.CALL_ACTION {
                actions["Call"] = action
                labels.append("Call")
                actions["SMS"] = ContactAction(type: flyer.MESSAGE_ACTION, label: "", value: action.value)
                labels.append("SMS")
            } else if action.type == flyer.EMAIL_ACTION {
                actions["Email"] = action
                labels.append("Email")
            }
        }
        
        labels.sort { (s1, s2) -> Bool in
            if s1 == "Call" {
                return true
            } else if s1 == "SMS" && s2 == "Call" {
                return false
            } else if s1 == "Email" {
                return false
            } else {
                return true
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : ActionCellView = collectionView.dequeueReusableCell(withReuseIdentifier: ActionCellView.IDENTIFIER, for: indexPath) as! ActionCellView
        cell.render(withLabel: labels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let label = labels[indexPath.row]
        flyer.performAction(action: actions[label]!)
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
    

   

}
