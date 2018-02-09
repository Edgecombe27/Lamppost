//
//  ViewController.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2018-02-03.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var flyerData : [FlyerCollection]!
    
    override func viewDidLoad() {
        //Set size of the post
        
        tableView.register(UINib(nibName: "FlyerCollectionCellView", bundle: nil), forCellReuseIdentifier: "flyer_collection_cell")
        tableView.rowHeight = 270
        
        var flyer = ContactFlyer(title: "test", icon: UIImage(named: "icons8-basketball-100.png")!, details: ["lol": 9])
        var flyer2 = ContactFlyer(title: "test", icon: UIImage(named: "icons8-bmx-100.png")!, details: ["lol": 9])
        
        flyerData = [FlyerCollection(withName: "Favorites", andFlyers: [flyer, flyer2, flyer]),
                    FlyerCollection(withName: "Work", andFlyers: [flyer2, flyer, flyer2, flyer]),
                    FlyerCollection(withName: "Friends", andFlyers: [flyer, flyer2, flyer, flyer, flyer])]

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return flyerData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FlyerCollectionCellView = self.tableView.dequeueReusableCell(withIdentifier: "flyer_collection_cell", for: indexPath) as! FlyerCollectionCellView
        cell.render(withCollection: flyerData[indexPath.section])
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

