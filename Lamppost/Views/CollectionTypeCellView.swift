//
//  CollectionTypeCellView.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/21/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class CollectionTypeCellView: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    var type : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func render(withType : String) {
        type = withType
        typeLabel.text = type
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
