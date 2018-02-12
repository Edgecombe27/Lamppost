//
//  ShortcutCellView.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/12/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class ShortcutCellView: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    var collection : FlyerCollection!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    
    func render(withCollection : FlyerCollection, index: Int) {
        collection = withCollection
        
        label.text = collection.name
        
    }

}
