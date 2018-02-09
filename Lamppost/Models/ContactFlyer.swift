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
    
    var actions : [String : ()->()]!
    
    var details : [String : Any]
        
    init(title : String, icon : UIImage, details: [String : Any]) {
        self.details = details
        super.init(title: title, icon: icon)
        
        actions = ["Call" : performCallAction,
                    "Message" : performMessageAction,
                    "Email" : performEmailAction,
                    "Address" : performAddressAction]
        
        if details["nickname"] != nil && !(details["nickname"] as!String).isEmpty{
            super.title = details["nickname"] as! String
        } else if details["first_name"] != nil{
            super.title = details["first_name"] as! String
        }
        if details["last_name"] != nil{
            super.title += details["last_name"] as! String
        }
        
        
    }
    
    override func getActions() -> [String] {
        return Array(actions.keys)
    }
    
    override func performAction(action: String) {
        (actions[action] as! () -> ())()
    }
    
    private func performCallAction() {
        let numbers = Array((details["phone_numbers"] as! [String : String]).values)
        let index = Array((details["phone_numbers"] as! [String : String]).values).startIndex
        if let url = URL(string: "tel://\(numbers[index])"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func performMessageAction() {
        let numbers = Array((details["phone_numbers"] as! [String : String]).values)
        let index = Array((details["phone_numbers"] as! [String : String]).values).startIndex
        if let url = URL(string: "sms://\(numbers[index])"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func performEmailAction() {
        if let url = URL(string: "mailto://edge1190@mylaurier.ca"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func performAddressAction() {
        
    }
    
   
    
    
    
}
