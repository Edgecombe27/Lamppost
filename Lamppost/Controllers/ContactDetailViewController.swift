//
//  ContactDetailViewController.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/16/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewController : ViewController!
    
    var flyer : ContactFlyer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 75
        tableView.register(UINib(nibName: "EmailActionCellView", bundle: nil), forCellReuseIdentifier: "email_action_cell")
        tableView.register(UINib(nibName: "PhoneActionCellView", bundle: nil), forCellReuseIdentifier: "phone_action_cell")
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flyer.actions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if flyer.actions[indexPath.row].type == flyer.CALL_ACTION {
            let cell : PhoneActionCellView = tableView.dequeueReusableCell(withIdentifier: "phone_action_cell") as! PhoneActionCellView
            cell.render(withAction: flyer.actions[indexPath.row], andFlyer: flyer)
            return cell
        } else {
            let cell : EmailActionCellView = tableView.dequeueReusableCell(withIdentifier: "email_action_cell") as! EmailActionCellView
            cell.render(withAction: flyer.actions[indexPath.row], andFlyer: flyer)
            return cell
        }
        
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
