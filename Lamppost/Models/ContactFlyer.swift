//
//  ContactFlyer.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2018-02-05.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class ContactFlyer : Flyer {
    
    let CALL_ACTION = "call_action"
    let MESSAGE_ACTION = "message_action"
    let EMAIL_ACTION = "email_action"
    
    var actions : [ContactAction]!
    
    var details : [String : Any]
        
    init(title : String, icon : UIImage, details: [String : Any]) {
        self.details = details
        super.init(title: title, icon: icon)
        
        if details["nickname"] != nil && !(details["nickname"] as! String).isEmpty {
            super.title = details["nickname"] as! String
        } else if details["first_name"] != nil && !(details["first_name"] as! String).isEmpty {
            super.title = details["first_name"] as! String
            if details["last_name"] != nil {
                let lastName = details["last_name"] as! String
                if !lastName.isEmpty {
                    super.title += " \(lastName[(lastName.startIndex)])."
                }
            }
        } else if details["last_name"] != nil && !(details["last_name"] as! String).isEmpty {
            super.title = details["last_name"] as! String
        } else {
            super.title = "unknown contact"
        }
        
        actions = []
        
        for number in details["phone_numbers"] as! [String : String] {
            actions.append(ContactAction(type: CALL_ACTION, label: number.key, value: number.value))
        }
        
        for email in details["email_addresses"] as! [String : String] {
            actions.append(ContactAction(type: EMAIL_ACTION, label: email.key, value: email.value))
        }
        
        
    }
    
    override func getActions() -> [Action] {
        return actions
    }
    
    override func performAction(action: Action) {
        let contactAction = action as! ContactAction
        switch (contactAction.type) {
            
        case CALL_ACTION :
            performCallAction(action: contactAction)
            break
        case MESSAGE_ACTION :
            performMessageAction(action: contactAction)
            break
        case EMAIL_ACTION :
            performEmailAction(action: contactAction)
            break
        default :
            break
        }
    }
    
    private func performCallAction(action : ContactAction) {
        
        let number = action.value.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            
        }
    }
    
    private func performMessageAction(action : ContactAction) {
        let number = action.value.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "sms://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            
        }
    }
    
    private func performEmailAction(action : ContactAction) {
        if let url = URL(string: "mailto://\(action.value)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func performAddressAction() {
        
    }
    
   
    
    
    
}
