//
//  ActionCellView.swift
//  kiOSK
//
//  Created by Spencer Edgecombe on 2018-05-09.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class ActionCellView: UICollectionViewCell {

    @IBOutlet var label: UILabel!
    
    static let NIB_NAME = "ActionCellView"
    static let IDENTIFIER = "action_cell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.layer.cornerRadius = label.frame.width / 2.0
        label.layer.masksToBounds = true
    }
    
    func render(withLabel : String) {
        label.text = withLabel
    }

}
