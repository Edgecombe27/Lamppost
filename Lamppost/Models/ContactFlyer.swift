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
    
    var details : [String : Any]
        
    init(title : String, icon : UIImage, details: [String : Any]) {
        self.details = details
        super.init(title: title, icon: icon)
    }
    
    override func performAction(action: Action, options : [String : Any]) {
        switch (action) {
            
        case  ContactAction.CallAction:
            performCallAction(options: options)
            break
        case ContactAction.MessageAction:
            performMessageAction(options: options)
            break
        case ContactAction.EmailAction:
            performEmailAction(options: options)
            break
        case ContactAction.AddressAction:
            performAddressAction(options: options)
            break
        default:
            break
        }
    }
    
    private func performCallAction(options: [String : Any]) {
        if let url = URL(string: "tel://9056375923"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func performMessageAction(options: [String : Any]) {
        if let url = URL(string: "sms://2892591790"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func performEmailAction(options: [String : Any]) {
        
    }
    
    private func performAddressAction(options: [String : Any]) {
        
    }
    
    
    
}
