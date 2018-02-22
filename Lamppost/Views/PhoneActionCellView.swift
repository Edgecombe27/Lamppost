//
//  PhoneActionCellView.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2018-02-18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class PhoneActionCellView: UITableViewCell {

    
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    
    static let NIB_NAME = "PhoneActionCellView"
    static let IDENTIFIER = "phone_action_cell"

    var flyer : ContactFlyer!
    var action : ContactAction!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func render(withAction: ContactAction, andFlyer : ContactFlyer) {
        action = withAction
        flyer = andFlyer
        
        typeLabel.text = "\(action.label):"
        numberLabel.text = action.value
        
    }
    @IBAction func messageButtonPressed(_ sender: Any) {
        flyer.performAction(action: ContactAction(type: flyer.MESSAGE_ACTION, label: action.label, value: action.value))
    }
    
    @IBAction func callButtonPressed(_ sender: Any) {
        flyer.performAction(action: action)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
