//
//  Flyer.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2018-02-04.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Flyer {
    
    var title : String
    var pos : CGPoint
    var size : CGSize
    var view : FlyerCellView
    var icon : UIImage
    
    init(title : String, icon : UIImage) {
        self.title = title
        self.icon = icon
        pos = CGPoint(x: 0, y: 0)
        size = CGSize(width: 0, height: 0)
        view = FlyerCellView()
        
    }
    
    func getActions() -> [String] {
        return [""]
    }
    
    func updateView() {}
    
    func performAction(action: String) {}
    
}

