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
    
    override func updateView() {
        
    }
    
    
    
    
}
