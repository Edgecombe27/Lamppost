//
//  FlyerCellView.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/8/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class FlyerCellView: UICollectionViewCell {

    var flyer : Flyer!
    
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func render(withFlyer: Flyer) {
        flyer = withFlyer
        
        imageView.image = nil
        label.text = ""
        
        iconView.layer.cornerRadius = 35
        iconView.layer.masksToBounds = true
        
        imageView.image = flyer.icon
        label.text = flyer.title
        
        iconView.backgroundColor = UIColor.lightGray
        
    }
    

}
