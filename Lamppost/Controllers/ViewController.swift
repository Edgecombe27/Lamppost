//
//  ViewController.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2018-02-03.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var flyerView: FlyerView!
    
    @IBOutlet weak var flyerView2: FlyerView!
    
    override func viewDidLoad() {
        //Set size of the post
        scrollView.contentSize = CGSize(width: 1000, height: 1000)
        //scrollView.contentOffset = CGPoint(x: 400, y: 400)
        
        var flyer = ContactFlyer(title: "test", icon: UIImage(named: "icons8-basketball-100.png")!, details: ["lol": 9])
        var flyer2 = ContactFlyer(title: "test", icon: UIImage(named: "icons8-bmx-100.png")!, details: ["lol": 9])

        flyerView.render(withFlyer: flyer)
        flyerView2.render(withFlyer: flyer2)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

