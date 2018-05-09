//
//  ContactDetailViewController.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/16/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    var viewController : ViewController!
    var flyer : ContactFlyer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        imageView.image = flyer.icon
        imageView.layer.cornerRadius = imageView.frame.width/2.0
        imageView.clipsToBounds = true
        
        nameLabel.text = "\(flyer.details["first_name"] as! String) \(flyer.details["last_name"] as! String)"
        if !(flyer.details["nickname"] as! String).isEmpty {
            nameLabel.text = nameLabel.text! + " (\(flyer.details["nickname"] as! String))"
        }
        
        
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
