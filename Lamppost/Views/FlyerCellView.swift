//
//  FlyerCellView.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/7/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class FlyerCellView: UICollectionViewCell {
    
    var flyer : Flyer!
    
    func render(withFlyer: Flyer) {
        flyer = withFlyer
    }
    
}
