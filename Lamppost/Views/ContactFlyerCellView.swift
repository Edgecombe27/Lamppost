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
    
    static let NIB_NAME = "ContactFlyerCellView"
    static let IDENTIFIER = "contact_flyer_cell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func render(withFlyer: Flyer) {
        flyer = withFlyer
        
        alpha = 1
        
        imageView.image = nil
        label.text = ""
        
        imageView.layer.cornerRadius = 32.5
        imageView.clipsToBounds = true
        
        imageView.image = flyer.icon
        label.text = flyer.title
        
    }
    

}
