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
    
    var flyer : ContactFlyer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        
        imageView.image = flyer.icon
        nameLabel.text = "\(flyer.details["first_name"] as! String) \(flyer.details["last_name"] as! String)"
        if !(flyer.details["nickname"] as! String).isEmpty {
            nameLabel.text = nameLabel.text! + " (\(flyer.details["nickname"] as! String))"
        }
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flyer.getActions().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : HeaderCellView = self.tableView.dequeueReusableCell(withIdentifier: "header_cell", for: indexPath) as! HeaderCellView
        cell.collectionView.reloadData()
        return cell
        
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
