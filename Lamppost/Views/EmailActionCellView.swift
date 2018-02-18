//
//  EmailActionCellView.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2018-02-18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class EmailActionCellView: UITableViewCell {

    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var emailButton: UIButton!
    
    var action : ContactAction!
    var flyer : ContactFlyer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func render(withAction: ContactAction, andFlyer: ContactFlyer) {
        action = withAction
        flyer = andFlyer
        
        if !action.label.isEmpty {
            typeLabel.text = "\(action.label):"
        } else {
            typeLabel.text = "Email:"
        }
        emailLabel.text = action.value
    }

    @IBAction func emailButtonPressed(_ sender: Any) {
        flyer.performAction(action: action)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
