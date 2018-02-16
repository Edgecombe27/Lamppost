//
//  FlyerCellView.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/8/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class ContactFlyerCellView: FlyerCellView {
    
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func render(withFlyer: Flyer) {
        flyer = withFlyer
        
        imageView.image = nil
        label.text = ""
        
        imageView.layer.cornerRadius = imageView.frame.size.width / 2.25
        imageView.clipsToBounds = true
        
        imageView.image = flyer.icon
        label.text = flyer.title
        
    }
    

}
