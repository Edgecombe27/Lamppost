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
    
    var actions : [String : [String : String]]!
    
    var details : [String : String]
        
    init(title : String, icon : UIImage, details: [String : String]) {
        self.details = details
        super.init(title: title, icon: icon)
        
        if details["nickname"] != nil && !((details["nickname"])?.isEmpty)!{
            super.title = details["nickname"]!
        } else if details["first_name"] != nil{
            super.title = details["first_name"]!
        }
        
        if details["last_name"] != nil {
            let lastName = details["last_name"]
            if !(lastName?.isEmpty)! {
                super.title += " \(lastName![(lastName?.startIndex)!])."
            }
        }
        
        
        
    }
    
    override func getActions() -> [String : [String : String]] {
        return actions
    }
    
    override func performAction(action: String, detail: [String: String]) {
        switch (action) {
            
        case CALL_ACTION :
            performCallAction(detail: detail)
            break
        case MESSAGE_ACTION :
            performMessageAction(detail: detail)
            break
        case EMAIL_ACTION :
            performEmailAction(detail: detail)
            break
        default :
            break
        }
    }
    
    private func performCallAction(detail : [String: String]) {
        if let url = URL(string: "tel://\(detail["phone_number"]!)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func performMessageAction(detail : [String: String]) {
        if let url = URL(string: "sms://\(detail["phone_number"]!)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func performEmailAction(detail : [String: String]) {
        if let url = URL(string: "mailto://\(detail["email_address"]!)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func performAddressAction() {
        
    }
    
   
    
    
    
}
