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
        
        iconView.layer.cornerRadius = 10
        iconView.layer.masksToBounds = true
        
        imageView.image = flyer.icon
        label.text = flyer.title
        
        iconView.backgroundColor = getRandomColor()
        
    }
    
    
    func getRandomColor() -> UIColor{
        
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }

}
