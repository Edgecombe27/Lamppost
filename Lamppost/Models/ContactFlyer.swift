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
        
        var number = phoneNumberUrl(number: action.value)
    
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print(phoneNumberUrl(number: action.value))
        }
    }
    
    private func performMessageAction(action : ContactAction) {
        let number = phoneNumberUrl(number: action.value)
        
        if let url = URL(string: "sms://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            
        }
    }
    
    private func phoneNumberUrl(number : String) -> String{
        
        var result = number.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "")
        
        var i = 0
        
        while i < result.characters.count {
            var c = result[result.index(result.startIndex, offsetBy: i)]
            
            if (c != "0" && c != "1" && c != "2" && c != "3" && c != "4" && c != "5" && c != "6" && c != "7" && c != "8" && c != "9" && c != "+") {
                result = result.substring(to: result.index(result.startIndex, offsetBy: i)) + result.substring(from: result.index(result.startIndex, offsetBy: i+1))
            }
            i = i + 1
        }
        
        return result
    }
    
    private func performEmailAction(action : ContactAction) {
        if let url = URL(string: "mailto://\(action.value)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func performAddressAction() {
        
    }
    
   
    
    
    
}
