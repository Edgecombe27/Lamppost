//
//  Flyer.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2018-02-04.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import Foundation
import CoreGraphics

protocol Flyer {
    
    var title : String {get set}
    var pos : CGPoint {get set}
    var size : CGSize {get set}
    var view : FlyerView {get set}
    
    func updateView() 
    
}
