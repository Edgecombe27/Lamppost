//
//  ContactAction.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2018-02-18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import Foundation

class ContactAction : Action {
    
    var label : String
    var value : String
    
    init(type : String, label : String, value: String) {
        self.label = label
        self.value = value
        super.init(type: type)
    }
}
