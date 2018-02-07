//
//  Action.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/7/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import Foundation


protocol Action {}

enum ContactAction : Action {
    case CallAction
    case MessageAction
    case EmailAction
    case AddressAction
}

